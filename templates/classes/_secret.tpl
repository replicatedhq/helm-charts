{{/*
This template serves as a blueprint for all secret objects that are created
within the replicatedLibrary library.
*/}}
{{- define "replicatedLibrary.classes.secret" -}}
  {{- $fullName := include "replicatedLibrary.names.fullname" . -}}
  {{- $secretMapName := $fullName -}}
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
  {{- with (merge ($values.labels | default dict) (include "replicatedLibrary.labels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge ($values.annotations | default dict) (include "replicatedLibrary.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
stringData:
{{- with $values.data }}
  {{- tpl (toYaml .) $ | nindent 2 }}
{{- end }}
{{- end }}
