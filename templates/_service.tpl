{{/*
Renders the Service objects required by the chart.
*/}}
{{- define "replicatedLibrary.services" -}}
  {{- /* Generate named services as required */ -}}
  {{- range $name, $service := .Values.services }}
    {{- if $service.enabled -}}
      {{- $serviceValues := $service -}}

      {{/* set the default nameOverride to the service name */}}
      {{- if and (not $serviceValues.nameOverride) (ne $name (include "replicatedLibrary.service.primary" $)) -}}
        {{- $_ := set $serviceValues "nameOverride" $name -}}
      {{ end -}}

      {{- $_ := set $ "ObjectValues" (dict "service" $serviceValues) -}}
      {{- include "replicatedLibrary.classes.service" $ }}
    {{- end }}
  {{- end }}
{{- end }}
