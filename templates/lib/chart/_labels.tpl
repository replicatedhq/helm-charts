{{/* replicatedLibrary labels shared across objects */}}
{{- define "replicatedLibrary.labels" -}}
helm.sh/chart: {{ include "replicatedLibrary.names.chart" . }}
{{ include "replicatedLibrary.labels.selectorLabels" . }}
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
app.kubernetes.io/name: {{ include "replicatedLibrary.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
