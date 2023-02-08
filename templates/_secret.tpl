{{/*
Renders the Secret objects required by the chart.
*/}}
{{- define "replicatedLibrary.secrets" -}}
  {{- /* Generate named secrets as required */ -}}
  {{- range $name, $secret := .Values.secrets }}
    {{- if $secret.enabled -}}
      {{- $secretValues := $secret -}}

      {{/* set the default nameOverride to the secret name */}}
      {{- if not $secretValues.nameOverride -}}
        {{- $_ := set $secretValues "nameOverride" $name -}}
      {{ end -}}

      {{- $_ := set $ "ObjectValues" (dict "secret" $secretValues) -}}
      {{- include "replicatedLibrary.classes.secret" $ }}
    {{- end }}
  {{- end }}
{{- end }}
