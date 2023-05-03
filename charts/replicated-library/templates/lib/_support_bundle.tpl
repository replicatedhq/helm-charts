{{/*
Renders the Support Bundle objects into supportBundle secrets required by the chart.
*/}}
{{- define "replicated-library.support-bundle" -}}
    {{- if .Values.supportBundle.enabled -}}
     {{- include "replicated-library.classes.support-bundle" $ | nindent 0 }}
    {{- end }}
{{- end }}
