{{- define "replicated-library.troubleshoot.collector.secret" -}}
- {{ .ContextNames.collector }}:
    {{ if eq .ContextValues.collector.secretName "*" -}}
    selector:
      - app.kubernetes.io/name={{ include "replicated-library.names.name" . }}
      - app.kubernetes.io/instance={{ .Release.Name }}
    {{ else if .ContextValues.collector.secretName -}}
    name: {{ .ContextValues.collector.secretName }}
    {{- else if .ContextValues.collector.selector -}}
    selector:
      {{- .ContextValues.collector.selector | toYaml | nindent 6}}
    {{ else if .ContextValues.collector.name }}
    name: {{ .ContextValues.collector.name }}
    {{- else -}}
        {{- fail (printf "Both name and selector of (%s) was not found" .ContextNames.collector) }}
    {{- end }}

    {{- if .ContextValues.collector.collectorName }}
    collectorName: {{ .ContextValues.collector.collectorName }}
    {{- end }}

    {{- if .ContextValues.collector.namespace }}
    namespace: {{ .ContextValues.collector.namespace }}
    {{ else if eq .ContextValues.collector.secretName "*"}}
    namespace: {{ $.Release.Namespace }}
    {{- end }}

    {{- if .ContextValues.collector.key }}
    key: {{ .ContextValues.collector.key }}
    {{- end }}

{{- end }}
