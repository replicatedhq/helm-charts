{{/*
Renders the Support Bundle objects required by the chart.
*/}}
{{- define "replicated-library.supportBundle" -}}
  {{- $values := "" -}}
  {{- if and (hasKey . "ContextValues") (hasKey .ContextValues "supportBundle") -}}
    {{- $values = .ContextValues.supportBundle -}}
  {{- else -}}
    {{- fail "_support_bundle.tpl requires the 'supportBundle' ContextValues to be set" -}}
  {{- end -}}
  {{- $_ := set $.ContextValues "names" (dict "context" "supportBundle") -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "replicated-library.names.prefix" . }}-support-bundle-{{ .ContextNames.supportBundle }}
  labels:
    troubleshoot.io/kind: support-bundle
stringData:
  support-bundle-spec:
    {{- include "replicated-library.supportBundle.spec" . | toYaml | indent 2 }}
{{- end }}

{{- define "replicated-library.supportBundle.spec" -}}
apiVersion: troubleshoot.sh/v1beta2
kind: SupportBundle
metadata:
  name: {{ include "replicated-library.names.prefix" . }}-support-bundle-default
spec:
  {{- if (hasKey .ContextValues.supportBundle "uri") -}}
  uri: {{ .ContextValues.supportBundle.uri }}
  {{- end }}
  {{- if (hasKey .ContextValues.supportBundle "collectors") -}}
  collectors:
    {{- include "replicated-library.supportBundle.spec.collectors" .ContextValues.supportBundle.collectors | indent 4 -}}
  {{- end }}
{{- end }}

