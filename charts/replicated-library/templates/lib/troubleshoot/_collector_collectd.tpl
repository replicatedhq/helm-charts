{{- define "replicated-library.troubleshoot.collector.collectd" -}}
- {{ .ContextNames.collector }}:
    hostPath: {{ default "" .ContextValues.collector.hostPath }}
    image: {{ default "" .ContextValues.collector.image }}

    {{- if .ContextValues.collector.collectorName }}
    collectorName: {{ .ContextValues.collector.collectorName }}
    {{- end }}

    {{- if .ContextValues.collector.timeout }}
    timeout: {{ .ContextValues.collector.timeout }}
    {{- end }}

    {{- if .ContextValues.collector.name }}
    name: {{ .ContextValues.collector.name }}
    {{- end }}

    {{- if .ContextValues.collector.namespace }}
    namespace: {{ .ContextValues.collector.namespace }}
    {{- end }}

    {{- if .ContextValues.collector.extractArchive }}
    extractArchive: {{ .ContextValues.collector.extractArchive }}
    {{- end }}

    {{- if .ContextValues.collector.imagePullPolicy }}
    imagePullPolicy: {{ .ContextValues.collector.imagePullPolicy }}
    {{- end }}

    {{- if .ContextValues.collector.imagePullSecret }}
    imagePullSecret: {{ .ContextValues.collector.imagePullSecret }}
    {{- end }}

{{- end }}