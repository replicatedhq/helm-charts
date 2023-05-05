{{/*
This template serves as a blueprint for all support bundle spec secret objects that are created
within the replicated-library library.
*/}}
{{- define "replicated-library.support-bundle.spec" -}}
  {{- $values := "" -}}
  {{- if and (hasKey . "ContextValues") (hasKey .ContextValues "supportBundle") -}}
    {{- $values = .ContextValues.supportBundle -}}
  {{- else -}}
    {{- fail "_support_bundle_specs.tpl requires the 'secret' ContextValues to be set" -}}
  {{- end -}}
  {{- $_ := set $.ContextValues "names" (dict "context" "supportBundle") -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "replicated-library.names.prefix" . }}-support-bundle
  labels:
    troubleshoot.io/kind: support-bundle
stringData:
  support-bundle-spec:
    {{- if .Values.supportBundle.installDefaultSpec -}}
      {{ include "replicated-library.support-bundle.spec.default" . | toYaml | indent 2 }}
    {{- end }}
{{- end }}

{{- define "replicated-library.support-bundle.spec.default" -}}
apiVersion: troubleshoot.sh/v1beta2
kind: SupportBundle
metadata:
  name: {{ include "replicated-library.names.prefix" . }}-support-bundle
spec:
  uri: https://raw.githubusercontent.com/replicatedhq/troubleshoot-specs/main/in-cluster/default.yaml
{{- end }}
