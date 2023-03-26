{{/*
Renders the Service objects required by the chart.
*/}}
{{- define "replicated-library.ingresses" -}}
  {{- /* Generate named ingresses as required */ -}}
  {{- range $name, $ingress := .Values.ingresses }}
    {{- if $ingress.enabled -}}
      {{- $ingressValues := $ingress -}}

      {{- $_ := set $ "ObjectName" $name -}}
      {{- if $ingressValues.nameOverride -}}
        {{- $_ := set $ "ObjectName" $ingressValues.nameOverride -}}
      {{ end -}}

      {{- $_ := set $ "ObjectValues" (dict "ingress" $ingressValues) -}}

      {{- if $ingress.serviceName }}
        {{- $matchingAppFound := false -}}

        {{- range $serviceName, $serviceValues := $.Values.services }}
          {{- if and $serviceValues.enabled (eq $serviceName $ingressValues.serviceName) (ne $matchingAppFound true) -}}
            {{- $matchingAppFound = true -}}
            {{- include "replicated-library.classes.ingress" $ | nindent 0 }}
          {{- end }}
        {{- end }}

        {{- if (ne $matchingAppFound true) -}}
          {{- fail (printf "Matching service for ServiceName (%s) was not found" $ingressValues.serviceName) }}
        {{- end }}

      {{- else }}
        {{- include "replicated-library.classes.ingress" $ | nindent 0 }}
      {{- end }}

    {{- end }}
  {{- end }}
{{- end }}
