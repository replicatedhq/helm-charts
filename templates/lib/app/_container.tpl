{{- /* The main container included in the main */ -}}
{{- define "replicated-library.mainContainer" -}}
  {{- $values := . -}}
  {{- if hasKey . "AppValues" -}}
    {{- with .AppValues.app -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}
- name: {{ include "replicated-library.names.appname" . }}
  image: {{ printf "%s:%s" $values.image.repository (default .Chart.AppVersion $values.image.tag) | quote }}
  imagePullPolicy: {{ $values.image.pullPolicy }}
  {{- with $values.command }}
  command:
    {{- if kindIs "string" . }}
    - {{ . }}
    {{- else }}
      {{ toYaml . | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- with $values.args }}
  args:
    {{- if kindIs "string" . }}
    - {{ . }}
    {{- else }}
    {{ toYaml . | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- with $values.securityContext }}
  securityContext:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with $values.lifecycle }}
  lifecycle:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- if $values.termination }}
  {{- with $values.termination.messagePath }}
  terminationMessagePath: {{ . }}
  {{- end }}
  {{- with $values.termination.messagePolicy }}
  terminationMessagePolicy: {{ . }}
  {{- end }}
{{- end }}
  {{- with $values.env }}
  env:
    {{- get (fromYaml (include "replicated-library.env_vars" $)) "env" | toYaml | nindent 4 -}}
  {{- end }}
  {{- if or $values.envFrom $values.secret }}
  envFrom:
    {{- with $values.envFrom }}
      {{- toYaml . | nindent 4 }}
    {{- end }}
    {{- if $values.secret }}
    - secretRef:
        name: {{ include "replicated-library.names.fullname" . }}
    {{- end }}
  {{- end }}
  ports:
  {{- include "replicated-library.ports" . | trim | nindent 4 }}
  {{- with $values.volumeMounts }}
  volumeMounts:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- include "replicated-library.probes" . | trim | nindent 2 }}
  {{- with $values.resources }}
  resources:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
