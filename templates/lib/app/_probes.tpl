{{/*
Probes selection logic.
*/}}
{{- define "replicated-library.probes" -}}
  {{- $values := .Values.probes -}}
  {{- if hasKey . "AppValues" -}}
    {{- with .AppValues.app -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}

  {{- range $probeName, $probe := $values.probes }}
    {{- if $probe.enabled -}}
      {{- "" | nindent 0 }}
      {{- $probeName }}Probe:
      {{- if $probe.custom -}}
        {{- $probe.spec | toYaml | nindent 2 }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
