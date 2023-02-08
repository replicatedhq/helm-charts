{{/* Allow KubeVersion to be overridden. */}}
{{- define "replicatedLibrary.capabilities.ingress.kubeVersion" -}}
  {{- default .Capabilities.KubeVersion.Version .Values.kubeVersionOverride -}}
{{- end -}}

{{/* Return the appropriate apiVersion for Ingress objects */}}
{{- define "replicatedLibrary.capabilities.ingress.apiVersion" -}}
  {{- print "networking.k8s.io/v1" -}}
  {{- if semverCompare "<1.19" (include "replicatedLibrary.capabilities.ingress.kubeVersion" .) -}}
    {{- print "beta1" -}}
  {{- end -}}
{{- end -}}

{{/* Check Ingress stability */}}
{{- define "replicatedLibrary.capabilities.ingress.isStable" -}}
  {{- if eq (include "replicatedLibrary.capabilities.ingress.apiVersion" .) "networking.k8s.io/v1" -}}
    {{- true -}}
  {{- end -}}
{{- end -}}
