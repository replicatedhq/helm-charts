{{/*
This template serves as a blueprint for all PersistentVolumeClaim objects that are created
within the replicated-library library.
*/}}
{{- define "replicated-library.classes.pvc" -}}
{{- $pvcName := include "replicated-library.names.fullname" . -}}
{{- $values := .Values.persistence -}}

  {{- if hasKey . "ObjectName" -}}
    {{- $pvcName = .ObjectName -}}
  {{ end -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.values -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}

{{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
  {{- if not (eq $values.nameOverride "-") -}}
    {{- $pvcName = printf "%v" $pvcName -}}
  {{ end -}}
{{ end }}
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ include "replicated-library.names.fullname" . }}
  {{- with (merge ($values.labels | default dict) (include "replicated-library.labels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  annotations:
    {{- with (merge ($values.annotations | default dict) (include "replicated-library.annotations" $ | fromYaml)) }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
{{- with $values.persistentVolumeClaim.spec }}
spec:
    {{- toYaml . | nindent 4 }}
{{- end }}
{{- end -}}
