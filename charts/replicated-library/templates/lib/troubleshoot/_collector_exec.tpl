{{- define "replicated-library.troubleshoot.collector.exec" -}}
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
    command:
      {{- range .ContextValues.collector.command }}
      - {{ . }}
      {{- end }}

    {{- if .ContextValues.collector.collectorName }}
    collectorName: {{ .ContextValues.collector.collectorName }}
    {{- end }}

    {{- if .ContextValues.collector.containerName }}
    containerName: {{ .ContextValues.collector.containerName }}
    {{- end }}

    {{- if .ContextValues.collector.name }}
    name: {{ .ContextValues.collector.name }}
    {{- end }}

    {{- if .ContextValues.collector.namespace }}
    namespace: {{ .ContextValues.collector.namespace }}
    {{- end }}

    {{- if .ContextValues.collector.exclude }}
    exclude: {{ .ContextValues.collector.exclude }}
    {{- end }}

    {{- if .ContextValues.collector.timeout }}
    timeout: {{ .ContextValues.collector.timeout }}
    {{- end }}

    {{- if .ContextValues.collector.args }}
    args:
      {{- range .ContextValues.collector.args }}
      - {{ . }}
      {{- end }}
    {{- end }}

{{- end }}
