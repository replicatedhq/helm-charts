{{- /*
The pod definition included in the main.
*/ -}}
{{- define "replicated-library.pod" -}}
  {{- $values := . -}}
  {{- if hasKey . "AppValues" -}}
    {{- with .AppValues.app -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}

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
    {{- $initContainers := list }}
    {{- range $index, $key := (keys $values.initContainers | uniq | sortAlpha) }}
      {{- $container := get $.Values.initContainers $key }}
      {{- if not $container.name -}}
        {{- $_ := set $container "name" $key }}
      {{- end }}
      {{- if $container.env -}}
        {{- $_ := set $ "ObjectValues" (dict "env" $container.env) -}}
        {{- $newEnv := fromYaml (include "replicated-library.env_vars" $) -}}
        {{- $_ := unset $.ObjectValues "env" -}}
        {{- $_ := set $container "env" $newEnv.env }}
      {{- end }}
      {{- $initContainers = append $initContainers $container }}
    {{- end }}
    {{- tpl (toYaml $initContainers) $ | nindent 2 }}
  {{- end }}
containers:
  {{- include "replicated-library.container" . | nindent 2 }}
  {{- with $values.volumes }}
volumes:
    {{- toYaml . | nindent 2 }}
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
