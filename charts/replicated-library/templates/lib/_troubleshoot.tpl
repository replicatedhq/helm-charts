{{/*
Renders the Troubleshoot objects required by the chart.
*/}}
{{- define "replicated-library.troubleshoot" -}}
  {{- range $name, $troubleshootValues := .Values.troubleshoot }}
    {{- if eq $name "support-bundle" -}}
      {{- range $supportBundleName, $supportBundleValues := $troubleshootValues }}
        {{- if $supportBundleValues.enabled -}}
          {{- $_ := set $.ContextNames "troubleshoot" $supportBundleName -}}
          {{- $_ := set $.ContextValues "troubleshoot" $supportBundleValues -}}
            {{- include "replicated-library.supportBundle" $ | nindent 0 -}}
          {{- $_ := unset $.ContextNames "troubleshoot"  -}}
          {{- $_ := unset $.ContextValues "troubleshoot"  -}}
        {{- end }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
