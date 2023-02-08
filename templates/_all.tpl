{{/*
Main entrypoint for the replicated-library chart. It will render all underlying templates based on the provided values.
*/}}
{{- define "replicated-library-chart.all" -}}
  {{- /* Merge the local chart values and the replicated-library chart defaults */ -}}
  {{- include "replicated-library.values.setup" . }}

  {{- /* Build the templates */ -}}
  {{ include "replicated-library.service" . | nindent 0 }}

  {{ include "replicated-library.ingress" .  | nindent 0 }}

  {{ include "replicated-library.configmap" . | nindent 0 }}

  {{ include "replicated-library.secret" .  | nindent 0 }}

  {{- include "replicated-library.pvc" . }}

  {{- range $name, $app := .Values.app }}
    {{- if $app.enabled -}}
      {{- $appValues := $app -}}

      {{- $_ := set $ "AppName" $name -}}
      {{- $_ := set $ "AppValues" (dict "app" $appValues) -}}

      {{- if eq .appValues.type "deployment" }}
        {{- include "replicated-library.deployment" $ | nindent 0 }}
      {{ else if eq $appValues.type "daemonset" }}
        {{- include "replicated-library.daemonset" $ | nindent 0 }}
      {{ else if eq $appValues.type "statefulset"  }}
        {{- include "replicated-library.statefulset" $ | nindent 0 }}
      {{ else }}
        {{- fail (printf "Type of (%s) for app - (%s) is not valid" $appValues.type $name) }}
      {{- end -}}

      {{- if $appValues.serviceAccount.create -}}
        {{- include "replicated-library.serviceAccount" . }}
      {{- end -}}

    {{- end }}
  {{- end }}

{{- end -}}
