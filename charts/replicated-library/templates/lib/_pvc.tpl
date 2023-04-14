{{/*
Renders the Persistent Volume Claim objects required by the chart.
*/}}
{{- define "replicated-library.pvc" -}}
  {{- /* Generate pvc as required */ -}}
  {{- range $name, $persistenceValues := .Values.persistence }}
    {{- if and $persistenceValues.enabled (eq (default "persistentVolumeClaim" $persistenceValues.type) "persistentVolumeClaim") (not $persistenceValues.persistentVolumeClaim.existingClaim) -}}
      {{- $values := $persistenceValues -}}

      {{- $_ := set $ "ObjectName" $name -}}
      {{- if $persistenceValues.nameOverride -}}
        {{- $_ := set $ "ObjectName" $persistenceValues.nameOverride -}}
      {{ end -}}

      {{- $_ := set $ "ObjectValues" (dict "values" $values) -}}

      {{- include "replicated-library.classes.pvc" $ | nindent 0 -}}
    {{- end }}
  {{- end }}
{{- end }}
