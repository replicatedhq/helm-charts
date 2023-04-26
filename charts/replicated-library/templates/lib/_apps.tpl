{{/*
Renders the app objects into Deployments, DaemonSets, and StatefulSets as required by the chart.
*/}}
{{- define "replicated-library.apps" -}}
  {{- range $name, $appValues := .Values.apps }}
    {{- if $appValues.enabled -}}
      {{- $_ := set $ "ObjectName" $name -}}
      {{- $_ := set $ "ObjectValues" (dict "app" $appValues) -}}

      {{- $_ := set $ "ContextNames" (dict "app" $name) -}}
      {{- $_ := set $ "ContextValues" (dict "app" $appValues) -}}

      {{- if eq $appValues.type "deployment" }}
        {{- include "replicated-library.deployment" $ | nindent 0 }}
      {{ else if eq $appValues.type "daemonset" }}
        {{- include "replicated-library.daemonset" $ | nindent 0 }}
      {{ else if eq $appValues.type "statefulset"  }}
        {{- include "replicated-library.statefulset" $ | nindent 0 }}
      {{ else }}
        {{- fail (printf "Type of (%s) for app - (%s) is not valid" $appValues.type $name) }}
      {{ end -}}

      {{- if $appValues.serviceAccount -}}
        {{- if $appValues.serviceAccount.create -}}
          {{- include "replicated-library.serviceAccount" $ }}
        {{- end }}
      {{- end }}
      {{- $_ := unset $.ContextNames "app"  -}}
      {{- $_ := unset $.ContextValues "app"  -}}
    {{- end }}
  {{- end }}
{{- end }}
