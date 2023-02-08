{{- /* The main container included in the main */ -}}
{{- define "replicatedLibrary.mainContainer" -}}
  {{- $name := "default-app" }}
  {{- $values := . -}}
  {{- if hasKey . "AppName" -}}
    {{- $name = .AppName -}}
  {{ end -}}

  {{- if hasKey . "AppValues" -}}
    {{- with .AppValues.app -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}
- name: {{ include "replicatedLibrary.names.fullname" . }}
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
  {{- with $values.termination.messagePath }}
  terminationMessagePath: {{ . }}
  {{- end }}
  {{- with $values.termination.messagePolicy }}
  terminationMessagePolicy: {{ . }}
  {{- end }}

  {{- with $values.env }}
  env:
    {{- get (fromYaml (include "replicatedLibrary.env_vars" $)) "env" | toYaml | nindent 4 -}}
  {{- end }}
  {{- if or $values.envFrom $values.secret }}
  envFrom:
    {{- with $values.envFrom }}
      {{- toYaml . | nindent 4 }}
    {{- end }}
    {{- if $values.secret }}
    - secretRef:
        name: {{ include "replicatedLibrary.names.fullname" . }}
    {{- end }}
  {{- end }}
  ports:
  {{- include "replicatedLibrary.ports" . | trim | nindent 4 }}
  {{- with $values.volumeMounts }}
  volumeMounts:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- include "replicatedLibrary.probes" . | trim | nindent 2 }}
  {{- with $values.resources }}
  resources:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
