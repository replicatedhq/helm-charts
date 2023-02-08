{{/* Renders the Ingress objects required by the chart */}}
{{- define "replicatedLibrary.ingresses" -}}
  {{- /* Generate named ingresses as required */ -}}
  {{- range $name, $ingress := .Values.ingresses }}
    {{- if $ingress.enabled -}}
      {{- $ingressValues := $ingress -}}

      {{/* set defaults */}}
      {{- if and (not $ingressValues.nameOverride) (ne $name (include "replicatedLibrary.ingress.primary" $)) -}}
        {{- $_ := set $ingressValues "nameOverride" $name -}}
      {{- end -}}

      {{- $_ := set $ "ObjectValues" (dict "ingress" $ingressValues) -}}
      {{- include "replicatedLibrary.classes.ingress" $ }}
    {{- end }}
  {{- end }}
{{- end }}
