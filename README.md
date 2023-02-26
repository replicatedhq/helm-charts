# replicated-library

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: library](https://img.shields.io/badge/Type-library-informational?style=flat-square)

Replicated library chart

**Homepage:** <https://github.com/replicatedhq/replicated-library-chart/tree/main>

## Requirements

Kubernetes: `>=1.16.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| apps.example.additionalContainers | object | `{}` | Specify any additional containers here as dictionary items. Each additional container should have its own key. Helm templates can be used. |
| apps.example.additionalContainers | object | `{}` | Specify any additional containers here as dictionary items. Each additional container should have its own key. Helm templates can be used. |
| apps.example.additionalVolumeMounts | list | `[]` | TODO: Not Implemented |
| apps.example.additionalVolumes | list | `[]` | TODO: Not Implemented |
| apps.example.affinity | object | `{}` | Defines affinity constraint rules. [[ref]](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) |
| apps.example.annotations | object | `{}` | Set annotations on the deployment/statefulset/daemonset |
| apps.example.args | list | `[]` | Override the arguments for the primary container |
| apps.example.automountServiceAccountToken | bool | `true` | Specifies whether a service account token should be automatically mounted. |
| apps.example.command | list | `[]` | Override the command for the primary container |
| apps.example.dnsConfig | object | `{}` | Optional DNS settings, configuring the ndots option may resolve nslookup issues on some Kubernetes setups. |
| apps.example.dnsPolicy | string | `nil` | Defaults to "ClusterFirst" if hostNetwork is false and "ClusterFirstWithHostNet" if hostNetwork is true. |
| apps.example.enableServiceLinks | bool | `true` | Enable/disable the generation of environment variables for services. [[ref]](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/#accessing-the-service) |
| apps.example.enabled | bool | `false` | Enable the app Each app represents a single controller type (deployment, daemonset, statefulset) |
| apps.example.env | string | `nil` | Main environment variables. Template enabled. Syntax options: A) TZ: UTC B) PASSWD: '{{ .Release.Name }}' C) PASSWD:      configMapKeyRef:        name: config-map-name        key: key-name D) PASSWD:      valueFrom:        secretKeyRef:          name: secret-name          key: key-name      ... E) - name: TZ      value: UTC F) - name: TZ      value: '{{ .Release.Name }}' |
| apps.example.envFrom | list | `[]` | Secrets and/or ConfigMaps that will be loaded as environment variables. [[ref]](https://unofficial-kubernetes.readthedocs.io/en/latest/tasks/configure-pod-container/configmap/#use-case-consume-configmap-in-environment-variables) |
| apps.example.hostAliases | list | `[]` | Use hostAliases to add custom entries to /etc/hosts - mapping IP addresses to hostnames. [[ref]](https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/) |
| apps.example.hostNetwork | bool | `false` | When using hostNetwork make sure you set dnsPolicy to `ClusterFirstWithHostNet` |
| apps.example.hostname | string | `nil` | Allows specifying explicit hostname setting |
| apps.example.image.pullPolicy | string | `nil` | Specify the image pull policy for the primary container |
| apps.example.image.repository | string | `"nginx"` | Specify the image repository for the primary container |
| apps.example.image.tag | string | `"latest"` | Specify the image tag for the primary container |
| apps.example.imagePullSecrets | list | `[]` | Specify one or more image pull secrets |
| apps.example.initContainers | object | `{}` | Specify any initContainers here as dictionary items. Each initContainer should have its own key. The dictionary item key will determine the order. Helm templates can be used. |
| apps.example.initContainers | object | `{}` | Specify any initContainers here as dictionary items. Each initContainer should have its own key. The dictionary item key will determine the order. Helm templates can be used. |
| apps.example.labels | object | `{}` | Set labels on the deployment/statefulset/daemonset |
| apps.example.lifecycle | object | `{}` | Configure the lifecycle for the main container |
| apps.example.nodeSelector | object | `{}` | Node selection constraint [[ref]](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) |
| apps.example.podAnnotations | object | `{}` | Set annotations on the pod |
| apps.example.podLabels | object | `{}` | Set labels on the pod |
| apps.example.podManagementPolicy | string | `nil` | Set statefulset podManagementPolicy, valid values are Parallel and OrderedReady (default). |
| apps.example.podSecurityContext | object | `{}` | Configure the Security Context for the Pod |
| apps.example.priorityClassName | string | `nil` | Custom priority class for different treatment by the scheduler |
| apps.example.probes | object | See below | [[ref]](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| apps.example.probes.liveness | object | See below | Liveness probe configuration |
| apps.example.probes.liveness.custom | bool | `false` | Set this to `true` if you wish to specify your own livenessProbe |
| apps.example.probes.liveness.enabled | bool | `false` | Enable the liveness probe |
| apps.example.probes.liveness.spec | object | See below | The spec field contains the values for the default livenessProbe. If you selected `custom: true`, this field holds the definition of the livenessProbe. |
| apps.example.probes.readiness.custom | bool | `false` | Set this to `true` if you wish to specify your own readinessProbe |
| apps.example.probes.readiness.enabled | bool | `false` | Enable the readiness probe |
| apps.example.probes.readiness.spec | object | See below | The spec field contains the values for the default readinessProbe. If you selected `custom: true`, this field holds the definition of the readinessProbe. |
| apps.example.probes.startup | object | See below | Startup probe configuration |
| apps.example.probes.startup.custom | bool | `false` | Set this to `true` if you wish to specify your own startupProbe |
| apps.example.probes.startup.enabled | bool | `false` | Enable the startup probe |
| apps.example.probes.startup.spec | object | See below | The spec field contains the values for the default startupProbe. If you selected `custom: true`, this field holds the definition of the startupProbe. |
| apps.example.replicas | int | `1` | Set the replica count. Only used for deployment and statefulset |
| apps.example.resources | object | `{}` | Set the resource requests / limits for the primary container. |
| apps.example.revisionHistoryLimit | int | `3` | ReplicaSet revision history limit |
| apps.example.rollingUpdate.partition | string | `nil` | Set statefulset RollingUpdate partition |
| apps.example.rollingUpdate.surge | string | `nil` | Set deployment RollingUpdate max surge |
| apps.example.rollingUpdate.unavailable | string | `nil` | Set deployment RollingUpdate max unavailable |
| apps.example.runtimeClassName | string | `nil` | Allow specifying a runtimeClassName other than the default one (ie: nvidia) |
| apps.example.schedulerName | string | `nil` | Allows specifying a custom scheduler name |
| apps.example.securityContext | object | `{}` | Configure the Security Context for the primary container |
| apps.example.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| apps.example.serviceAccount.create | bool | `false` | Specifies whether a service account should be created |
| apps.example.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| apps.example.strategy | string | `nil` | Set the controller upgrade strategy For Deployments, valid values are Recreate (default) and RollingUpdate. For StatefulSets, valid values are OnDelete and RollingUpdate (default). DaemonSets ignore this. |
| apps.example.termination.gracePeriodSeconds | string | `nil` | [[ref](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle)] |
| apps.example.termination.messagePath | string | `nil` | [[ref](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle-1)] |
| apps.example.termination.messagePolicy | string | `nil` | [[ref](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle-1)] |
| apps.example.tolerations | list | `[]` | Specify taint tolerations [[ref]](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) |
| apps.example.topologySpreadConstraints | list | `[]` | Defines topologySpreadConstraint rules. [[ref]](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/) |
| apps.example.type | string | `"deployment"` | Specify the controller type. Valid options are deployment, daemonset or statefulset TODO: daemonset and statefulset |
| apps.example.volumeClaimTemplates | list | `[]` | Used to create individual disks for each instance when type: StatefulSet |
| configmaps | object | See below | Configure the configmaps for the chart here. Additional configmaps can be added by adding a dictionary key similar to the 'exampleConfig' configmap. TODO: nameOverride TODO: Ensure sha annotations on app are working |
| configmaps.exampleConfig.annotations | object | `{}` | Annotations to add to the configMap |
| configmaps.exampleConfig.data | object | `{}` | configMap data content. Helm template enabled. |
| configmaps.exampleConfig.enabled | bool | `false` | Enables or disables the configMap |
| configmaps.exampleConfig.labels | object | `{}` | Labels to add to the configMap |
| configmaps.exampleConfig.nameOverride | string | `nil` | Override the name that is used for this configmap. By default the name will be the name of the dictionary key |
| defaults | object | `{"image":{"pullPolicy":"IfNotPresent"}}` | Global defaults TODO: NOT IMPLEMENTED.  Intended to be best practice defaults across different areas of the chart. May collapse this into the "global" key |
| global.annotations | object | `{}` | Set additional global annotations. |
| global.labels | object | `{}` | Set additional global labels. |
| ingresses | object | See below | Configure the ingresses for the chart here. Additional ingresses can be added by adding a dictionary key similar to the 'example' ingress. |
| ingresses.example.annotations | object | `{}` | Provide additional annotations which may be required. |
| ingresses.example.enabled | bool | `false` | Enables or disables the ingress |
| ingresses.example.hosts | list | `[{"host":"chart-example.local","paths":[{"path":"/","pathType":"Prefix","service":{"name":null,"port":null}}]}]` | Configure the hosts for the ingress |
| ingresses.example.hosts[0].paths[0].service.name | string | `nil` | Service Name for the path. By default this is ingresses.example.serviceName if not overwritten TODO: NOT IMPLEMENTED |
| ingresses.example.ingressClassName | string | `nil` | Set the ingressClass that is used for this ingress. Requires Kubernetes >=1.19 |
| ingresses.example.labels | object | `{}` | Provide additional labels which may be required. |
| ingresses.example.nameOverride | string | `nil` | Override the name that is used for this ingress. By default the name will be the name of the dictionary key |
| ingresses.example.serviceName | string | `"example"` | Name of the service to attach this ingress. This corresponds to an service configured un the `services` key |
| persistence | object | `{"example":{"appName":"example","enabled":false,"mountPath":null,"nameOverride":null,"persistentVolume":{"spec":{"accessModes":["ReadWriteOnce"],"capacity":{"storage":"1Gi"},"hostPath":{"path":"/tmp/data1"},"reclaimPolicy":["Recycle"]}},"persistentVolumeClaim":{"existingClaimName":null,"spec":{"accessModes":["ReadWriteOnce"],"persistentVolumeReclaimPolicy":"Retain","resources":{"requests":{"storage":"8Gi"}},"selector":{"matchExpressions":[{"key":"environment","operator":"In","values":["dev"]}],"matchLabels":{"release":"stable"}},"storageClassName":"slow","volumeMode":"Filesystem"}},"readOnly":false,"subPath":null,"type":"persistentVolumeClaim","volume":{"spec":{"hostPath":{"path":"/tmp/data1","type":"DirectoryOrCreate"}}}}}` | Configure volumes for the chart here. Additional items can be added by adding a dictionary key similar to the 'example' key.  Name of the persistence object will be the name of the dictionary key unless overwritten with persistence.*.nameOverride TODO: NOT IMPLEMENTED |
| persistence.example.appName | string | `"example"` | Name of the app to attach this persistence eobject. This corresponds to an app configured un the `apps` key TODO: NOT IMPLEMENTED Should this be optional or mandatory? Safe to assume that any persistent object should be mounted by something? |
| persistence.example.enabled | bool | `false` | Enables or disables the volume |
| persistence.example.mountPath | string | `nil` | Where to mount the volume in the primary container. Defaults to `/<name_of_the_volume>`, setting to '-' creates the volume but disables the volumeMount. |
| persistence.example.nameOverride | string | `nil` | Override the name that is used for this persistence object TODO: NOT IMPLEMENTED |
| persistence.example.persistentVolume | object | `{"spec":{"accessModes":["ReadWriteOnce"],"capacity":{"storage":"1Gi"},"hostPath":{"path":"/tmp/data1"},"reclaimPolicy":["Recycle"]}}` | Configure a persistentVolume and persistentVolumeClaim pair to be mounted to the app's primary container |
| persistence.example.persistentVolume.spec | object | `{"accessModes":["ReadWriteOnce"],"capacity":{"storage":"1Gi"},"hostPath":{"path":"/tmp/data1"},"reclaimPolicy":["Recycle"]}` | Reference - https://kubernetes.io/docs/concepts/storage/persistent-volumes/ |
| persistence.example.persistentVolumeClaim | object | `{"existingClaimName":null,"spec":{"accessModes":["ReadWriteOnce"],"persistentVolumeReclaimPolicy":"Retain","resources":{"requests":{"storage":"8Gi"}},"selector":{"matchExpressions":[{"key":"environment","operator":"In","values":["dev"]}],"matchLabels":{"release":"stable"}},"storageClassName":"slow","volumeMode":"Filesystem"}}` | Configure a Persistent Volume Claim to be mounted to the app's primary container |
| persistence.example.persistentVolumeClaim.existingClaimName | string | `nil` | Existing Persistent Volume Claim name. Takes precedence over persistentVolumeClaim.spec  |
| persistence.example.persistentVolumeClaim.spec | object | `{"accessModes":["ReadWriteOnce"],"persistentVolumeReclaimPolicy":"Retain","resources":{"requests":{"storage":"8Gi"}},"selector":{"matchExpressions":[{"key":"environment","operator":"In","values":["dev"]}],"matchLabels":{"release":"stable"}},"storageClassName":"slow","volumeMode":"Filesystem"}` | Reference - https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims |
| persistence.example.readOnly | bool | `false` | Specify if the volume should be mounted read-only. |
| persistence.example.subPath | string | `nil` | Used in conjunction with `existingClaim`. Specifies a sub-path inside the referenced volume instead of its root |
| persistence.example.type | string | `"persistentVolumeClaim"` | Volume type. Available options are ["volume", "persistentVolume," "persistentVolumeClaim"] type.volume is a static volume definition directly on an app type.persistentVolume creates a PV and a PVC pair and uses the PVC as a volume on the app type.persistentVolumeClaim creates a new PVC or uses an existing PVC as a volume on the app |
| persistence.example.volume | object | `{"spec":{"hostPath":{"path":"/tmp/data1","type":"DirectoryOrCreate"}}}` | Configure a volume to be mounted directly to the app's primary container |
| persistence.example.volume.spec | object | `{"hostPath":{"path":"/tmp/data1","type":"DirectoryOrCreate"}}` | Reference - https://kubernetes.io/docs/concepts/storage/volumes |
| secrets | object | See below | Configure the secrets for the chart here. Additional secrets can be added by adding a dictionary key similar to the 'exampleSecret' secret. TODO: nameOverride TODO: Ensure sha annotations on app are working |
| secrets.exampleSecret.annotations | object | `{}` | Annotations to add to the secret |
| secrets.exampleSecret.data | object | `{}` | configMap data content. Helm template enabled. |
| secrets.exampleSecret.enabled | bool | `false` | Enables or disables the secret |
| secrets.exampleSecret.labels | object | `{}` | Labels to add to the secret |
| secrets.exampleSecret.nameOverride | string | `nil` | Override the name that is used for this service |
| services | object | See below | Configure the services for the chart here. Additional services can be added by adding a dictionary key similar to the 'example' service. TODO: nameOverride |
| services.example.annotations | object | `{}` | Provide additional annotations which may be required. |
| services.example.appName | string | `"example"` | Name of the app to attach this service. This corresponds to an app configured un the `apps` key TODO: Accept a list of appnames of which to associate the service TODO: Needs to be optional |
| services.example.enabled | bool | `false` | Enables or disables the service |
| services.example.externalTrafficPolicy | string | `nil` | [[ref](https://kubernetes.io/docs/tutorials/services/source-ip/)] |
| services.example.ipFamilies | list | `[]` | The ip families that should be used. Options: IPv4, IPv6 |
| services.example.ipFamilyPolicy | string | `nil` | Specify the ip policy. Options: SingleStack, PreferDualStack, RequireDualStack |
| services.example.labels | object | `{}` | Provide additional labels which may be required. |
| services.example.nameOverride | string | `nil` | Override the name that is used for this service. By default the name will be the name of the dictionary key |
| services.example.ports | object | See below | Configure the Service port information here. Additional ports can be added by adding a dictionary key similar to the 'http' service. |
| services.example.ports.http.enabled | bool | `true` | Enables or disables the port |
| services.example.ports.http.nodePort | string | `nil` | Specify the nodePort value for the LoadBalancer and NodePort service types. [[ref]](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport) |
| services.example.ports.http.port | string | `nil` | The port number |
| services.example.ports.http.protocol | string | `"HTTP"` | Port protocol. Support values are `HTTP`, `HTTPS`, `TCP` and `UDP`. HTTPS and HTTPS spawn a TCP service and get used for internal URL and name generation |
| services.example.ports.http.targetPort | string | `nil` | Specify a service targetPort if you wish to differ the service port from the application port. If `targetPort` is specified, this port number is used in the container definition instead of the `port` value. Therefore named ports are not supported for this field. |
| services.example.selector | object | `{}` | Labels selector(s) for the service to associate Pods as Endpoints. This takes precedence over services.*.appName TODO: Not Implemented |
| services.example.type | string | `"ClusterIP"` | Set the service type |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
