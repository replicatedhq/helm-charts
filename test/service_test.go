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
				"services.example.enabled":                         "true",
				"services.example.appName[0]":                      "example",
				"services.example.ports.http.enabled":              "true",
				"services.example.ports.http.port":                 "8080",
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

		t.Log(deployments)
		t.Log(services)

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
