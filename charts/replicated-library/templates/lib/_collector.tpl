{{/*
Renders the Support Bundle Collectors objects required by the chart.
*/}}
{{- define "replicated-library.troubleshoot.collector" -}}
  {{- $values := "" -}}
  {{- if and (hasKey . "ContextValues") (hasKey .ContextValues "collector") -}}
    {{- $values = .ContextValues.collector -}}
  {{- else -}}
    {{- fail "_collector.tpl requires the 'collector' ContextValues to be set" -}}
  {{- end -}}
  {{- $_ := set $.ContextValues "names" (dict "context" "collector") -}}
    
  {{- if eq .ContextNames.collector "logs" -}}
    {{ include "replicated-library.troubleshoot.collector.logs" $ }}
  {{- else -}}
    {{ include "replicated-library.troubleshoot.collector.general" $ }}
  {{- end }}

{{- end }}
