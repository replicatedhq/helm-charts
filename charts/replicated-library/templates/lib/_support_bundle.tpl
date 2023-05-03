{{/*
Renders the Support Bundle objects into supportBundle secrets required by the chart.
*/}}
{{- define "replicated-library.supportBundle" -}}
    {{- if .Values.supportBundle.enabled -}}
     {{- include "replicated-library.classes.supportBundle" $ | nindent 0 }}
    {{- end }}
{{- end }}
