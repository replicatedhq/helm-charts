package test

import (
	"context"
	"path/filepath"
	"testing"

	"github.com/stretchr/testify/require"

	"github.com/gruntwork-io/terratest/modules/helm"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

func TestService_MatchApp(t *testing.T) {
	tests := []struct {
		name        string
		valuesFiles []string
	}{
		{
			name:        "single app with single container",
			valuesFiles: []string{"test-values/single_app_with_service.yaml"},
		},
	}

	testChartPath, err := filepath.Abs("../test/test-chart")
	require.NoError(t, err)

	releaseName := "release-name"

	for _, tt := range tests {
		options := &helm.Options{
			ValuesFiles:       tt.valuesFiles,
			BuildDependencies: buildChartDependencies(testChartPath),
		}
		output := helm.RenderTemplate(t, options, testChartPath, releaseName, []string{"templates/replicated-library.yaml"})

		ctx := context.Background()
		client := fakeCluster([]byte(output))

		deployments, err := client.AppsV1().Deployments("").List(ctx, metav1.ListOptions{})
		require.NoError(t, err)

		services, err := client.CoreV1().Services("").List(ctx, metav1.ListOptions{})
		require.NoError(t, err)

		missingServices := 0

		for _, deployment := range deployments.Items {
			found := false
			//t.Log(deployment.Spec.Template.Labels)
			for _, service := range services.Items {
				t.Log(service)
				if service.Spec.Selector["app.kubernetes.io/name"] == deployment.Spec.Template.Labels["app.kubernetes.io/name"] {
					found = true
					break
				}
			}
			if !found {
				missingServices++
			}
		}

		require.Equal(t, 0, missingServices)
	}
}
