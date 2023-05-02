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
  {{- $values := "" -}}
  {{- if and (hasKey . "ContextValues") (hasKey .ContextValues "service") -}}
    {{- $values = .ContextValues.service -}}
  {{- else -}}
    {{- fail "_labels.tpl requires the 'service' ContextValues to be set" -}}
  {{- end -}}
  {{- if $values.selector -}}
{{ toYaml $values.selector }}
  {{- else -}}
    {{- if $values.appName }}
      {{- range $values.appName }}
        {{- $name := . -}}
        {{- $matchingAppFound := false -}}
        {{- range $appName, $appValues := $.Values.apps }}
          {{- if and $appValues.enabled (eq $appName $name) (ne $matchingAppFound true) -}}
            {{- $matchingAppFound = true -}}
{{ printf "app.kubernetes.io/name: %s\n" $appName }}
          {{- end -}}
        {{- end -}}
        {{- if (ne $matchingAppFound true) -}}
          {{- fail (printf "Matching app for AppName (%s) was not found" $values.appName) }}
        {{- end -}}
      {{- end -}}
app.kubernetes.io/instance: {{ $.Release.Name }}
    {{- else -}}
      {{/* if no appName or selector is set on the service, check if there's an app that matches the service name to use instead */}}
      {{- $name := .ObjectName -}}
      {{- $matchingAppFound := false -}}
      {{- range $appName, $appValues := $.Values.apps -}}
        {{- if and $appValues.enabled (eq $appName $name) (ne $matchingAppFound true) -}}
          {{- $matchingAppFound = true -}}
app.kubernetes.io/name: {{ $name }}
app.kubernetes.io/instance: {{ $.Release.Name }}
        {{- end -}}
      {{- end -}}
      {{- if (ne $matchingAppFound true) -}}
        {{- fail (printf "Service (%s) has no selectors or matching apps" $name ) }}
      {{- end -}}
    {{- end }}
  {{- end -}}
{{- end -}}
