{{/* Expand the name of the chart */}}
{{- define "replicated-library.names.name" -}}
  {{- $globalNameOverride := "" -}}
  {{- if hasKey .Values "global" -}}
    {{- $globalNameOverride = (default $globalNameOverride .Values.global.nameOverride) -}}
  {{- end -}}
  {{- default .Chart.Name (default "" $globalNameOverride) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* 
Return the object prefix including user provided overrides. 
Prefix will be of the form: ReleaseName-ChartName.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
The global nameOverride will replace the ChartName if provided.
The global fullNameOverride will replace the entire prefix if provided.
The ChartName will not be included if it is contained in the ReleaseName, leaving only the ReleaseName.
*/}}
{{- define "replicated-library.names.prefix" -}}
 {{- $globalFullNameOverride := "" -}}
  {{- if and (hasKey .Values "global") (hasKey .Values.global "fullNameOverride") -}}
    {{- $globalFullNameOverride = (default $globalFullNameOverride .Values.global.fullNameOverride) -}}
  {{- else -}}
    {{- $chartName := include "replicated-library.names.name" . -}}
    {{- if contains $chartName .Release.Name -}}
      {{- trunc 63 .Release.Name | trimSuffix "-" -}}
    {{- else -}}
      {{- printf "%s-%s" .Release.Name $chartName | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
  {{- end -}}
{{- end }}

{{/*
Create a default fully qualified object name.
This function will fail if called outside the scope of an object.
If only the prefix is needed use "replicated-library.names.prefix" instead.
If fullNameOverride is provided on the object it will take precedence over the normal prefix calculation.
*/}}
{{- define "replicated-library.names.fullname" -}}
  {{- $objectName := "" -}}
  {{- if hasKey . "ObjectName" -}}
    {{- $objectName = .ObjectName -}}
  {{- end -}}

  {{- $values := . -}}
  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.values -}}
      {{- $values = . -}}
    {{- end -}}
  {{- end -}}

  {{- if $values.fullNameOverride -}}
    {{- trunc 63 $values.fullNameOverride | trimSuffix "-" -}}
  {{- else -}}
    {{- $prefix := include "replicated-library.names.prefix" . -}}
    {{- printf "%s-%s" $prefix $objectName | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{/* Create chart name and version as used by the chart label */}}
{{- define "replicated-library.names.chart" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Create the name of the ServiceAccount to use */}}
{{- define "replicated-library.names.serviceAccountName" -}}
  {{- $name := "default" }}
  {{- $values := .Values.serviceAccount -}}
  {{- if hasKey . "ObjectName" -}}
    {{- $name = .ObjectName -}}
  {{ end -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.app -}}
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
  {{- if hasKey . "ObjectName" -}}
    {{- $name = .ObjectName -}}
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
