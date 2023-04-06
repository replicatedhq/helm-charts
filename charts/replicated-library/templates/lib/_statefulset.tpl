{{/*
This template serves as the blueprint for the StatefulSet objects that are created
within the common library.
*/}}
{{- define "replicated-library.statefulset" }}
  {{- $values := . -}}
  {{- if hasKey . "AppValues" -}}
    {{- with .AppValues.app -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ include "replicated-library.names.appname" . }}
  {{- with (merge ($values.labels | default dict) (include "replicated-library.labels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge ($values.annotations | default dict) (include "replicated-library.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  revisionHistoryLimit: {{ $values.revisionHistoryLimit }}
  replicas: {{ $values.replicas }}
  podManagementPolicy: {{ default "OrderedReady" $values.podManagementPolicy }}
  {{- $strategy := default "RollingUpdate" $values.strategy }}
  {{- if and (ne $strategy "OnDelete") (ne $strategy "RollingUpdate") }}
    {{- fail (printf "Not a valid strategy type for StatefulSet (%s)" $strategy) }}
  {{- end }}
  updateStrategy:
    type: {{ $strategy }}
    {{- if and (eq $strategy "RollingUpdate") $values.rollingUpdate.partition}}
    rollingUpdate:
      partition: {{ $values.rollingUpdate.partition }}
    {{- end }}
  selector:
    matchLabels:
      {{- include "replicated-library.labels.selectorLabels" . | nindent 6 }}
  serviceName: {{ include "replicated-library.names.fullname" . }}
  template:
    metadata:
      {{- with include ("replicated-library.podAnnotations") . }}
      annotations:
        {{- . | nindent 8 }}
      {{- end }}
      labels:
        {{- include "replicated-library.labels.selectorLabels" . | nindent 8 }}
        {{- with $values.podLabels }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
    spec:
      {{- include "replicated-library.pod" . | nindent 6 }}
  volumeClaimTemplates:
     {{- range $index, $vct := $values.volumeClaimTemplates }}
     - metadata:
         name: {{ $vct.name }}
       spec:
         accessModes:
           - {{ required (printf "accessMode is required for vCT %v" $vct.name) $vct.accessMode  | quote }}
         resources:
           requests:
             storage: {{ required (printf "size is required for PVC %v" $vct.name) $vct.size | quote }}
         {{- if $vct.storageClass }}
         storageClassName: {{ if (eq "-" $vct.storageClass) }}""{{- else }}{{ $vct.storageClass | quote }}{{- end }}
        {{- end }}
    {{- end }}
{{- end }}
