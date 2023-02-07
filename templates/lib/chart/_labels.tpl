{{/* replicated-library labels shared across objects */}}
{{- define "replicated-library.labels" -}}
helm.sh/chart: {{ include "replicated-library.names.chart" . }}
{{ include "replicated-library.labels.selectorLabels" . }}
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
app.kubernetes.io/name: {{ include "replicated-library.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
