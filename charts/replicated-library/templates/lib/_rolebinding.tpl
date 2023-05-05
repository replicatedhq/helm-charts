{{/*
This template serves as the blueprint for a RoleBinding object created within the replicated-library library.
*/}}
{{- define "replicated-library.roleBinding" }}
  {{- $values := "" -}}
  {{- if and (hasKey . "ContextValues") (hasKey .ContextValues "roleBinding") -}}
    {{- $values = .ContextValues.roleBinding -}}
  {{- else -}}
    {{- fail "_rolebinding.tpl requires the 'roleBinding' ContextValues to be set" -}}
  {{- end -}}
  {{- $_ := set $.ContextValues "names" (dict "context" "roleBinding") -}}



---
apiVersion: rbac.authorization.k8s.io/v1
{{- $kind := default "RoleBinding" $values.kind -}}
{{- $roleKind := default "Role" -}}
{{- if and (eq $kind "ClusterRoleBinding") (ne $roleKind "ClusterRole") -}}
  {{- fail (printf "Not a valid Role in roleRef (%s); if a ClusterRoleBinding is created, roleRef must be a ClusterRole" $kind) -}}
{{- end }}
kind: {{ $kind }}
metadata:
  name: {{ include "replicated-library.names.fullname" . }}
  {{- with (merge ($values.labels | default dict) (include "replicated-library.labels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge ($values.annotations | default dict) (include "replicated-library.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
subjects:
  {{- with $values.subjects -}}
    {{- range . }}
  - apiGroup: ""
    kind: ServiceAccount
    name: {{ .name }}
    namespace: {{ $.Release.Namespace }}
    {{- end }}
  {{- end }}
roleRef:
  apigroup: rbac.authorization.k8s.io
  kind: {{ $roleKind }}
  name: {{ $values.roleRef.name }}
{{- end }}
