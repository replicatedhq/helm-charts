{{/*
Renders the Support Bundle objects required by the chart.
*/}}
{{- define "replicated-library.support-bundle" -}}
    {{- if .Values.supportBundle.enabled -}}
      {{- $_ := set $.ContextNames "support-bundle" "support-bundle" -}}
      {{- $_ := set $.ContextValues "support-bundle" .Values.supportBundle -}}
      
      {{- if .Values.supportBundle.installDefaultSpec -}}
        {{- include "replicated-library.support-bundle.spec.default" $ | nindent 0 }}
      {{- end }}

      {{- $_ := unset $.ContextNames "support-bundle"  -}}
      {{- $_ := unset $.ContextValues "support-bundle"  -}}
    {{- end }}
{{- end }}
