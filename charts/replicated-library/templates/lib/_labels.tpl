{{/* replicated-library labels shared across objects */}}
{{- define "replicated-library.labels" -}}
helm.sh/chart: {{ include "replicated-library.names.chart" . }}
app.kubernetes.io/name: {{ include "replicated-library.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
  {{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
  {{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
  {{- with .Values.global.labels }}
    {{- range $k, $v := . }}
      {{- $name := $k }}
      {{- $value := tpl $v $ }}
{{ $name }}: {{ quote $value }}
    {{- end }}
  {{- end }}
{{- end -}}
{{/* Selector labels shared across objects */}}
{{- define "replicated-library.labels.selectorLabels" -}}
app.kubernetes.io/name: {{ include "replicated-library.names.appname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{- define "replicated-library.labels.serviceSelectorLabels" -}}
  {{- $serviceValues := . -}}
  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.values -}}
      {{- $serviceValues = . -}}
    {{- end -}}
  {{ end -}}
  {{- if $serviceValues.appName }}
    {{- range $serviceValues.appName }}
      {{- $name := . -}}
      {{- $matchingAppFound := false -}}
      {{- range $appName, $appValues := $.Values.apps }}
        {{- if and $appValues.enabled (eq $appName $name) (ne $matchingAppFound true) -}}
          {{- $matchingAppFound = true -}}
{{ printf "app.kubernetes.io/name: %s\n" $appName }}
        {{- end -}}
      {{- end -}}
      {{- if (ne $matchingAppFound true) -}}
        {{- fail (printf "Matching app for AppName (%s) was not found" $serviceValues.appName) }}
      {{- end -}}
    {{- end -}}
app.kubernetes.io/instance: {{ $.Release.Name }}
  {{- else -}}
app.kubernetes.io/name: {{ .ObjectName }}
app.kubernetes.io/instance: {{ $.Release.Name }}
  {{- end }}
{{- end -}}
