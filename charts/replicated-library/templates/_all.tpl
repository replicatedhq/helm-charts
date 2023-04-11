{{/*
Main entrypoint for the replicated-library chart. It will render all underlying templates based on the provided values.
*/}}
{{- define "replicated-library.all" -}}
  {{- /* Merge the local chart values and the replicated-library chart defaults */ -}}
  {{- include "replicated-library.values.setup" . }}

  {{- /* Build the templates */ -}}
  {{ include "replicated-library.services" . | nindent 0 }}

  {{ include "replicated-library.ingresses" .  | nindent 0 }}

  {{ include "replicated-library.configmaps" . | nindent 0 }}

  {{ include "replicated-library.secrets" .  | nindent 0 }}

  {{- include "replicated-library.pvc" . }}

  {{- range $name, $app := .Values.apps }}
    {{- if $app.enabled -}}
      {{- $appValues := $app -}}

      {{- $_ := set $ "ObjectName" $name -}}
      {{- $_ := set $ "ObjectValues" (dict "values" $appValues) -}}

      {{- if eq $appValues.type "deployment" }}
        {{- include "replicated-library.deployment" $ | nindent 0 }}
      {{ else if eq $appValues.type "daemonset" }}
        {{- include "replicated-library.daemonset" $ | nindent 0 }}
      {{ else if eq $appValues.type "statefulset"  }}
        {{- include "replicated-library.statefulset" $ | nindent 0 }}
      {{ else }}
        {{- fail (printf "Type of (%s) for app - (%s) is not valid" $appValues.type $name) }}
      {{- end -}}

      {{- if $appValues.serviceAccount -}}
        {{- if $appValues.serviceAccount.create -}}
          {{- include "replicated-library.serviceAccount" $ }}
        {{- end -}}
      {{- end -}}

    {{- end }}
  {{- end }}

{{- end -}}
