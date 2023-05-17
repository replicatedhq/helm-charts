{{- define "replicated-library.troubleshoot.collector.general" -}}
- {{ .ContextNames.collector }}:
  {{- if .ContextValues.collector }}
  {{- .ContextValues.collector | toYaml | nindent 4}}
  {{- else -}}
  {{ "{}" | indent 1 }}
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
          {{ include "replicated-library.labels.selectorLabels" $ | nindent 4 }}
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

{{- define "replicated-library.troubleshoot.collector.exec" -}}
- {{ .ContextNames.collector }}:
    collectorName: {{ default "" .ContextValues.collector.collectorName }}
    name: {{ default "" .ContextValues.collector.name }}
    containerName: {{ default "" .ContextValues.collector.containerName }}
    timeout: {{ default "10s" .ContextValues.collector.timeout }}

    {{- if .ContextValues.collector.args }}
    args:
      {{- range .ContextValues.collector.args }}
      - {{ . }}
      {{- end }}
    {{- end }}

    {{- if .ContextValues.collector.command }}
    command:
      {{- range .ContextValues.collector.command }}
      - {{ . }}
      {{- end }}
    {{- end }}

    {{- if .ContextValues.collector.selector }}
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

    {{- if .ContextValues.collector.exclude }}
    exclude: {{ .ContextValues.collector.exclude }}
    {{- end }}

{{- end }}


{{- define "replicated-library.troubleshoot.collector.secret" -}}
- {{ .ContextNames.collector }}:
    collectorName: {{ default "" .ContextValues.collector.collectorName }}
    name: {{ default "" .ContextValues.collector.name }}

    {{- if .ContextValues.collector.includeValue }}
    includeValue: {{ default false .ContextValues.collector.includeValue }}
    {{- end }}
    
    {{- if .ContextValues.collector.selector }}
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

    {{- if .ContextValues.collector.key }}
    key: {{ .ContextValues.collector.key }}
    {{- end }}

{{- end }}


{{- define "replicated-library.troubleshoot.collector.data" -}}
- {{ .ContextNames.collector }}:
    collectorName: {{ default "" .ContextValues.collector.collectorName }}
    name: {{ default "" .ContextValues.collector.name }}
    data: {{ default "" .ContextValues.collector.data }}
{{- end }}

{{- define "replicated-library.troubleshoot.collector.copyFromHost" -}}
- {{ .ContextNames.collector }}:
    collectorName: {{ default "" .ContextValues.collector.collectorName }}
    name: {{ default "" .ContextValues.collector.name }}
    hostPath: {{ default "" .ContextValues.collector.hostPath }}
    timeout: {{ default "1m" .ContextValues.collector.timeout }}
    image: {{ default "" .ContextValues.collector.image }}

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

{{- define "replicated-library.troubleshoot.collector.configMap" -}}
- {{ .ContextNames.collector }}:
    collectorName: {{ default "" .ContextValues.collector.collectorName }}
    name: {{ default "" .ContextValues.collector.name }}

    {{- if .ContextValues.collector.namespace }}
    namespace: {{ .ContextValues.collector.namespace }}
    {{- end }}

    {{- if .ContextValues.collector.selector }}
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

    {{- if .ContextValues.collector.includeValue }}
    includeValue: {{ .ContextValues.collector.includeValue }}
    {{- end }}

    {{- if .ContextValues.collector.key }}
    key: {{ .ContextValues.collector.key }}
    {{- end }}

    {{- if .ContextValues.collector.includeAllData }}
    includeAllData: {{ .ContextValues.collector.includeAllData }}
    {{- end }}

{{- end }}

{{- define "replicated-library.troubleshoot.collector.collectd" -}}
- {{ .ContextNames.collector }}:
    collectorName: {{ default "" .ContextValues.collector.collectorName }}
    hostPath: {{ default "" .ContextValues.collector.hostPath }}
    timeout: {{ default "1m" .ContextValues.collector.timeout }}
    image: {{ default "" .ContextValues.collector.image }}

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
