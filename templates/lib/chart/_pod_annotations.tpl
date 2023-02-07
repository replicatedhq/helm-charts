{{/* Determine the Pod annotations used in the main */}}
{{- define "replicated-library.podAnnotations" -}}
  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.configmap -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}

  {{- if $values.podAnnotations -}}
    {{- tpl (toYaml $values.podAnnotations) . | nindent 0 -}}
  {{- end -}}

  {{- $configMapsFound := false -}}
  {{- range $name, $configmap := .Values.configmap -}}
    {{- if $configmap.enabled -}}
      {{- $configMapsFound = true -}}
    {{- end -}}
  {{- end -}}
  {{- if $configMapsFound -}}
    {{- printf "checksum/config: %v" (include ("replicated-library.configmap") . | sha256sum) | nindent 0 -}}
  {{- end -}}
{{- end -}}
