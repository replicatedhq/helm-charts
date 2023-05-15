{{- define "replicated-library.troubleshoot.collector.general" -}}
- {{ .ContextNames.collector }}:
    {{- if .ContextValues.collector }}
    {{- range $k, $v := .ContextValues.collector }}
    {{ $k }}: {{ $v }}
    {{- end }}
    {{- else -}}
    {}
    {{- end }}
{{- end }}

{{- define "replicated-library.troubleshoot.collector.logs" -}}
- {{ .ContextNames.collector }}:
    collectorName: {{ default "" .ContextValues.collector.collectorName }}
    {{ if .ContextValues.collector.selector -}}
    selector:
        {{- range $k, $v := .ContextValues.collector.selector }}
            {{- if and (eq $k "app") (index $.Values.apps $v) }}
              {{- $_ := set $.ContextNames "app" $v -}}
              {{ include "replicated-library.labels.selectorLabels" $ | nindent 6 }}
              {{- $_ := unset $.ContextNames "app"  -}}
            {{- else -}}
            {{ $k | nindent 6  }}: {{ $v }}
            {{- end }}
        {{- end }}
    {{- end }}
    {{- if .ContextValues.collector.namespace }}
    namespace: {{ .ContextValues.collector.namespace }}
    {{- end }}
    {{- if .ContextValues.collector.containerNames }}
    containerNames:
        {{- range .ContextValues.collector.containerNames }}
      - {{ . }}
        {{- end }}
    {{- end }}
    {{ if .ContextValues.collector.limits }}
    limits:
      maxAge: {{ default "720h" .ContextValues.collector.limits.maxAge }}
      maxLines: {{ default 10000 .ContextValues.collector.limits.maxLines }}
      maxBytes: {{ default 5000000 .ContextValues.collector.limits.maxBytes }}
    {{- else -}}
    limits:
      maxAge: "720h"
      maxLines: 10000
      maxBytes: 5000000
    {{- end }}
{{- end }}
