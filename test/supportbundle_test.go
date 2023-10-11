package test

import (
	"path/filepath"
	"reflect"
	"testing"

	"github.com/gruntwork-io/terratest/modules/helm"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	v1 "k8s.io/api/core/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"
	"k8s.io/apimachinery/pkg/util/yaml"
	"k8s.io/client-go/kubernetes/scheme"
)

func TestSupportBundle_DefaultSpec(t *testing.T) {
	// - Generate template using supportbundle chart values file
	testChartPath, err := filepath.Abs("../test/test-chart")
	require.NoError(t, err)

	options := &helm.Options{
		ValuesFiles:       []string{"test-values/default_support_bundle_enabled.yaml"},
		BuildDependencies: buildChartDependencies(testChartPath),
	}
	output, err := helm.RenderTemplateE(t, options, testChartPath, "release-name", []string{"templates/replicated-library.yaml"})
	require.NoError(t, err)

	// - Read sample SB into map object
	expected := map[string]interface{}{}
	err = yaml.Unmarshal(testFixtureData(t, "default_support_bundle.yaml"), &expected)
	require.NoError(t, err)

	// - Read rendered SB into map object
	actual := map[string]interface{}{}
	err = yaml.Unmarshal(specFromData(t, []byte(output)), &actual)
	require.NoError(t, err)

	// - Compare map objects
	assert.True(t, reflect.DeepEqual(actual, expected))
}

func specFromData(t *testing.T, raw []byte) []byte {
	decode := scheme.Codecs.UniversalDeserializer().Decode
	obj, _, err := decode(raw, nil, nil)
	require.NoError(t, err)

	require.Equal(t,
		obj.GetObjectKind().GroupVersionKind(),
		schema.GroupVersionKind(schema.GroupVersionKind{Group:"", Version:"v1", Kind:"Secret"}),
	)

	secret := obj.(*v1.Secret)

	return []byte(secret.StringData["support-bundle-spec"])
}
