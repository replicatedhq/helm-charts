{{/*
Main entrypoint for the replicated-library chart. It will render all underlying templates based on the provided values.
*/}}
{{- define "replicated-library.all" -}}
  {{- /* Merge the local chart values and the replicated-library chart defaults */ -}}
  {{ include "replicated-library.values.setup" . }}

  {{- /* Build the templates */ -}}
  {{ include "replicated-library.apps" . | nindent 0 }}
  {{ include "replicated-library.services" . | nindent 0 }}
  {{ include "replicated-library.ingresses" .  | nindent 0 }}
  {{ include "replicated-library.configmaps" . | nindent 0 }}
  {{ include "replicated-library.secrets" .  | nindent 0 }}
  {{ include "replicated-library.pvc" . }}

{{- end -}}
