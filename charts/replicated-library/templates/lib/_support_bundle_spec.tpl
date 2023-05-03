{{/*
Renders the Support Bundle Spec objects required by the chart.
*/}}
{{- define "replicated-library.support-bundle.spec" -}}
  {{- if .Values.supportBundle.installDefaultSpec -}}
    {{- include "replicated-library.support-bundle.spec.default" $ | nindent 0 }}
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
