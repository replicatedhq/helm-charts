{{/* Expand the name of the chart */}}
{{- define "replicated-library.names.name" -}}
  {{- $globalNameOverride := "" -}}
  {{- if hasKey .Values "global" -}}
    {{- $globalNameOverride = (default $globalNameOverride .Values.global.nameOverride) -}}
  {{- end -}}
  {{- default .Chart.Name (default .Values.nameOverride $globalNameOverride) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "replicated-library.names.fullname" -}}
  {{- $name := include "replicated-library.names.name" . -}}
  {{- $globalFullNameOverride := "" -}}
  {{- if hasKey .Values "global" -}}
    {{- $globalFullNameOverride = (default $globalFullNameOverride .Values.global.fullnameOverride) -}}
  {{- end -}}
  {{- if or .Values.fullnameOverride $globalFullNameOverride -}}
    {{- $name = default .Values.fullnameOverride $globalFullNameOverride -}}
  {{- else -}}
    {{- if contains $name .Release.Name -}}
      {{- $name = .Release.Name -}}
    {{- else -}}
      {{- $name = printf "%s-%s" .Release.Name $name -}}
    {{- end -}}
  {{- end -}}
  {{- trunc 63 $name | trimSuffix "-" -}}
{{- end -}}

{{/* Create chart name and version as used by the chart label */}}
{{- define "replicated-library.names.chart" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Create the name of the ServiceAccount to use */}}
{{- define "replicated-library.names.serviceAccountName" -}}
  {{- $name := "default" }}
  {{- $values := .Values.serviceAccount -}}
  {{- if hasKey . "AppName" -}}
    {{- $name = .AppName -}}
  {{ end -}}

  {{- if hasKey . "AppValues" -}}
    {{- with .AppValues.app -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}

  {{- if $values.serviceAccount -}}
    {{- if $values.serviceAccount.create -}}
      {{- default (include "replicated-library.names.fullname" .) $values.serviceAccount.name -}}
    {{- else -}}
      {{- default "default" $values.serviceAccount.name -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/* Get name of current app */}}
{{- define "replicated-library.names.appname" -}}
  {{- $name := include "replicated-library.names.name" . -}}
  {{- if hasKey . "AppName" -}}
    {{- $name = .AppName -}}
  {{ end -}}
  {{- trunc 63 $name | trimSuffix "-" -}}
{{- end -}}

{{/* Get name of current service */}}
{{- define "replicated-library.names.servicename" -}}
  {{- $name := "default" -}}
  {{- if hasKey . "ObjectName" -}}
    {{- $name = .ObjectName -}}
  {{- else -}}
    {{- fail (printf "not found (%s)" .ObjectName) }}
  {{ end -}}
  {{- trunc 63 $name | trimSuffix "-" -}}
{{- end -}}
