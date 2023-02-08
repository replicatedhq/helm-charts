{{/*
Probes selection logic.
*/}}
{{- define "replicatedLibrary.probes" -}}
  {{- $name := "default-app" }}
  {{- $values := .Values.probes -}}
  {{- if hasKey . "AppName" -}}
    {{- $name = .AppName -}}
  {{ end -}}

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
