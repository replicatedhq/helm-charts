{{/* replicatedLibrary labels shared across objects */}}
{{- define "replicatedLibrary.labels" -}}
helm.sh/chart: {{ include "replicatedLibrary.names.chart" . }}
app.kubernetes.io/name: {{ include "replicatedLibrary.names.name" . }}
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
{{- define "replicatedLibrary.labels.selectorLabels" -}}
app.kubernetes.io/appname: {{ include "replicatedLibrary.names.appname" . }}
{{- end -}}

{{- define "replicatedLibrary.labels.serviceSelectorLabels" -}}
  {{- $serviceValues := . -}}
  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.service -}}
      {{- $serviceValues = . -}}
    {{- end -}}
  {{ end -}}
  {{- $matchingAppFound := false -}}
  {{- range $appName, $appValues := .Values.apps }}
    {{- if and $appValues.enabled (eq $appName $serviceValues.appName) (ne $matchingAppFound true) -}}
      {{- $matchingAppFound = true -}}
app.kubernetes.io/appname: {{ include "replicatedLibrary.names.servicename" $ }}
    {{- end }}
  {{- end }}
  {{- if (ne $matchingAppFound true) -}}
    {{- fail (printf "Matching app for AppName (%s) was not found" $serviceValues.appName) }}
  {{- end }}
{{- end -}}
