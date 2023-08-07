package test

import (
	"bytes"
	"context"
	"fmt"
	"path/filepath"

	appsv1 "k8s.io/api/apps/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime"
	"k8s.io/client-go/kubernetes"
	"k8s.io/kubectl/pkg/scheme"
)

func k8sDecode(data []byte) (runtime.Object, error) {
	decode := scheme.Codecs.UniversalDeserializer().Decode
	obj, _, err := decode(data, nil, nil)
	return obj, err
}

func k8sApply(ctx context.Context, client kubernetes.Interface, yaml []byte) error {
	yamlFiles := bytes.Split(yaml, []byte("---"))
	for _, f := range yamlFiles {
		if len(f) == 0 || string(f) == "\n" {
			continue
		}

		obj, err := k8sDecode(f)
		if err != nil {
			fmt.Println(err)
			continue
		}

		namespace := "default"

		switch o := obj.(type) {
		case *appsv1.Deployment:
			_, err := client.AppsV1().Deployments(namespace).Create(ctx, o, metav1.CreateOptions{})
			if err != nil {
				return err
			}
		}
	}
	return nil
}

func buildChartDependencies(testChartPath string) bool {
	buildDependencies := false

	libraryChart, _ := filepath.Glob(filepath.Join(testChartPath, "charts", "replicated-library-*.tgz"))

	if libraryChart == nil {
		buildDependencies = true
	}

	return buildDependencies
}
