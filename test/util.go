package test

import (
	"bytes"
	"fmt"
	"path/filepath"

	"k8s.io/apimachinery/pkg/runtime"
	"k8s.io/kubectl/pkg/scheme"
	testclient "k8s.io/client-go/kubernetes/fake"
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

		objects = append(objects,obj)

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
