package kubernetes

is_pod {
	input.kind = "Pod"
}

is_secret {
	input.kind = "Secret"
}

is_service {
	input.kind = "Service"
}

is_deployment {
	input.kind = "Deployment"
}
