{{- define "replicated-library.troubleshoot.collector.data" -}}
- {{ .ContextNames.collector }}:
    collectorName: {{ default "" .ContextValues.collector.collectorName }}
    name: {{ default "" .ContextValues.collector.name }}
    data: {{ default "" .ContextValues.collector.data }}
{{- end }}
