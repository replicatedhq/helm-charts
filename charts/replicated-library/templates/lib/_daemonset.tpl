{{/*
This template serves as the blueprint for the DaemonSet objects that are created
within the replicated-library library.
*/}}
{{- define "replicated-library.DaemonSet" }}
  {{- $name := .Values.global.nameOverride -}}
  {{- if hasKey . "ObjectName" -}}
    {{- $name = .ObjectName -}}
  {{ end -}}

  {{- $values := . -}}
  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.values -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: {{ include "replicated-library.names.fullname" . }}
  {{- with (merge ($values.labels | default dict) (include "replicated-library.labels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge ($values.annotations | default dict) (include "replicated-library.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  revisionHistoryLimit: {{ $values.revisionHistoryLimit }}
  replicas: {{ $values.replicas }}
  {{- $strategy := default $.Values.defaults.strategy $values.strategy }}
  {{- if and (ne $strategy "Recreate") (ne $strategy "RollingUpdate") }}
    {{- fail (printf "Not a valid strategy type for DaemonSet (%s)" $strategy) }}
  {{- end }}
  strategy:
    type: {{ $strategy }}
    {{- with $values.rollingUpdate }}
      {{- if and (eq $strategy "RollingUpdate") (or .surge .unavailable) }}
    rollingUpdate:
        {{- with .unavailable }}
      maxUnavailable: {{ . }}
        {{- end }}
        {{- with .surge }}
      maxSurge: {{ . }}
        {{- end }}
      {{- end }}
    {{- end }}
  selector:
    matchLabels:
      {{- include "replicated-library.labels.selectorLabels" . | nindent 6 }}
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
{{- end }}
