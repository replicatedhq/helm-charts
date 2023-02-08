{{/*
Main entrypoint for the replicatedLibrary chart. It will render all underlying templates based on the provided values.
*/}}
{{- define "replicatedLibrary-chart.all" -}}
  {{- /* Merge the local chart values and the replicatedLibrary chart defaults */ -}}
  {{- include "replicatedLibrary.values.setup" . }}

  {{- /* Build the templates */ -}}
  {{ include "replicatedLibrary.service" . | nindent 0 }}

  {{ include "replicatedLibrary.ingress" .  | nindent 0 }}

  {{ include "replicatedLibrary.configmap" . | nindent 0 }}

  {{ include "replicatedLibrary.secret" .  | nindent 0 }}

  {{- include "replicatedLibrary.pvc" . }}

  {{- range $name, $app := .Values.app }}
    {{- if $app.enabled -}}
      {{- $appValues := $app -}}

      {{- $_ := set $ "AppName" $name -}}
      {{- $_ := set $ "AppValues" (dict "app" $appValues) -}}

      {{- if eq .appValues.type "deployment" }}
        {{- include "replicatedLibrary.deployment" $ | nindent 0 }}
      {{ else if eq $appValues.type "daemonset" }}
        {{- include "replicatedLibrary.daemonset" $ | nindent 0 }}
      {{ else if eq $appValues.type "statefulset"  }}
        {{- include "replicatedLibrary.statefulset" $ | nindent 0 }}
      {{ else }}
        {{- fail (printf "Type of (%s) for app - (%s) is not valid" $appValues.type $name) }}
      {{- end -}}

      {{- if $appValues.serviceAccount.create -}}
        {{- include "replicatedLibrary.serviceAccount" . }}
      {{- end -}}

    {{- end }}
  {{- end }}

{{- end -}}
