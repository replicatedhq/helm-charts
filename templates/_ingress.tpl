{{/*
Renders the Service objects required by the chart.
*/}}
{{- define "replicated-library.ingresses" -}}
  {{- /* Generate named ingresses as required */ -}}
  {{- range $name, $ingress := .Values.ingresses }}
    {{- if $ingress.enabled -}}
      {{- $ingressName := $name -}}
      {{- $ingressValues := $ingress -}}
      {{- $_ := set $ "ObjectName" $name -}}
      {{- $_ := set $ "ObjectValues" (dict "ingress" $ingressValues) -}}
      {{- $matchingAppFound := false -}}
      {{- range $serviceName, $serviceValues := .Values.services }}
        {{- if and $serviceValues.enabled (eq $serviceName $ingressValues.serviceName) (ne $matchingAppFound true) -}}
          {{- $matchingAppFound = true -}}
          {{- $_ := set $ "ObjectValues" (dict "ingress" $ingressValues) -}}
          {{- include "replicated-library.classes.ingress" $ | nindent 0 }}
        {{- end }}
      {{- end }}
      {{- if (ne $matchingAppFound true) -}}
        {{- fail (printf "Matching service for ServiceName (%s) was not found" $ingressValues.serviceName) }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
