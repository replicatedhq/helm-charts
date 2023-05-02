{{/*
The ServiceAccount object to be created.
*/}}
{{- define "replicated-library.serviceAccount" }}
  {{- $values := "" -}}
  {{- if and (hasKey . "ContextValues") (hasKey .ContextValues "app") -}}
    {{- $values = .ContextValues.app -}}
  {{- else -}}
    {{- fail "_serviceaccount.tpl requires the 'app' ContextValues to be set" -}}
  {{- end -}}
  {{- $_ := set $.ContextValues "names" (dict "context" "app") -}}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ include "replicated-library.names.serviceAccountName" . }}
  labels: {{- include "replicated-library.labels" $ | nindent 4 }}
  {{- with (merge ($values.serviceAccount.annotations | default dict) (include "replicated-library.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}
