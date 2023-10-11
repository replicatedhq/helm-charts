package test

import (
	"bytes"
	"fmt"
	"os"
	"path/filepath"
	"testing"

	"github.com/stretchr/testify/require"
	"k8s.io/apimachinery/pkg/runtime"
	testclient "k8s.io/client-go/kubernetes/fake"
	"k8s.io/kubectl/pkg/scheme"
	"sigs.k8s.io/yaml"
)

func k8sDecode(data []byte) (runtime.Object, error) {
	decode := scheme.Codecs.UniversalDeserializer().Decode
	obj, _, err := decode(data, nil, nil)
	return obj, err
}

func fakeCluster(yaml []byte) *testclient.Clientset {
	yamlFiles := bytes.Split(yaml, []byte("---"))
	objects := []runtime.Object{}

	for _, f := range yamlFiles {
		if len(f) == 0 || string(f) == "\n" {
			continue
		}

		obj, err := k8sDecode(f)
		if err != nil {
			fmt.Println(err)
			continue
		}

		//namespace := "default"

		objects = append(objects, obj)

	}

	return testclient.NewSimpleClientset(objects...)

}

func buildChartDependencies(testChartPath string) bool {
	buildDependencies := false

	libraryChart, _ := filepath.Glob(filepath.Join(testChartPath, "charts", "replicated-library-*.tgz"))

	if libraryChart == nil {
		buildDependencies = true
	}

	return buildDependencies
}

func testFixtureData(t *testing.T, name string) []byte {
	t.Helper()

	path, err := filepath.Abs(filepath.Join("../test/fixtures", name))
	require.NoError(t, err)

	dat, err := os.ReadFile(path)
	require.NoError(t, err)

	return dat
}

func AsYAML(t *testing.T, v interface{}) string {
	t.Helper()

	yaml, err := yaml.Marshal(v)
	require.NoError(t, err)

	return string(yaml)
}
