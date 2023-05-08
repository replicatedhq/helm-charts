{{- define "replicated-library.supportBundle.spec.collectors" -}}
  {{- range $collectorValues := $ }}
    {{- include "replicated-library.classes.collector" $collectorValues | nindent 0 }}
  {{- end }}
{{- end }}
