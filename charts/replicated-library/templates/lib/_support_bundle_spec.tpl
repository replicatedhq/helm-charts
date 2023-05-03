{{/*
Renders the Support Bundle Spec objects required by the chart.
*/}}
{{- define "replicated-library.supportBundle.spec" -}}
  {{- if .Values.supportBundle.installDefaultSpec -}}
    {{- include "replicated-library.supportBundle.spec.default" $ | nindent 0 }}
  {{- end }}
{{- end }}


{{- define "replicated-library.supportBundle.spec.default" -}}
apiVersion: troubleshoot.sh/v1beta2
kind: SupportBundle
metadata:
  name: support-bundle
spec:
  collectors:
    - clusterInfo: {}
    - clusterResources: {}
{{- end }}
