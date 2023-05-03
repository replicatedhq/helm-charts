{{/*
Renders the Persistent Volume Claim objects required by the chart.
*/}}
{{- define "replicated-library.pvc" -}}
  {{- /* Generate pvc as required */ -}}
  {{- range $name, $persistenceValues := .Values.persistence }}
    {{- if and $persistenceValues.enabled (eq (default "persistentVolumeClaim" $persistenceValues.type) "persistentVolumeClaim") (not $persistenceValues.persistentVolumeClaim.existingClaim) -}}
      {{- $_ := set $.ContextNames "persistence" $name -}}
      {{- $_ := set $.ContextValues "persistence" $persistenceValues -}}

      {{- include "replicated-library.classes.pvc" $ | nindent 0 -}}

      {{- $_ := unset $.ContextNames "persistence"  -}}
      {{- $_ := unset $.ContextValues "persistence"  -}}
    {{- end }}
  {{- end }}
{{- end }}
