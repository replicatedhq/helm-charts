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

func TestService_MatchApp(t *testing.T) {
	tests := []struct {
		name   string
		values map[string]string
	}{
		{
			name: "single app with single container",
			values: map[string]string{
				"apps.example.enabled":                             "true",
				"apps.example.type":                                "deployment",
				"apps.example.containers.example.image.repository": "nginx",
				"apps.example.containers.example.image.tag":        "latest",
			},
		},
	}

	testChartPath, err := filepath.Abs("../test/test-chart")
	releaseName := "release-name"

	for _, tt := range tests {
		options := &helm.Options{
			SetValues:         tt.values,
			BuildDependencies: buildChartDependencies(testChartPath),
		}
		output := helm.RenderTemplate(t, options, testChartPath, releaseName, []string{"templates/replicated-library.yaml"})

		ctx := context.Background()
		client := testclient.NewSimpleClientset()

		err = k8sApply(ctx, client, []byte(output))
		require.NoError(t, err)

		deployments, err := client.AppsV1().Deployments("default").List(ctx, metav1.ListOptions{})
		require.NoError(t, err)

		services, err := client.CoreV1().Services("default").List(ctx, metav1.ListOptions{})
		require.NoError(t, err)

		missingServices := 0

		for _, deployment := range deployments.Items {
			for _, service := range services.Items {
				if service.Spec.Selector["app.kubernetes.io/name"] == deployment.Labels["app.kubernetes.io/name"] {
					continue
				}
				missingServices = missingServices + 1
			}
		}

		require.Equal(t, missingServices, 0)
	}
}
