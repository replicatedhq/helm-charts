{{/*
Main entrypoint for the replicatedLibrary chart. It will render all underlying templates based on the provided values.
*/}}
{{- define "replicatedLibrary.all" -}}
  {{- /* Merge the local chart values and the replicatedLibrary chart defaults */ -}}
  {{- include "replicatedLibrary.values.setup" . }}

  {{- /* Build the templates */ -}}
  {{ include "replicatedLibrary.services" . | nindent 0 }}

  {{ include "replicatedLibrary.ingresses" .  | nindent 0 }}

  {{ include "replicatedLibrary.configmaps" . | nindent 0 }}

  {{ include "replicatedLibrary.secrets" .  | nindent 0 }}

  {{- include "replicatedLibrary.pvc" . }}

  {{- range $name, $app := .Values.apps }}
    {{- if $app.enabled -}}
      {{- $appValues := $app -}}

      {{- $_ := set $ "AppName" $name -}}
      {{- $_ := set $ "AppValues" (dict "app" $appValues) -}}

      {{- if eq $appValues.type "deployment" }}
        {{- include "replicatedLibrary.deployment" $ | nindent 0 }}
      {{ else if eq $appValues.type "daemonset" }}
        {{- include "replicatedLibrary.daemonset" $ | nindent 0 }}
      {{ else if eq $appValues.type "statefulset"  }}
        {{- include "replicatedLibrary.statefulset" $ | nindent 0 }}
      {{ else }}
        {{- fail (printf "Type of (%s) for app - (%s) is not valid" $appValues.type $name) }}
      {{- end -}}

      {{- if $appValues.serviceAccount -}}
        {{- if $appValues.serviceAccount.create -}}
          {{- include "replicatedLibrary.serviceAccount" $ }}
        {{- end -}}
      {{- end -}}

    {{- end }}
  {{- end }}

{{- end -}}
