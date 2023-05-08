{{- define "replicated-library.classes.collector" -}}
{{- if eq $ "clusterInfo" -}}
- clusterInfo: {}
{{- else if eq $ "kotsadm-postgres-db" -}}
- exec: # this is removable when we don't need to support kots <= 1.87
    args:
      - "-U"
      - kotsadm
    collectorName: kotsadm-postgres-db
    command:
      - pg_dump
    containerName: kotsadm-postgres
    name: kots/admin_console
    selector:
      - app=kotsadm-postgres
    timeout: 10s
{{- end -}}

{{- end -}}
