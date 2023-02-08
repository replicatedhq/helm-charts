{{/*
The ServiceAccount object to be created.
*/}}
{{- define "replicatedLibrary.serviceAccount" }}
  {{- $name := "default-app" }}
  {{- $values := .Values.serviceAccount -}}
  {{- if hasKey . "AppName" -}}
    {{- $name = .AppName -}}
  {{ end -}}

  {{- if hasKey . "AppValues" -}}
    {{- with .AppValues.app -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ include "replicatedLibrary.names.serviceAccountName" . }}
  labels: {{- include "replicatedLibrary.labels" $ | nindent 4 }}
  {{- with (merge ($values.serviceAccount.annotations | default dict) (include "replicatedLibrary.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}
