{{/*
This template serves as a blueprint for all support bundle spec secret objects that are created
within the replicated-library library.
*/}}
{{- define "replicated-library.support-bundle.spec" -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "replicated-library.names.fullname" . }}-support-bundle
  labels:
    troubleshoot.io/kind: support-bundle
  data:
    support-bundle-spec: 
    {{- if .Values.supportBundle.installDefaultSpec -}}
      {{ include "replicated-library.support-bundle.spec.default" . | b64enc }}
    {{- end }}
{{- end }}

{{- define "replicated-library.support-bundle.spec.default" -}}
apiVersion: troubleshoot.sh/v1beta2
kind: SupportBundle
metadata:
  name: support-bundle
spec:
  collectors:
    - clusterInfo: {}
    - clusterResources: {}
{{- end }}
