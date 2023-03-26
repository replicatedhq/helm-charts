{{/*
Renders the Secret objects required by the chart.
*/}}
{{- define "replicated-library.secrets" -}}
  {{- /* Generate named secrets as required */ -}}
  {{- range $name, $secret := .Values.secrets }}
    {{- if $secret.enabled -}}
      {{- $secretValues := $secret -}}

      {{- $_ := set $ "ObjectName" $name -}}
      {{- if $secretValues.nameOverride -}}
        {{- $_ := set $ "ObjectName" $secretValues.nameOverride -}}
      {{ end -}}

      {{- $_ := set $ "ObjectValues" (dict "secret" $secretValues) -}}
      {{- include "replicated-library.classes.secret" $ | nindent 0 }}
    {{- end }}
  {{- end }}
{{- end }}
