{{/*
This template serves as the blueprint for the Deployment objects that are created
within the replicatedLibrary library.
*/}}
{{- define "replicatedLibrary.deployment" }}
  {{- $values := . -}}
  {{- if hasKey . "AppName" -}}
    {{- $name = .AppName -}}
  {{ end -}}

  {{- if hasKey . "AppValues" -}}
    {{- with .AppValues.app -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $name
  {{- with (merge ($values.labels | default dict) (include "replicatedLibrary.labels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge ($values.annotations | default dict) (include "replicatedLibrary.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  revisionHistoryLimit: {{ $values.revisionHistoryLimit }}
  replicas: {{ $values.replicas }}
  {{- $strategy := default "Recreate" $values.strategy }}
  {{- if and (ne $strategy "Recreate") (ne $strategy "RollingUpdate") }}
    {{- fail (printf "Not a valid strategy type for Deployment (%s)" $strategy) }}
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
      {{- include "replicatedLibrary.labels.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      {{- with include ("replicatedLibrary.podAnnotations") $values }}
      annotations:
        {{- . | nindent 8 }}
      {{- end }}
      labels:
        {{- include "replicatedLibrary.labels.selectorLabels" . | nindent 8 }}
        {{- with .Values.podLabels }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
    spec:
      {{- include "replicatedLibrary.pod" $values | nindent 6 }}
{{- end }}
