package main

import data.kubernetes

name = input.metadata.name

# Multiple resource types

required_labels {
	input.metadata.labels["app.kubernetes.io/name"]
	input.metadata.labels["app.kubernetes.io/instance"]
	input.metadata.labels["app.kubernetes.io/version"]
	input.metadata.labels["app.kubernetes.io/managed-by"]
  input.metadata.labels["helm.sh/chart"]
}

required_selectors {
	input.spec.selector["app.kubernetes.io/name"]
	input.spec.selector["app.kubernetes.io/instance"]
}

# Deployment

deny[msg] {
	kubernetes.is_deployment
	not required_labels

  # TODO: improve the error message?
	msg = sprintf("Deployment %s must provide Kubernetes recommended labels", [name])
}

deny[msg] {
	kubernetes.is_deployment
	not required_selectors

	msg = sprintf("Deployment %s must provide app.kubernetes.io/name and app.kubernetes.io/instance labels for pod selectors", [name])
}

# Secret

# TODO: finish

# Service

deny[msg] {
	kubernetes.is_service
	not required_labels

  # TODO: improve the error message?
	msg = sprintf("Service %s must provide Kubernetes recommended labels", [name])
}

deny[msg] {
	kubernetes.is_service
	not required_selectors

	msg = sprintf("Service %s must provide app.kubernetes.io/name and app.kubernetes.io/instance labels for pod selectors", [name])
}
