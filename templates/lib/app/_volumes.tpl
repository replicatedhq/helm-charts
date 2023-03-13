{{/*
Volumes included by the main.
*/}}
{{- define "replicated-library.volumes" -}}
{{- $name := . -}}
{{- if hasKey . "AppName" -}}
  {{- $name = .AppName -}}
{{ end -}}

{{- range $index, $volume := .Values.persistence }}
{{- if and $volume.enabled (eq $name (default $name $volume.appName)) }}
- name: {{ $index }}
  {{- if eq (default "persistentVolumeClaim" $volume.type) "persistentVolumeClaim" }}
    {{- $pvcName := $index -}}
    {{- if $volume.persistentVolumeClaim.existingClaim }}
      {{- /* Always prefer an existingClaim if that is set */}}
      {{- $pvcName = $volume.persistentVolumeClaim.existingClaim -}}
    {{- else -}}
      {{- /* Otherwise refer to the PVC name */}}
      {{- if $volume.nameOverride -}}
        {{- if not (eq $volume.nameOverride "-") -}}
          {{- $pvcName = (printf "%s-%s" (include "replicated-library.names.fullname" $) $volume.nameOverride) -}}
        {{- end -}}
      {{- else -}}
        {{- $pvcName = (printf "%s-%s" (include "replicated-library.names.fullname" $) $index) -}}
      {{- end -}}
    {{- end }}
  persistentVolumeClaim:
    claimName: {{ $pvcName }}
  {{- else if or (eq $volume.type "configMap") (eq $volume.type "secret") }}
    {{- $objectName := (required (printf "name not set for volume item %s" $index) $volume.name) }}
    {{- $objectName = tpl $objectName $ }}
    {{- if eq $volume.type "configMap" }}
  configMap:
    name: {{ $objectName }}
    {{- else }}
  secret:
    secretName: {{ $objectName }}
    {{- end }}
    {{- with $volume.defaultMode }}
    defaultMode: {{ . }}
    {{- end }}
    {{- with $volume.items }}
    items:
      {{- toYaml . | nindent 6 }}
    {{- end }}
  {{- else if eq $volume.type "emptyDir" }}
    {{- $emptyDir := dict -}}
    {{- with $volume.medium -}}
      {{- $_ := set $emptyDir "medium" . -}}
    {{- end -}}
    {{- with $volume.sizeLimit -}}
      {{- $_ := set $emptyDir "sizeLimit" . -}}
    {{- end }}
  emptyDir: {{- $emptyDir | toYaml | nindent 4 }}
  {{- else if eq $volume.type "hostPath" }}
  hostPath:
    path: {{ required "hostPath not set" $volume.hostPath }}
    {{- with $volume.hostPathType }}
    type: {{ . }}
    {{- end }}
  {{- else if eq $volume.type "nfs" }}
  nfs:
    server: {{ required "server not set" $volume.server }}
    path: {{ required "path not set" $volume.path }}
  {{- else if eq $volume.type "custom" }}
    {{- toYaml $volume.volumeSpec | nindent 2 }}
  {{- else }}
    {{- fail (printf "Not a valid volume.type (%s)" $volume.type) }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}
