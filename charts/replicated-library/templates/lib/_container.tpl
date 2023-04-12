{{- /* The main container included in the main */ -}}
{{- define "replicated-library.container" -}}
  {{- $values := . -}}
  {{- if hasKey . "AppValues" -}}
    {{- with .AppValues.app -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}
{{- range $containerName, $containerValues := $values.containers -}}
- name: {{ default "container" $containerName }}
  image: {{ printf "%s:%s" $containerValues.image.repository (default $.Chart.AppVersion ($containerValues.image.tag | toString)) | quote }}
  imagePullPolicy: {{ default $.Values.defaults.image.pullPolicy $containerValues.image.pullPolicy }}
  {{- with $containerValues.command }}
  command:
    {{- if kindIs "string" . }}
    - {{ . }}
    {{- else }}
      {{ toYaml . | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- with $containerValues.args }}
  args:
    {{- if kindIs "string" . }}
    - {{ . }}
    {{- else }}
    {{ toYaml . | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- with $containerValues.securityContext }}
  securityContext:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with $containerValues.lifecycle }}
  lifecycle:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- if $containerValues.termination }}
  {{- with $containerValues.termination.messagePath }}
  terminationMessagePath: {{ . }}
  {{- end }}
  {{- with $containerValues.termination.messagePolicy }}
  terminationMessagePolicy: {{ . }}
  {{- end }}
{{- end }}
  {{- with $containerValues.env }}
  env:
    {{- get (fromYaml (include "replicated-library.env_vars" .)) "env" | toYaml | nindent 4 -}}
  {{- end }}
  {{- if or $containerValues.envFrom $containerValues.secret }}
  envFrom:
    {{- with $containerValues.envFrom }}
      {{- toYaml . | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- with $containerValues.ports }}
  ports:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with $containerValues.volumeMounts }}
  volumeMounts:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with $containerValues.resources }}
  resources:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- if $containerValues.livenessProbe -}}
  {{- with (mergeOverwrite $.Values.defaults.probes.livenessProbe $containerValues.livenessProbe) }}
  livenessProbe:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- else if hasKey $containerValues "livenessProbe" -}}
  {{- else if and $containerValues.ports (first $containerValues.ports).containerPort -}}
  {{- $_ := set $.Values.defaults.probes.livenessProbe "tcpSocket" (dict "port" (first $containerValues.ports).containerPort) }}
  {{- with $.Values.defaults.probes.livenessProbe }}
  livenessProbe:
    {{- toYaml . | nindent 4 }}
  {{- end -}}
  {{- end -}}
  {{- if $containerValues.readinessProbe -}}
  {{- with (mergeOverwrite $.Values.defaults.probes.readinessProbe $containerValues.readinessProbe) }}
  readinessProbe:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- else if hasKey $containerValues "readinessProbe" -}}
  {{- else if and $containerValues.ports (first $containerValues.ports).containerPort -}}
  {{- $_ := set $.Values.defaults.probes.readinessProbe "tcpSocket" (dict "port" (first $containerValues.ports).containerPort) }}
  {{- with $.Values.defaults.probes.readinessProbe }}
  readinessProbe:
    {{- toYaml . | nindent 4 }}
  {{- end -}}
  {{- end -}}
  {{- if $containerValues.startupProbe -}}
  {{- with (mergeOverwrite $.Values.defaults.probes.startupProbe $containerValues.startupProbe) }}
  startupProbe:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- end -}}
{{- end -}}
{{- end -}}
