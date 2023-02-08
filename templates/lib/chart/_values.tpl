{{/* Merge the local chart values and the replicatedLibrary chart defaults */}}
{{- define "replicatedLibrary.values.setup" -}}
  {{- if .Values.replicatedLibrary -}}
    {{- $defaultValues := deepCopy .Values.replicatedLibrary -}}
    {{- $userValues := deepCopy (omit .Values "replicatedLibrary") -}}
    {{- $mergedValues := mustMergeOverwrite $defaultValues $userValues -}}
    {{- $_ := set . "Values" (deepCopy $mergedValues) -}}
  {{- end -}}
{{- end -}}
