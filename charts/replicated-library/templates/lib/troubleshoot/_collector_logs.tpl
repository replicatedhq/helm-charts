{{- define "replicated-library.troubleshoot.collector.logs" -}}
- {{ .ContextNames.collector }}:
    {{ if eq .ContextValues.collector.appName "*" -}}
    selector:
      - app.kubernetes.io/name={{ include "replicated-library.names.name" . }}
      - app.kubernetes.io/instance={{ .Release.Name }}
    {{ else if .ContextValues.collector.appName -}}
    selector:
      {{- if index $.Values.apps .ContextValues.collector.appName }}
        {{- $_ := set $.ContextNames "app" .ContextValues.collector.appName -}}
          {{- range (include "replicated-library.labels.selectorLabels" $ | splitList "\n" ) -}}
          {{ printf "- %s" . | replace ": " "=" | nindent 6 }}
          {{- end }}
        {{- $_ := unset $.ContextNames "app"  -}}
      {{- else -}}
        {{- fail (printf "Matching app for AppName (%s) was not found" .ContextValues.collector.appName) }}
      {{- end }}
    {{- else if .ContextValues.collector.selector -}}
    selector:
      {{- .ContextValues.collector.selector | toYaml | nindent 6}}
    {{- end }}

    {{- if .ContextValues.collector.collectorName }}
    collectorName: {{ .ContextValues.collector.collectorName }}
    {{- end }}

    {{- if .ContextValues.collector.collectorName }}
    collectorName: {{ .ContextValues.collector.collectorName }}
    {{- end }}

    {{- if .ContextValues.collector.name }}
    name: {{ .ContextValues.collector.name }}
    {{- else -}}
      {{- fail (printf "name in (%s) was required" .ContextNames.collector) }}
    {{- end }}

    {{- if .ContextValues.collector.containerNames }}
    containerNames:
        {{- range .ContextValues.collector.containerNames }}
      - {{ . }}
        {{- end }}
    {{- end }}

    {{- if .ContextValues.collector.limits }}
    limits:
      maxAge: {{ default "720h" .ContextValues.collector.limits.maxAge }}
      maxLines: {{ default 10000 .ContextValues.collector.limits.maxLines }}
      maxBytes: {{ default 5000000 .ContextValues.collector.limits.maxBytes }}
    {{- end }}

{{- end }}
