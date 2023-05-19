{{/*
Renders the Support Bundle objects required by the chart.
*/}}
{{- define "replicated-library.preflights" -}}
  {{- $values := "" -}}
  {{- if and (hasKey . "ContextValues") (hasKey .ContextValues "troubleshoot") -}}
    {{- $values = .ContextValues.troubleshoot -}}
  {{- else -}}
    {{- fail "_preflights.tpl requires the 'troubleshoot' ContextValues to be set" -}}
  {{- end -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "replicated-library.names.prefix" . }}-preflight-{{ .ContextNames.troubleshoot }}
  labels:
    troubleshoot.io/kind: preflight
    app.kubernetes.io/name: {{ include "replicated-library.names.name" $ }}
    app.kubernetes.io/instance=: {{ $.Release.Name }}
    helm.sh/chart: {{ include "replicated-library.names.chart" . }}
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-6"
    "helm.sh/hook-delete-policy": before-hook-creation, hook-succeeded, hook-failed
stringData:
  preflight.yaml: |-
    apiVersion: troubleshoot.sh/v1beta2
    kind: Preflight
    metadata:
      name: {{ include "replicated-library.names.prefix" . }}-preflight-{{ .ContextNames.troubleshoot }}
    spec:
      {{- if $values.collectors }}
      collectors:
        {{- include "replicated-library.troubleshoot.collectors" . | indent 6 }}
      {{- end }}
      {{- if $values.analyzers }}
      analyzers:
       {{- include "replicated-library.troubleshoot.analyzers" . | indent 6 }}
      {{- end }}

---
apiVersion: v1
kind: Pod
metadata:
 name: {{ $.Release.Name }}-preflight-check
 labels:
    app.kubernetes.io/name: {{ include "replicated-library.names.name" $ }}
    app.kubernetes.io/instance=: {{ $.Release.Name }}
    helm.sh/chart: {{ include "replicated-library.names.chart" . }}
    app.kubernetes.io/managed-by: {{ .Release.Service }}
    app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
 annotations:
   "helm.sh/hook": pre-install, pre-upgrade
   "helm.sh/show-output": "true"
   "helm.sh/hook-weight": "-5"
   "helm.sh/hook-delete-policy": before-hook-creation, hook-succeeded, hook-failed
   "helm.sh/hook-output-log-policy": hook-failed, hook-succeeded
spec:
 serviceAccountName: "{{ $.Release.Name }}-preflight"
 restartPolicy: Never
 volumes:
  - name: preflights
    secret:
      secretName: {{ include "replicated-library.names.prefix" . }}-preflight-{{ .ContextNames.troubleshoot }}
  - name: kube-api-token
    projected:
      defaultMode: 420
      sources:
        - serviceAccountToken:
          expirationSeconds: 3607
          path: token
 containers:
  - name: pre-install-job
    image: "{{ $values.image }}"
    command:
      - "preflight"
      - "--interactive=false"
      - "/preflights/preflight.yaml"
    volumeMounts:
    - name: preflights
      mountPath: /preflights

---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: "{{ $.Release.Name }}-preflight"
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-6"
    "helm.sh/hook-delete-policy": hook-succeeded, hook-failed
secrets:
- name: {{ include "replicated-library.names.prefix" . }}-preflight-{{ .ContextNames.troubleshoot }}

{{- end }}
