{{/*
This template serves as a blueprint for all secret objects that are created
within the replicated-library library.
*/}}
{{- define "replicated-library.classes.secret" -}}
  {{- $fullName := include "replicated-library.names.fullname" . -}}
  {{- $secretName := $fullName -}}
  {{- $values := .Values.secret -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.secret -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}

  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- $secretMapName = printf "%v-%v" $secretMapName $values.nameOverride -}}
  {{- end }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretMapName }}
  {{- with (merge ($values.labels | default dict) (include "replicated-library.labels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge ($values.annotations | default dict) (include "replicated-library.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
stringData:
{{- with $values.data }}
  {{- tpl (toYaml .) $ | nindent 2 }}
{{- end }}
{{- end }}
