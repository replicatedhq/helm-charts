{{- define "replicated-library.volumeMounts" -}}
  {{- $name := . -}}
  {{- if hasKey . "AppName" -}}
    {{- $name = .AppName -}}
  {{ end -}}

  {{- range $persistenceIndex, $persistenceItem := .Values.persistence }}
    {{- if and $persistenceItem.enabled (eq $name (default $name $persistenceItem.appName)) -}}
      {{- if kindIs "slice" $persistenceItem.subPath -}}
        {{- if $persistenceItem.mountPath -}}
          {{- fail (printf "Cannot use persistence.mountPath with a subPath list (%s)" $persistenceIndex) }}
        {{- end -}}
        {{- range $subPathIndex, $subPathItem := $persistenceItem.subPath }}
- name: {{ $persistenceIndex }}
  subPath: {{ required "subPaths as a list of maps require a path field" $subPathItem.path }}
  mountPath: {{ required "subPaths as a list of maps require an explicit mountPath field" $subPathItem.mountPath }}
          {{- with $subPathItem.readOnly }}
  readOnly: {{ . }}
          {{- end }}
          {{- with $subPathItem.mountPropagation }}
  mountPropagation: {{ . }}
          {{- end }}
        {{- end -}}
      {{- else -}}
        {{/* Set the default mountPath to /<name_of_the_peristence_item> */}}
        {{- $mountPath := (printf "/%v" $persistenceIndex) -}}
        {{/* Use the specified mountPath if provided */}}
        {{- with $persistenceItem.mountPath -}}
          {{- $mountPath = . -}}
        {{- end }}
        {{- if ne $mountPath "-" }}
- name: {{ $persistenceIndex }}
  mountPath: {{ $mountPath }}
          {{- with $persistenceItem.subPath }}
  subPath: {{ . }}
          {{- end }}
          {{- with $persistenceItem.readOnly }}
  readOnly: {{ . }}
          {{- end }}
          {{- with $persistenceItem.mountPropagation }}
  mountPropagation: {{ . }}
          {{- end }}
        {{- end }}
      {{- end -}}
    {{- end -}}
  {{- end }}
  {{- end }}