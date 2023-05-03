{{/*
This template serves as a blueprint for all support bundle spec objects that are created
within the replicated-library library.
*/}}
{{- define "replicated-library.classes.supportBundle" -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "replicated-library.names.fullname" . }}-support-bundle
  labels:
    troubleshoot.io/kind: support-bundle
  data:
    support-bundle-spec: {{ include "replicated-library.support_bundle.spec" . | b64enc }}
{{- end }}
