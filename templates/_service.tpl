{{/*
Renders the Service objects required by the chart.
*/}}
{{- define "replicated-library.services" -}}
  {{- /* Generate named services as required */ -}}
  {{- range $name, $service := .Values.services }}
    {{- if $service.enabled -}}
      {{- $serviceValues := $service -}}
      {{- $_ := set $ "ObjectName" $name -}}
      {{- $_ := set $ "ObjectValues" (dict "service" $serviceValues) -}}
      {{- include "replicated-library.classes.service" $ | nindent 0 }}
    {{- end }}
  {{- end }}
{{- end }}
