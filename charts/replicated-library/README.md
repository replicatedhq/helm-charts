# replicated-library

![Version: 0.5.0](https://img.shields.io/badge/Version-0.5.0-informational?style=flat-square) ![Type: library](https://img.shields.io/badge/Type-library-informational?style=flat-square)

Replicated library chart

This is a library chart maintained by Replicated in order to keep the creation of helm charts dry when deploying third party commercial software

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies
| Repository | Name | Version |
|------------|------|---------|

## Updating the README

We use [Helm Docs](https://github.com/norwoodj/helm-docs)

```
helm-docs -t README.md.gotmpl -t README_CHANGELOG.md.gotmpl -t README_CONFIG.md.gotmpl
```

## Installing the Chart

This is a [Helm Library Chart](https://helm.sh/docs/topics/library_charts/#helm).

**WARNING: THIS CHART IS NOT MEANT TO BE INSTALLED DIRECTLY**

## Using this library

Include the chart as a dependency in your `Chart.yaml`

```yaml
# Chart.yaml
dependencies:
- name: replicated-library
  repository: https://replicatedhq.github.io/helm-charts
  version: 0.5.0
```

You can see an example of this library chart in use [here](https://github.com/replicatedhq/replicated-starter-helm/tree/replicated-library-chart)

## Breaking the Glass

[Examples of how you can break glass and build on top of this library chart](BREAK_GLASS.md)

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| apps | object | See below | Configure the apps for the chart here. Apps can be added by adding a dictionary key similar to the 'example' app. By default the name of the app will be the name of the dictionary key TODO: nameOverride TODO: Ensure sha annotations on app are working |
| apps.example.affinity | object | `{}` | Defines affinity constraint rules. [[ref]](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) |
| apps.example.annotations | object | `{}` | Set annotations on the deployment/statefulset/daemonset |
| apps.example.automountServiceAccountToken | bool | `true` | Specifies whether a service account token should be automatically mounted. |
| apps.example.containers.example.args | list | `[]` | Override the arguments for the container |
| apps.example.containers.example.command | list | `[]` | Override the command for the container |
| apps.example.containers.example.env | string | `nil` | Environment variables. Template enabled. Syntax options: DATABASE_USER: USERNAME |
| apps.example.containers.example.envFrom | list | `[]` | Secrets and/or ConfigMaps that will be loaded as environment variables. [[ref]](https://unofficial-kubernetes.readthedocs.io/en/latest/tasks/configure-pod-container/configmap/#use-case-consume-configmap-in-environment-variables) |
| apps.example.containers.example.image.pullPolicy | string | `nil` | Specify the image pull policy for the container |
| apps.example.containers.example.image.repository | string | `"nginx"` | Specify the image repository for the container |
| apps.example.containers.example.image.tag | string | `"latest"` | Specify the image tag for the container |
| apps.example.containers.example.lifecycle | object | `{}` | Configure the lifecycle for the container |
| apps.example.containers.example.ports | list | `[]` | Specify the ports for the container [[ref]](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#ports) |
| apps.example.containers.example.probes | object | `{"livenessProbe":{},"readinessProbe":{},"startupProbe":{}}` | Specify probes for the container [[ref]](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| apps.example.containers.example.probes.livenessProbe | object | `{}` | Specify the liveness probes for the container |
| apps.example.containers.example.probes.readinessProbe | object | `{}` | Specify the readiness probes for the container |
| apps.example.containers.example.probes.startupProbe | object | `{}` | Specify the startup probes for the container |
| apps.example.containers.example.resources | object | `{}` | Set the resource requests / limits for the container. |
| apps.example.containers.example.termination.gracePeriodSeconds | string | `nil` | [[ref](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle)] |
| apps.example.containers.example.termination.messagePath | string | `nil` | [[ref](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle-1)] |
| apps.example.containers.example.termination.messagePolicy | string | `nil` | [[ref](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle-1)] |
| apps.example.containers.example.volumeMounts | list | `[]` | Specify a list of volumes mounts in the container. |
| apps.example.dnsConfig | object | `{}` | Optional DNS settings, configuring the ndots option may resolve nslookup issues on some Kubernetes setups. |
| apps.example.dnsPolicy | string | `nil` | Defaults to "ClusterFirst" if hostNetwork is false and "ClusterFirstWithHostNet" if hostNetwork is true. |
| apps.example.enableServiceLinks | bool | `true` | Enable/disable the generation of environment variables for services. [[ref]](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/#accessing-the-service) |
| apps.example.enabled | bool | `false` | Enable the app Each app represents a single controller type (deployment, daemonset, statefulset) |
| apps.example.hostAliases | list | `[]` | Use hostAliases to add custom entries to /etc/hosts - mapping IP addresses to hostnames. [[ref]](https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/) |
| apps.example.hostNetwork | bool | `false` | When using hostNetwork make sure you set dnsPolicy to `ClusterFirstWithHostNet` |
| apps.example.hostname | string | `nil` | Allows specifying explicit hostname setting |
| apps.example.imagePullSecrets | list | `[]` | Specify one or more image pull secrets for the app |
| apps.example.initContainers | object | `{}` | Specify any initContainers here as dictionary items. Each initContainer should have its own key. The dictionary item key will determine the order. |
| apps.example.labels | object | `{}` | Set labels on the deployment/statefulset/daemonset |
| apps.example.nodeSelector | object | `{}` | Node selection constraint [[ref]](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) |
| apps.example.podAnnotations | object | `{}` | Set annotations on the pod |
| apps.example.podLabels | object | `{}` | Set labels on the pod |
| apps.example.podManagementPolicy | string | `nil` | Set statefulset podManagementPolicy, valid values are Parallel and OrderedReady (default). |
| apps.example.podSecurityContext | object | `{}` | Configure the Security Context for the Pod |
| apps.example.priorityClassName | string | `nil` | Custom priority class for different treatment by the scheduler |
| apps.example.replicas | int | `1` | Set the replica count. Only used for deployment and statefulset |
| apps.example.revisionHistoryLimit | int | `3` | ReplicaSet revision history limit |
| apps.example.rollingUpdate.partition | string | `nil` | Set statefulset RollingUpdate partition |
| apps.example.rollingUpdate.surge | string | `nil` | Set deployment RollingUpdate max surge |
| apps.example.rollingUpdate.unavailable | string | `nil` | Set deployment RollingUpdate max unavailable |
| apps.example.runtimeClassName | string | `nil` | Allow specifying a runtimeClassName other than the default one (ie: nvidia) |
| apps.example.schedulerName | string | `nil` | Allows specifying a custom scheduler name |
| apps.example.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| apps.example.serviceAccount.create | bool | `false` | Specifies whether a service account should be created |
| apps.example.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| apps.example.strategy | string | `nil` | Set the controller upgrade strategy For Deployments, valid values are Recreate and RollingUpdate. For StatefulSets, valid values are OnDelete and RollingUpdate. For Daemonsets, valid values are OnDelete and RollingUpdate. |
| apps.example.tolerations | list | `[]` | Specify taint tolerations [[ref]](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) |
| apps.example.topologySpreadConstraints | list | `[]` | Defines topologySpreadConstraint rules. [[ref]](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/) |
| apps.example.type | string | `"deployment"` | Specify the controller type. Valid options are deployment, daemonset or statefulset TODO: daemonset and statefulset When deployment type: statefulset: - Configure service as headless in services section - If require persistent storage, use apps.volumeClaimTemplates section to define a volumeClaimTemplate. Ensure that persistence is disabled. |
| apps.example.volumeClaimTemplates | list | `[]` | Used to create individual disks for each instance when type: StatefulSet |
| apps.example.volumes | list | `[]` | Specify a list of volumes that get mounted to the app. |
| configmaps | object | See below | Configure the configmaps for the chart here. Configmaps can be added by adding a dictionary key similar to the 'exampleConfig' configmap. By default the name of the configmap will be the name of the dictionary key TODO: nameOverride TODO: Ensure sha annotations on app are working |
| configmaps.exampleConfig.annotations | object | `{}` | Annotations to add to the configMap |
| configmaps.exampleConfig.data | object | `{}` | configMap data content. Helm template enabled. |
| configmaps.exampleConfig.enabled | bool | `false` | Enables or disables the configMap |
| configmaps.exampleConfig.labels | object | `{}` | Labels to add to the configMap |
| configmaps.exampleConfig.nameOverride | string | `nil` | Override the name suffix that is used for this configap |
| defaults.image.pullPolicy | string | `"IfNotPresent"` |  |
| defaults.probes.livenessProbe.failureThreshold | int | `5` |  |
| defaults.probes.livenessProbe.initialDelaySeconds | int | `0` |  |
| defaults.probes.livenessProbe.periodSeconds | int | `10` |  |
| defaults.probes.livenessProbe.successThreshold | int | `1` |  |
| defaults.probes.livenessProbe.terminationGracePeriodSeconds | int | `30` |  |
| defaults.probes.livenessProbe.timeoutSeconds | int | `5` |  |
| defaults.probes.readinessProbe.failureThreshold | int | `5` |  |
| defaults.probes.readinessProbe.initialDelaySeconds | int | `0` |  |
| defaults.probes.readinessProbe.periodSeconds | int | `10` |  |
| defaults.probes.readinessProbe.successThreshold | int | `1` |  |
| defaults.probes.readinessProbe.timeoutSeconds | int | `1` |  |
| defaults.probes.startupProbe | object | `{}` |  |
| defaults.strategy | string | `"RollingUpdate"` |  |
| global.annotations | object | `{}` | Set additional global annotations. |
| global.labels | object | `{}` | Set additional global labels. |
| ingresses | object | See below | Configure the ingresses for the chart here. Ingresses can be added by adding a dictionary key similar to the 'example' ingress. Name of the ingress object will be the name of the dictionary key |
| ingresses.example.annotations | object | `{}` | Provide additional annotations which may be required. |
| ingresses.example.enabled | bool | `false` | Enables or disables the ingress |
| ingresses.example.hosts | list | `[{"host":"chart-example.local","paths":[{"path":"/","pathType":"Prefix","service":{"name":null,"port":null}}]}]` | Configure the hosts for the ingress |
| ingresses.example.hosts[0].paths[0].service.name | string | `nil` | Service Name for the path. By default this is ingresses.example.serviceName if not overwritten TODO: NOT IMPLEMENTED |
| ingresses.example.ingressClassName | string | `nil` | Set the ingressClass that is used for this ingress. Requires Kubernetes >=1.19 |
| ingresses.example.labels | object | `{}` | Provide additional labels which may be required. |
| ingresses.example.nameOverride | string | `nil` | Override the name that is used for this ingress. By default the name will be the name of the dictionary key |
| ingresses.example.serviceName | string | `"example"` | Name of the service to attach this ingress. This corresponds to an service configured un the `services` key |
| persistence | object | See below | Configure volumes for the chart here. Persistence items can be added by adding a dictionary key similar to the 'example' key. Name of the persistence object will be the name of the dictionary key unless overwritten with persistence.*.nameOverride |
| persistence.example.enabled | bool | `false` | Enables or disables the volume |
| persistence.example.nameOverride | string | `nil` | Override the name that is used for this persistence object TODO: NOT IMPLEMENTED |
| persistence.example.persistentVolume | object | `{"spec":{"accessModes":["ReadWriteOnce"],"capacity":{"storage":"1Gi"},"hostPath":{"path":"/tmp/data1"},"reclaimPolicy":["Recycle"]}}` | Configure a persistentVolume and persistentVolumeClaim pair to be mounted to the app's primary container TODO: Not implemented |
| persistence.example.persistentVolume.spec | object | `{"accessModes":["ReadWriteOnce"],"capacity":{"storage":"1Gi"},"hostPath":{"path":"/tmp/data1"},"reclaimPolicy":["Recycle"]}` | PersistentVolumeClaim spec [[ref]](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) |
| persistence.example.persistentVolumeClaim | object | `{"existingClaimName":null,"spec":{"accessModes":["ReadWriteOnce"],"persistentVolumeReclaimPolicy":"Retain","resources":{"requests":{"storage":"8Gi"}},"storageClassName":"slow","volumeMode":"Filesystem"}}` | Configure a Persistent Volume Claim to be mounted to the app's primary container |
| persistence.example.persistentVolumeClaim.existingClaimName | string | `nil` | Existing Persistent Volume Claim name. Takes precedence over persistentVolumeClaim.spec |
| persistence.example.persistentVolumeClaim.spec | object | `{"accessModes":["ReadWriteOnce"],"persistentVolumeReclaimPolicy":"Retain","resources":{"requests":{"storage":"8Gi"}},"storageClassName":"slow","volumeMode":"Filesystem"}` | PersistentVolumeClaim spec [[ref]](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims) |
| persistence.example.type | string | `"persistentVolumeClaim"` | Volume type. Available options are ["persistentVolume," "persistentVolumeClaim"] type.persistentVolume creates a PV and a PVC pair and uses the PVC as a volume on the app type.persistentVolumeClaim creates a new PVC or uses an existing PVC as a volume on the app TODO: type.persistentVolume not implemented |
| secrets | object | See below | Configure the secrets for the chart here. Secrets can be added by adding a dictionary key similar to the 'exampleSecret' secret. By default the name of the secret will be the name of the dictionary key TODO: nameOverride TODO: Ensure sha annotations on app are working |
| secrets.exampleSecret.annotations | object | `{}` | Annotations to add to the secret |
| secrets.exampleSecret.data | object | `{}` | configMap data content. Helm template enabled. |
| secrets.exampleSecret.enabled | bool | `false` | Enables or disables the secret |
| secrets.exampleSecret.labels | object | `{}` | Labels to add to the secret |
| secrets.exampleSecret.nameOverride | string | `nil` | Override the name suffix that is used for this secret |
| services | object | See below | Configure the services for the chart here. Services can be added by adding a dictionary key similar to the 'example' service. By default the name of the service will be the name of the dictionary key TODO: nameOverride |
| services.example.annotations | object | `{}` | Provide additional annotations which may be required. |
| services.example.appName | string | `"example"` | Name of the app to attach this service. This corresponds to an app configured un the `apps` key TODO: Accept a list of appnames of which to associate the service TODO: Needs to be optional |
| services.example.clusterIP | string | `nil` | Set the clusterIP To deploy a headless service, set clusterIP: "None" |
| services.example.enabled | bool | `false` | Enables or disables the service |
| services.example.externalTrafficPolicy | string | `nil` | [[ref](https://kubernetes.io/docs/tutorials/services/source-ip/)] |
| services.example.ipFamilies | list | `[]` | The ip families that should be used. Options: IPv4, IPv6 |
| services.example.ipFamilyPolicy | string | `nil` | Specify the ip policy. Options: SingleStack, PreferDualStack, RequireDualStack |
| services.example.labels | object | `{}` | Provide additional labels which may be required. |
| services.example.nameOverride | string | `nil` | Override the name suffix that is used for this service |
| services.example.ports | object | See below | Configure the Service port information here. Additional ports can be added by adding a dictionary key similar to the 'http' service. |
| services.example.ports.http.enabled | bool | `true` | Enables or disables the port |
| services.example.ports.http.nodePort | string | `nil` | Specify the nodePort value for the LoadBalancer and NodePort service types. [[ref]](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport) |
| services.example.ports.http.port | string | `nil` | The port number |
| services.example.ports.http.protocol | string | `"HTTP"` | Port protocol. Support values are `HTTP`, `HTTPS`, `TCP` and `UDP`. HTTPS and HTTPS spawn a TCP service and get used for internal URL and name generation |
| services.example.ports.http.targetPort | string | `nil` | Specify a service targetPort if you wish to differ the service port from the application port. If `targetPort` is specified, this port number is used in the container definition instead of the `port` value. Therefore named ports are not supported for this field. |
| services.example.selector | object | `{}` | [[ref]](https://kubernetes.io/docs/concepts/services-networking/service/#services-without-selectors) TODO: Not Implemented |
| services.example.type | string | `"ClusterIP"` | Set the service type |

## Changelog

All notable changes to this library Helm chart will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

### [0.5.0]

#### Added
- Deployment type statefulset

### [0.4.0]

#### Changed

- Livesness and Readiness probes are automatically generated if a container has ports defined
- All probe definitions moved to conatiner rather than "probes" sub-key.

### [0.3.0]

#### Changed

- Setting best practice defaults for imagePullPolicy, updateStrategy, and probes.
- Updated README to use .Chart.Version instead of hardcoding the chart version

#### Fixed
- Container image tags which were not strings failing to be templated correctly

[0.2.0]: #15
[0.1.1]: #9

## Support

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
