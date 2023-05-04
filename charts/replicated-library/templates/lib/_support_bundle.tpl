{{/*
Renders the Support Bundle objects required by the chart.
*/}}
{{- define "replicated-library.support-bundle" -}}
    {{- if .Values.supportBundle.enabled -}}
      {{- $_ := set $.ContextValues "supportBundle" .Values.supportBundle -}}
      
      {{- include "replicated-library.support-bundle.spec" $ | nindent 0 }}
      
      {{- $_ := unset $.ContextValues "supportBundle"  -}}
    {{- end }}
{{- end }}
