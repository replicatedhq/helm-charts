package test

import (
	"context"
	"path/filepath"
	"testing"

	"github.com/stretchr/testify/require"

	"github.com/gruntwork-io/terratest/modules/helm"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	testclient "k8s.io/client-go/kubernetes/fake"
)

func TestDeployment_ExpectedNumOfContainers(t *testing.T) {
	t.Parallel()

	tests := []struct {
		name               string
		values             map[string]string
		expectedContainers int
	}{
		{
			name: "single app with single container",
			values: map[string]string{
				"apps.example.enabled":                             "true",
				"apps.example.type":                                "deployment",
				"apps.example.containers.example.image.repository": "nginx",
				"apps.example.containers.example.image.tag":        "latest",
			},
			expectedContainers: 1,
		},
		{
			name: "single app with multiple containers",
			values: map[string]string{
				"apps.example.enabled":                              "true",
				"apps.example.type":                                 "deployment",
				"apps.example.containers.example.image.repository":  "nginx",
				"apps.example.containers.example.image.tag":         "latest",
				"apps.example.containers.example2.image.repository": "nginx",
				"apps.example.containers.example2.image.tag":        "9.9.9",
			},
			expectedContainers: 2,
		},
		{
			name: "multiple apps with a single container",
			values: map[string]string{
				"apps.example.enabled":                              "true",
				"apps.example.type":                                 "deployment",
				"apps.example.containers.example.image.repository":  "nginx",
				"apps.example.containers.example.image.tag":         "latest",
				"apps.example2.enabled":                             "true",
				"apps.example2.type":                                "deployment",
				"apps.example2.containers.example.image.repository": "nginx",
				"apps.example2.containers.example.image.tag":        "9.9.9",
			},
			expectedContainers: 2,
		},
	}

	helmChartPath, err := filepath.Abs("../charts/test")
	releaseName := "release-name"

	for _, tt := range tests {
		options := &helm.Options{
			SetValues:         tt.values,
			BuildDependencies: false,
		}

		output := helm.RenderTemplate(t, options, helmChartPath, releaseName, []string{"templates/replicated-library.yaml"})

		ctx := context.Background()
		client := testclient.NewSimpleClientset()

		err = k8sApply(ctx, client, []byte(output))
		require.NoError(t, err)

		deployments, err := client.AppsV1().Deployments("default").List(ctx, metav1.ListOptions{})
		require.NoError(t, err)

		totalContainers := 0

		for _, deployment := range deployments.Items {
			totalContainers = totalContainers + len(deployment.Spec.Template.Spec.Containers)
		}
		require.Equal(t, tt.expectedContainers, totalContainers)
	}
}

func TestDeployment_ExpectedImages(t *testing.T) {
	//t.Parallel()

	tests := []struct {
		name          string
		values        map[string]string
		expectedImage string
	}{
		{
			name: "nginx latest",
			values: map[string]string{
				"apps.example.enabled":                             "true",
				"apps.example.type":                                "deployment",
				"apps.example.containers.example.image.repository": "nginx",
				"apps.example.containers.example.image.tag":        "latest",
			},
			expectedImage: "nginx:latest",
		},
		{
			name: "nginx 9.9.9",
			values: map[string]string{
				"apps.example.enabled":                             "true",
				"apps.example.type":                                "deployment",
				"apps.example.containers.example.image.repository": "nginx",
				"apps.example.containers.example.image.tag":        "9.9.9",
			},
			expectedImage: "nginx:9.9.9",
		},
	}

	helmChartPath, err := filepath.Abs("../charts/test")
	releaseName := "release-name"

	for _, tt := range tests {
		options := &helm.Options{
			SetValues:         tt.values,
			BuildDependencies: false,
		}

		output := helm.RenderTemplate(t, options, helmChartPath, releaseName, []string{"templates/replicated-library.yaml"})

		ctx := context.Background()
		client := testclient.NewSimpleClientset()

		err = k8sApply(ctx, client, []byte(output))
		require.NoError(t, err)

		deployment, err := client.AppsV1().Deployments("default").Get(ctx, "release-name-test-example", metav1.GetOptions{})
		require.NoError(t, err)

		actualImage := deployment.Spec.Template.Spec.Containers[0].Image
		require.Equal(t, tt.expectedImage, actualImage)
	}
}
