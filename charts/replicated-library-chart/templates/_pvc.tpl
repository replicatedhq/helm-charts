{{/*
Renders the Persistent Volume Claim objects required by the chart.
*/}}
{{- define "replicated-library.pvc" -}}
  {{- /* Generate pvc as required */ -}}
  {{- range $name, $volume := .Values.persistence }}
    {{- if and $volume.enabled (eq (default "persistentVolumeClaim" $volume.type) "persistentVolumeClaim") (not $volume.persistentVolumeClaim.existingClaim) -}}
      {{- $values := $volume -}}
      {{- if not $values.nameOverride -}}
        {{- $_ := set $values "nameOverride" $name -}}
      {{- end -}}
      {{- $_ := set $ "ObjectName" $name -}}
      {{- $_ := set $ "ObjectValues" (dict "volume" $values) -}}
      {{- include "replicated-library.classes.pvc" $ | nindent 0 -}}
    {{- end }}
  {{- end }}
{{- end }}
