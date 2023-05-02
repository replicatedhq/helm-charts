{{/*
Renders the configmap objects required by the chart.
*/}}
{{- define "replicated-library.configmaps" -}}
  {{- /* Generate named configmaps as required */ -}}
  {{- range $name, $configmapValues := .Values.configmaps }}
    {{- if $configmapValues.enabled -}}
      {{- $_ := set $ "ContextNames" (dict "configmap" $name) -}}
      {{- $_ := set $ "ContextValues" (dict "configmap" $configmapValues) -}}

      {{- include "replicated-library.configmap" $ | nindent 0 }}
      {{- $_ := unset $.ContextNames "configmap"  -}}
      {{- $_ := unset $.ContextValues "configmap"  -}}
    {{- end }}
  {{- end }}
{{- end }}
