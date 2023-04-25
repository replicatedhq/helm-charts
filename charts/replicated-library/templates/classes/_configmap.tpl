{{/*
This template serves as a blueprint for all configMap objects that are created
within the replicated-library library.
*/}}
{{- define "replicated-library.classes.configmap" -}}
  {{- $configMapName := include "replicated-library.names.fullname" . -}}
  {{- $values := .Values.configmaps -}}

  {{- if hasKey . "ObjectName" -}}
    {{- $configMapName = .ObjectName -}}
  {{ end -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.configmapValues -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "replicated-library.names.fullname" . }}
  {{- with (merge ($values.labels | default dict) (include "replicated-library.labels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge ($values.annotations | default dict) (include "replicated-library.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
data:
{{- with $values.data }}
  {{- tpl (toYaml .) $ | nindent 2 }}
{{- end }}
{{- end }}
