package test

import (
  "path/filepath"
  "testing"
  "strings"

  "github.com/stretchr/testify/require"
  appsv1 "k8s.io/api/apps/v1"

  "github.com/gruntwork-io/terratest/modules/helm"

)
func TestHelmBasicExampleTemplateRenderedDeployment(t *testing.T) {
	t.Parallel()

	// Path to the helm chart we will test
	helmChartPath, err := filepath.Abs("../charts/test")
	releaseName := "release-name"
	require.NoError(t, err)

	// Setup the args. For this test, we will set the following input values:
	// - containerImageRepo=nginx
	// - containerImageTag=1.15.8
	options := &helm.Options{
		SetValues: map[string]string{
			"apps.example.enabled": "true",
			"apps.example.type": "deployment",
			"apps.example.containers.example.image.repository":  "nginx",
			"apps.example.containers.example.image.tag":  "latest",
			"apps.example2.enabled": "true",
			"apps.example2.type": "deployment",
			"apps.example2.containers.example.image.repository":  "nginx",
			"apps.example2.containers.example.image.tag":  "9.9.9",
		},
        BuildDependencies: true,
	}

	// Run RenderTemplate to render the template and capture the output. Note that we use the version without `E`, since
	// we want to assert that the template renders without any errors.
	// Additionally, although we know there is only one yaml file in the template, we deliberately path a templateFiles
	// arg to demonstrate how to select individual templates to render.
	output := helm.RenderTemplate(t, options, helmChartPath, releaseName, []string{"templates/replicated-library.yaml"})

	// Now we use kubernetes/client-go library to render the template output into the Deployment struct. This will
	// ensure the Deployment resource is rendered correctly.
    allDocs := strings.Split(output, "---")
    _, allDocs = allDocs[0], allDocs[1:]
    for i, doc := range allDocs {
	    var deployment appsv1.Deployment
	    helm.UnmarshalK8SYaml(t, doc, &deployment)

	    // Finally, we verify the deployment pod template spec is set to the expected container image value
        var expectedContainerImage string
        if i == 0 {
	        expectedContainerImage = "nginx:latest"
        } else if i == 1 {
          expectedContainerImage = "nginx:9.9.9"
        }
	    deploymentContainers := deployment.Spec.Template.Spec.Containers
	    require.Equal(t, len(deploymentContainers), 1)
	    require.Equal(t, deploymentContainers[0].Image, expectedContainerImage)
    }
}

