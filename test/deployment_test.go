package test

import (
	"context"
	"path/filepath"
	"testing"

	"github.com/stretchr/testify/require"

	"github.com/gruntwork-io/terratest/modules/helm"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

func TestDeployment_ExpectedNumOfContainers(t *testing.T) {
	tests := []struct {
		name               string
		valuesFiles        []string
		expectedContainers int
	}{
		{
			name: "single app with single container",
			valuesFiles: []string{"test-values/single_app_with_single_container.yaml"},
			expectedContainers: 1,
		},
		{
			name: "single app with multiple containers",
			valuesFiles: []string{"test-values/single_app_with_multiple_containers.yaml"},
			expectedContainers: 2,
		},
		{
			name: "multiple apps with a single container",
			valuesFiles: []string{"test-values/multiple_apps_with_single_container.yaml"},
			expectedContainers: 2,
		},
	}

	testChartPath, err := filepath.Abs("../test/test-chart")
	require.NoError(t, err)

	releaseName := "release-name"

	for _, tt := range tests {
		options := &helm.Options{
			ValuesFiles:         tt.valuesFiles,
			BuildDependencies: buildChartDependencies(testChartPath),
		}
		output := helm.RenderTemplate(t, options, testChartPath, releaseName, []string{"templates/replicated-library.yaml"})

		ctx := context.Background()
		client := fakeCluster([]byte(output))

		deployments, err := client.AppsV1().Deployments("").List(ctx, metav1.ListOptions{})
		require.NoError(t, err)

		totalContainers := 0

		for _, deployment := range deployments.Items {
			totalContainers = totalContainers + len(deployment.Spec.Template.Spec.Containers)
		}
		require.Equal(t, tt.expectedContainers, totalContainers)
	}
}

func TestDeployment_ExpectedImages(t *testing.T) {
	tests := []struct {
		name          string
		values        map[string]string
		valuesFiles []string
		expectedImage string
	}{
		{
			name: "nginx latest",
			valuesFiles: []string{"test-values/single_app_with_single_container.yaml"},
			expectedImage: "nginx:latest",
		},
		{
			name: "nginx 9.9.9",
			valuesFiles: []string{"test-values/single_app_with_single_container.yaml"},
			values: map[string]string{
				"apps.example.containers.example.image.tag":        "9.9.9",
			},
			expectedImage: "nginx:9.9.9",
		},
	}

	testChartPath, err := filepath.Abs("../test/test-chart")
	releaseName := "release-name"

	for _, tt := range tests {
		options := &helm.Options{
			ValuesFiles: tt.valuesFiles,
			SetValues:         tt.values,
			BuildDependencies: buildChartDependencies(testChartPath),
		}
		output := helm.RenderTemplate(t, options, testChartPath, releaseName, []string{"templates/replicated-library.yaml"})

		ctx := context.Background()
		client := fakeCluster([]byte(output))
		require.NoError(t, err)

		deployment, err := client.AppsV1().Deployments("").Get(ctx, "release-name-test-example", metav1.GetOptions{})
		require.NoError(t, err)

		actualImage := deployment.Spec.Template.Spec.Containers[0].Image
		require.Equal(t, tt.expectedImage, actualImage)
	}
}
