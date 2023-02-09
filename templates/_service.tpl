{{/*
Renders the Service objects required by the chart.
*/}}
{{- define "replicatedLibrary.services" -}}
  {{- /* Generate named services as required */ -}}
  {{- range $name, $service := .Values.services }}
    {{- if $service.enabled -}}
      {{- $serviceValues := $service -}}
      {{- $_ := set $ "ObjectName" $name -}}
      {{- $_ := set $ "ObjectValues" (dict "service" $serviceValues) -}}
      {{- include "replicatedLibrary.classes.service" $ | nindent 0 }}
    {{- end }}
  {{- end }}
{{- end }}
