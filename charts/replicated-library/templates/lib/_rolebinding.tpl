{{/*
This template serves as the blueprint for a RoleBinding object created within the replicated-library library.
*/}}
{{- define "replicated-library.roleBinding" }}



---
apiVersion: rbac.authorization.k8s.io/v1
kind: # clusterRoleBinding or RoleBinding
metadata:
  name: {{ include "replicated-library.names.fullname" . }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge ($values.annotations | default dict) (include "replicated-library.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
subjects: #
roleRef: #
