{{/*
The ServiceAccount object to be created.
*/}}
{{- define "replicated-library.serviceAccount" }}
  {{- $values := .Values.serviceAccount -}}
  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.values -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}
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
