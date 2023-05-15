{{/*
Renders the Troubleshoot objects required by the chart.
*/}}
{{- define "replicated-library.troubleshoot" -}}
    {{- range $name, $troubleshootValues := .Values.troubleshoot }}
        {{- if $troubleshootValues.enabled -}}
          {{- $_ := set $.ContextNames "troubleshoot" $name -}}
          {{- $_ := set $.ContextValues "troubleshoot" $troubleshootValues -}}
            {{- if eq $troubleshootValues.type "SupportBundle" -}}
              {{- include "replicated-library.supportBundle" $ | nindent 0 -}}
            {{- end }}
          {{- $_ := unset $.ContextNames "troubleshoot"  -}}
          {{- $_ := unset $.ContextValues "troubleshoot"  -}}
        {{- end }}
    {{- end }}
{{- end }}
