{{/*
This template serves as a blueprint for all Ingress objects that are created
within the replicated-library library.
*/}}
{{- define "replicated-library.classes.ingress" -}}
  {{- $ingressName := include "replicated-library.names.fullname" . -}}
  {{- $values := .Values.ingresses -}}

  {{- if hasKey . "ObjectName" -}}
    {{- $ingressName = .ObjectName -}}
  {{ end -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.values -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}

  {{- $isStable := include "replicated-library.capabilities.ingress.isStable" . }}

  {{- $serviceName := $values.serviceName }}
---
apiVersion: {{ include "replicated-library.capabilities.ingress.apiVersion" . }}
kind: Ingress
metadata:
  name: {{ printf "%s-%s" (include "replicated-library.names.fullname") $ingressName | trunc 63 | trimSuffix "-" }}
  {{- with (merge ($values.labels | default dict) (include "replicated-library.labels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge ($values.annotations | default dict) (include "replicated-library.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- if and $isStable $values.ingressClassName }}
  ingressClassName: {{ $values.ingressClassName }}
  {{- end }}
  {{- if $values.tls }}
  tls:
    {{- range $values.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ tpl . $ | quote }}
        {{- end }}
      {{- if .secretName }}
      secretName: {{ tpl .secretName $ | quote}}
      {{- end }}
    {{- end }}
  {{- end }}
  rules:
  {{- range $values.hosts }}
    - host: {{ tpl .host $ | quote }}
      http:
        paths:
          {{- range .paths }}
          {{- $service := $serviceName -}}
          {{- $port := 80 -}}
          {{- if .service -}}
            {{- $service = default $service .service.name -}}
            {{- $port = default $port .service.port -}}
          {{- end }}
          - path: {{ tpl .path $ | quote }}
            {{- if $isStable }}
            pathType: {{ default "Prefix" .pathType }}
            {{- end }}
            backend:
              {{- if $isStable }}
              service:
                name: {{ $service }}
                port:
                  number: {{ $port }}
              {{- else }}
              serviceName: {{ $service }}
              servicePort: {{ $port }}
              {{- end }}
          {{- end }}
  {{- end }}
{{- end }}
