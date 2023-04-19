{{/*
This template serves as the blueprint for the StatefulSet objects that are created
within the replicated library.
*/}}
{{- define "replicated-library.firstservice" -}}
  {{- $appName := include "replicated-library.names.appname" . }}
  {{- $matchingServices := list }}
  {{- range $name, $values := .Values.services }}
    {{- if eq $values.appName $appName }}
      {{- $serviceName := "" }}
      {{- if $values.fullNameOverride }}
        {{- $serviceName = $values.fullNameOverride }}
      {{- else }}
        {{- $serviceName = printf "%s-%s" (include "replicated-library.names.prefix" $) $name -}}
      {{- end }}
      {{- $matchingServices = append $matchingServices $serviceName }}
    {{- end }}
  {{- end }}
  {{- if len $matchingServices }}
    {{- first $matchingServices }}
  {{- end }}
{{- end }}
{{- define "replicated-library.statefulset" }}
  {{- $values := . -}}
  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.values -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}
---
apiVersion: apps/v1
kind: StatefulSet
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
  podManagementPolicy: {{ default "OrderedReady" $values.podManagementPolicy }}
  {{- $strategy := default "RollingUpdate" $values.strategy }}
  {{- if and (ne $strategy "OnDelete") (ne $strategy "RollingUpdate") }}
    {{- fail (printf "Not a valid strategy type for StatefulSet (%s)" $strategy) }}
  {{- end }}
  updateStrategy:
    type: {{ $strategy }}
    {{- if and (eq $strategy "RollingUpdate") (and $values.rollingUpdate $values.rollingUpdate.partition) }}
    rollingUpdate:
      partition: {{ $values.rollingUpdate.partition }}
    {{- end }}
  selector:
    matchLabels:
      {{- include "replicated-library.labels.selectorLabels" . | nindent 6 }}
  {{- $serviceName := default (include "replicated-library.firstservice" .) ($values.serviceName) }}
  {{- if and $values.serviceName (get (get $.Values "services") $values.serviceName) }}
  {{- if (get (get (get $.Values "services") $values.serviceName) "enabled") }}
  {{- $serviceName = printf "%s-%s" (include "replicated-library.names.prefix" .) $serviceName }}
  {{- end }}
  {{- end }}
  serviceName: {{ required "Statefulsets must have a service mapped to it or provided via serviceName" $serviceName }}
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
  {{- if $values.volumeClaimTemplates }}
  volumeClaimTemplates:
  {{- range $name, $vct := $values.volumeClaimTemplates }}
  - metadata:
      name: {{ $name }}
    spec:
      {{- toYaml $vct.spec | nindent 6 }}
  {{- end }}
  {{- end }}
{{- end }}
