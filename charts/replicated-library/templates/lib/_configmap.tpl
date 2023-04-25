{{/*
Renders the configmap objects required by the chart.
*/}}
{{- define "replicated-library.configmaps" -}}
  {{- /* Generate named configmaps as required */ -}}
  {{- range $name, $configmap := .Values.configmaps }}
    {{- if $configmap.enabled -}}
      {{- $configmapValues := $configmap -}}

      {{- $_ := set $.ObjectValues "configmapValues" $configmapValues -}}

      {{- include "replicated-library.classes.configmap" $ | nindent 0 }}
      {{- $_ := unset $.ObjectValues "configmapValues" -}}
    {{- end }}
  {{- end }}
{{- end }}
