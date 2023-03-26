{{/*
Renders the configmap objects required by the chart.
*/}}
{{- define "replicated-library.configmaps" -}}
  {{- /* Generate named configmaps as required */ -}}
  {{- range $name, $configmap := .Values.configmaps }}
    {{- if $configmap.enabled -}}
      {{- $configmapValues := $configmap -}}

      {{- $_ := set $ "ObjectName" $name -}}
      {{- if $configmapValues.nameOverride -}}
        {{- $_ := set $ "ObjectName" $configmapValues.nameOverride -}}
      {{ end -}}

      {{- $_ := set $ "ObjectValues" (dict "configmap" $configmapValues) -}}

      {{- include "replicated-library.classes.configmap" $ | nindent 0 }}
    {{- end }}
  {{- end }}
{{- end }}
