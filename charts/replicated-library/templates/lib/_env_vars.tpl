{{/*
Environment variables used by containers.
*/}}
{{- define "replicated-library.env_vars" -}}
  {{- $values := . -}}

  {{- with $values -}}
    {{- $result := list -}}
    {{- range $k, $v := . -}}
      {{- $name := $k -}}
      {{- $value := $v -}}
      {{- if kindIs "int" $name -}}
        {{- $name = required "environment variables as a list of maps require a name field" $value.name -}}
      {{- end -}}

      {{- if kindIs "string" $value -}}
        {{- $result = append $result (dict "name" $name "value" $value) -}}
      {{- else if or (kindIs "float64" $value) (kindIs "bool" $value) -}}
        {{- $result = append $result (dict "name" $name "value" ($value | toString)) -}}
      {{- else -}}
        {{- $result = append $result (dict "name" $name "value" $value) -}}
      {{- end -}}
    {{- end -}}
    {{- toYaml (dict "env" $result) | nindent 0 -}}
  {{- end -}}
{{- end -}}
