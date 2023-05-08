{{/*
Renders the Support Bundle objects required by the chart.
*/}}
{{- define "replicated-library.supportBundles" -}}
  {{- range $name, $supportBundleValues := .Values.supportBundles }}
    {{- if $supportBundleValues.enabled -}}
      {{- $_ := set $.ContextNames "supportBundle" $name -}}
      {{- $_ := set $.ContextValues "supportBundle" $supportBundleValues -}}
        {{- include "replicated-library.supportBundle" $ | nindent 0 -}}
      {{- $_ := unset $.ContextNames "supportBundle"  -}}
      {{- $_ := unset $.ContextValues "supportBundle"  -}}
    {{- end }}
  {{- end }}

{{- end }}
