{{/* Determine the Pod annotations used in the main */}}
{{- define "replicated-library.podAnnotations" -}}
  {{- $values := "" -}}
  {{- if and (hasKey . "ContextValues") (hasKey .ContextValues "app") -}}
    {{- $values = .ContextValues.app -}}
  {{- else -}}
    {{- fail "_pod_annotations.tpl requires the 'app' ContextValues to be set" -}}
  {{- end -}}
  {{- $_ := set $.ContextValues "names" (dict "context" "app") -}}

  {{- if $values.podAnnotations }}
    {{- tpl (toYaml $values.podAnnotations) . | nindent 0 }}
  {{- end }}

  {{- $configMapsFound := false -}}
  {{- range $name, $configmap := .Values.configmaps -}}
    {{- if $configmap.enabled -}}
      {{- $configMapsFound = true -}}
    {{- end -}}
  {{- end -}}
  {{- if $configMapsFound -}}
    {{- printf "checksum/config: %v" (include ("replicated-library.configmaps") $ | sha256sum) | nindent 0 -}}
  {{- end -}}
{{- end -}}
