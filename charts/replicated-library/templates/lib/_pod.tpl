{{- /*
The pod definition included in the main.
*/ -}}
{{- define "replicated-library.pod" -}}
  {{- $values := "" -}}
  {{- if and (hasKey . "ContextValues") (hasKey .ContextValues "app") -}}
    {{- $values = .ContextValues.app -}}
  {{- else -}}
    {{- fail "_pod.tpl requires the 'app' ContextValues to be set" -}}
  {{- end -}}
  {{- $_ := set $.ContextValues "names" (dict "context" "app") -}}

  {{- with $values.imagePullSecrets }}
imagePullSecrets:
    {{- toYaml . | nindent 2 }}
  {{- end -}}
serviceAccountName: {{ include "replicated-library.names.serviceAccountName" . }}
automountServiceAccountToken: {{ $values.automountServiceAccountToken }}
  {{- with $values.podSecurityContext }}
securityContext:
    {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- with $values.priorityClassName }}
priorityClassName: {{ . }}
  {{- end }}
  {{- with $values.runtimeClassName }}
runtimeClassName: {{ . }}
  {{- end }}
  {{- with $values.schedulerName }}
schedulerName: {{ . }}
  {{- end }}
  {{- with $values.hostNetwork }}
hostNetwork: {{ . }}
  {{- end }}
  {{- with $values.hostname }}
hostname: {{ . }}
  {{- end }}
  {{- if $values.dnsPolicy }}
dnsPolicy: {{ $values.dnsPolicy }}
  {{- else if $values.hostNetwork }}
dnsPolicy: ClusterFirstWithHostNet
  {{- else }}
dnsPolicy: ClusterFirst
  {{- end }}
  {{- with $values.dnsConfig }}
dnsConfig:
    {{- toYaml . | nindent 2 }}
  {{- end }}
enableServiceLinks: {{ $values.enableServiceLinks }}
{{- if $values.termination }}
  {{- with $values.termination.gracePeriodSeconds }}
terminationGracePeriodSeconds: {{ . }}
  {{- end }}
{{- end }}
{{- if $values.initContainers }}
initContainers:
  {{- include "replicated-library.initContainer" . | nindent 2 }}
{{- end }}
containers:
  {{- include "replicated-library.container" . | nindent 2 }}
  {{- with $values.volumes }}
volumes:
    {{- range . }} 
      {{- /* Add the prefix to the claimName if the claim is in the persistence dict and is enabled */}}
      {{- if (hasKey . "persistentVolumeClaim") -}}
        {{- if (hasKey .persistentVolumeClaim "claimName") -}}
          {{- if and (hasKey $.Values.persistence .persistentVolumeClaim.claimName) (get (get $.Values.persistence .persistentVolumeClaim.claimName) "enabled") -}}
            {{- $_ := set .persistentVolumeClaim "claimName" (printf "%s-%s" (include "replicated-library.names.prefix" $) .persistentVolumeClaim.claimName | trimAll "-") }}
          {{- end }}
        {{- end -}}
      {{- end }}
    {{- end }}
  {{- toYaml . | nindent 2}}
  {{- end }}
  {{- with $values.hostAliases }}
hostAliases:
    {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- with $values.nodeSelector }}
nodeSelector:
    {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- with $values.affinity }}
affinity:
    {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- with $values.topologySpreadConstraints }}
topologySpreadConstraints:
    {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- with $values.tolerations }}
tolerations:
    {{- toYaml . | nindent 2 }}
  {{- end }}
{{- end -}}
