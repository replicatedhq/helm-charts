{{/*
This template serves as a blueprint for all PersistentVolumeClaim objects that are created
within the replicated-library library.
*/}}
{{- define "replicated-library.classes.pvc" -}}
{{- $values := .Values.volumes -}}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.volume -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}
{{- $pvcName := include "replicated-library.names.fullname" . -}}
{{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
  {{- if not (eq $values.nameOverride "-") -}}
    {{- $pvcName = printf "%v-%v" $pvcName $values.nameOverride -}}
  {{ end -}}
{{ end }}
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ $pvcName }}
  {{- with (merge ($values.labels | default dict) (include "replicated-library.labels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  annotations:
    {{- if $values.retain }}
    "helm.sh/resource-policy": keep
    {{- end }}
    {{- with (merge ($values.annotations | default dict) (include "replicated-library.annotations" $ | fromYaml)) }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  accessModes:
    - {{ required (printf "accessMode is required for PVC %v" $pvcName) $values.accessMode | quote }}
  resources:
    requests:
      storage: {{ required (printf "size is required for PVC %v" $pvcName) $values.size | quote }}
  {{- if $values.storageClass }}
  storageClassName: {{ if (eq "-" $values.storageClass) }}""{{- else }}{{ $values.storageClass | quote }}{{- end }}
  {{- end }}
  {{- if $values.volumeName }}
  volumeName: {{ $values.volumeName | quote }}
  {{- end }}
{{- end -}}
