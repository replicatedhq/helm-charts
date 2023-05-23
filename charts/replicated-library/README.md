# replicated-library

![Version: 0.13.2](https://img.shields.io/badge/Version-0.13.2-informational?style=flat-square) ![Type: library](https://img.shields.io/badge/Type-library-informational?style=flat-square)

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
helm-docs -t README.md.gotmpl -t README_CHANGELOG.md.gotmpl -t README_CONFIG.md.gotmpl -f values-example.yaml
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
  version: 0.13.2
```

You can see a full example of this library chart in use [here](https://github.com/replicatedhq/replicated-starter-helm)

## Features

Below highlights some of the useful features available in this library

* [Dynamic App Reload on Configuration Changes](FEATURES.md#dynamic-app-reload-on-configuration-changes)
* [App, Service, and Ingress Association](FEATURES.md#app-service-and-ingress-association)

## Advanced Templating

[Examples of how you can advanced templating and build on top of this library chart](ADVANCED_TEMPLATING.md)

## Values

The below table represents the full API available via the Replicated Library Chart with `example` being a placeholder for your own configuration. Source is [values-example.yaml](./values-example.yaml) file.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| apps | object | See below | Configure the apps for the chart here. Apps can be added by adding a dictionary key similar to the 'example' app. By default the name of the app will be the name of the dictionary key TODO: nameOverride TODO: Ensure sha annotations on app are working |
| apps.example.affinity | object | `{}` | Defines affinity constraint rules. [[ref]](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) |
| apps.example.annotations | object | `{}` | Set annotations on the deployment/statefulset/daemonset |
| apps.example.automountServiceAccountToken | bool | `true` | Specifies whether a service account token should be automatically mounted. |
| apps.example.containers | object | `{"example":{"args":[],"command":[],"env":null,"envFrom":[],"image":{"pullPolicy":null,"repository":"nginx","tag":"latest"},"lifecycle":{},"ports":[],"probes":{"livenessProbe":{},"readinessProbe":{},"startupProbe":{}},"resources":{},"securityContext":{},"termination":{"gracePeriodSeconds":null,"messagePath":null,"messagePolicy":null},"volumeMounts":[]}}` | Specify any initContainers here as dictionary items. Each initContainer should have its own key. |
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
| apps.example.initContainers | object | `{}` | Specify any initContainers here as dictionary items. Each initContainer should have its own key. The dictionary item key will determine the order. All of the same values from .Values.apps.example.containers are valid here with the exception of probes. |
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
| apps.example.strategy | string | `nil` | Set the controller upgrade strategy For Deployments, valid values are Recreate and RollingUpdate. For StatefulSets, valid values are OnDelete and RollingUpdate. For Daemonsets, valid values are OnDelete and RollingUpdate. |
| apps.example.tolerations | list | `[]` | Specify taint tolerations [[ref]](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) |
| apps.example.topologySpreadConstraints | list | `[]` | Defines topologySpreadConstraint rules. [[ref]](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/) |
| apps.example.type | string | `"deployment"` | Specify the controller type. Valid options are deployment, daemonset or statefulset |
| apps.example.volumeClaimTemplates | list | `[]` | Used to create individual disks for each instance when type: StatefulSet |
| apps.example.volumes | list | `[]` | Specify a list of volumes that get mounted to the app. persistentVolumeClaims which are present and enabled in the persistence configuraiton will have the prefix added automatically. |
| configmaps | object | See below | Configure the configmaps for the chart here. Configmaps can be added by adding a dictionary key similar to the 'exampleConfig' configmap. By default the name of the configmap will be the name of the dictionary key TODO: nameOverride TODO: Ensure sha annotations on app are working |
| configmaps.exampleConfig.annotations | object | `{}` | Annotations to add to the configMap |
| configmaps.exampleConfig.appReload | bool | `true` | When `true`, the feature to automatically re-deploy an App's pod when the ConfigMap changes is enabled. |
| configmaps.exampleConfig.data | object | `{}` | configMap data content. Helm template enabled. |
| configmaps.exampleConfig.enabled | bool | `false` | Enables or disables the configMap |
| configmaps.exampleConfig.fullNameOverride | string | `nil` | Override the name of this object. Default name if not overwritten will be releaseName-ChartName-objectName |
| configmaps.exampleConfig.labels | object | `{}` | Labels to add to the configMap |
| global.annotations | object | `{}` | Set additional global annotations. |
| global.appReload | bool | `true` | When `true`, the feature to automatically re-deploy an App's pod when a ConfigMap or Secret changes is enabled. |
| global.fullNameOverride | string | `nil` | Set the full object prefix, defaults to releasName-ChartName if not set. This value takes precedence over nameOverride. Set to "-" to disable object name prefixing. |
| global.labels | object | `{}` | Set additional global labels. |
| global.nameOverride | string | `nil` | Set an override for the ChartName, defaults to ChartName if not set. |
| ingresses | object | See below | Configure the ingresses for the chart here. Ingresses can be added by adding a dictionary key similar to the 'example' ingress. Name of the ingress object will be the name of the dictionary key |
| ingresses.example.annotations | object | `{}` | Provide additional annotations |
| ingresses.example.enabled | bool | `false` | Enables or disables the ingress |
| ingresses.example.fullNameOverride | string | `nil` | Override the name of this object. Default name if not overwritten will be releaseName-ChartName-objectName |
| ingresses.example.hosts | list | `[{"host":"chart-example.local","paths":[{"path":"/","pathType":"Prefix","service":{"name":null,"port":null}}]}]` | Configure the hosts for the ingress |
| ingresses.example.hosts[0].paths[0].service.name | string | `nil` | Service Name for the path. By default this is ingresses.example.serviceName if not overwritten TODO: NOT IMPLEMENTED |
| ingresses.example.ingressClassName | string | `nil` | Set the ingressClass that is used for this ingress. Requires Kubernetes >=1.19 |
| ingresses.example.labels | object | `{}` | Provide additional labels |
| ingresses.example.serviceName | string | `"example"` | Name of the service to attach this ingress. This corresponds to an service configured un the `services` key |
| persistence | object | See below | Configure volumes for the chart here. Persistence items can be added by adding a dictionary key similar to the 'example' key. Name of the persistence object will be the name of the dictionary key unless overwritten with persistence.*.nameOverride |
| persistence.example.enabled | bool | `false` | Enables or disables the volume |
| persistence.example.fullNameOverride | string | `nil` | Override the name of this object. Default name if not overwritten will be releaseName-ChartName-objectName |
| persistence.example.persistentVolume | object | `{"spec":{"accessModes":["ReadWriteOnce"],"capacity":{"storage":"1Gi"},"hostPath":{"path":"/tmp/data1"},"reclaimPolicy":["Recycle"]}}` | Configure a persistentVolume and persistentVolumeClaim pair to be mounted to the app's primary container TODO: Not implemented |
| persistence.example.persistentVolume.spec | object | `{"accessModes":["ReadWriteOnce"],"capacity":{"storage":"1Gi"},"hostPath":{"path":"/tmp/data1"},"reclaimPolicy":["Recycle"]}` | PersistentVolumeClaim spec [[ref]](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) |
| persistence.example.persistentVolumeClaim | object | `{"existingClaimName":null,"spec":{"accessModes":["ReadWriteOnce"],"persistentVolumeReclaimPolicy":"Retain","resources":{"requests":{"storage":"8Gi"}},"storageClassName":"slow","volumeMode":"Filesystem"}}` | Configure a Persistent Volume Claim to be mounted to the app's primary container |
| persistence.example.persistentVolumeClaim.existingClaimName | string | `nil` | Existing Persistent Volume Claim name. Takes precedence over persistentVolumeClaim.spec |
| persistence.example.persistentVolumeClaim.spec | object | `{"accessModes":["ReadWriteOnce"],"persistentVolumeReclaimPolicy":"Retain","resources":{"requests":{"storage":"8Gi"}},"storageClassName":"slow","volumeMode":"Filesystem"}` | PersistentVolumeClaim spec [[ref]](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims) |
| persistence.example.type | string | `"persistentVolumeClaim"` | Volume type. Available options are ["persistentVolume," "persistentVolumeClaim"] type.persistentVolume creates a PV and a PVC pair and uses the PVC as a volume on the app type.persistentVolumeClaim creates a new PVC or uses an existing PVC as a volume on the app TODO: type.persistentVolume not implemented |
| roleBindings | object | See below | Configure the roleBindings for the chart here. RoleBindings can be added by adding a dictionary key similar to the 'example' roleBinding. By default the name of the roleBinding will be the name of the dictionary key unless overridden with roleBindings.*.nameOverride |
| roleBindings.example.annotations | object | `{}` | Annotations to add to the clusterRole |
| roleBindings.example.enabled | bool | `false` | Enables or disables the roleBinding |
| roleBindings.example.fullNameOverride | string | `nil` | Override the name of this object. Default name if not overwritten will be releaseName-ChartName-objectName |
| roleBindings.example.kind | string | `"RoleBinding"` | Type of roleBinding. Must be either: ["RoleBinding", "ClusterRoleBinding"] |
| roleBindings.example.labels | object | `{}` | Labels to add to the clusterRole |
| roleBindings.example.roleRef | object | `{"kind":"Role","name":"example"}` | The Role to bind to the ServiceAccount |
| roleBindings.example.roleRef.kind | string | `"Role"` | Type of roleBinding. Must be either: ["RoleBinding", "ClusterRoleBinding"].  If the roleBinding is a ClusterRoleBinding, then roleRef.kind must be set to ClusterRole |
| roleBindings.example.roleRef.name | string | `"example"` | Name of the Role to bind to subjects.  If roleRef.kind: is set to ClusterRoleBinding, then name must be the name of a ClusterRole |
| roleBindings.example.subjects | list | `[{"kind":"ServiceAccount","name":"example","namespace":null}]` | Name of the service account to bind to the role |
| roleBindings.example.subjects[0] | object | `{"kind":"ServiceAccount","name":"example","namespace":null}` | Name of the service account to bind to the role |
| roleBindings.example.subjects[0].kind | string | `"ServiceAccount"` | Kind of the service account to bind to the role.  Optional.  Defaults to ServiceAccount.  Must be one of: ["ServiceAccount", "User", "Group"].  Currently, only ServiceAccount is supported. |
| roles | object | See below | Configure the roles for the chart here. Roles can be added by adding a dictionary key similar to the 'example' role. By default the name of the role will be the name of the dictionary key unless overridden with roles.*.nameOverride TODO: implement aggregated ClusterRoles |
| roles.example.aggregationRule | object | `{}` | Define the selectors used for aggregated ClusterRoles.  Only used with ClusterRoles. |
| roles.example.annotations | object | `{}` | Annotations to add to the role |
| roles.example.enabled | bool | `false` | Enables or disables the role |
| roles.example.fullNameOverride | string | `nil` | Override the name of this object. Default name if not overwritten will be releaseName-ChartName-objectName |
| roles.example.kind | string | `"Role"` | Type of role. Must be either: ["Role", "ClusterRole"] |
| roles.example.labels | object | `{}` | Labels to add to the role |
| roles.example.rules | list | `[]` | Configure the rules for the role |
| secrets | object | See below | Configure the secrets for the chart here. Secrets can be added by adding a dictionary key similar to the 'exampleSecret' secret. By default the name of the secret will be the name of the dictionary key TODO: nameOverride TODO: Ensure sha annotations on app are working |
| secrets.exampleSecret.annotations | object | `{}` | Annotations to add to the secret |
| secrets.exampleSecret.appReload | bool | `true` | When `true`, the feature to automatically re-deploy an App's pod when the Secret changes is enabled. |
| secrets.exampleSecret.data | object | `{}` | configMap data content. Helm template enabled. |
| secrets.exampleSecret.enabled | bool | `false` | Enables or disables the secret |
| secrets.exampleSecret.fullNameOverride | string | `nil` | Override the name of this object. Default name if not overwritten will be releaseName-ChartName-objectName |
| secrets.exampleSecret.labels | object | `{}` | Labels to add to the secret |
| serviceAccounts | object | See below | Configure the serviceAccounts for the chart here. ServiceAccounts can be added by adding a dictionary key similar to the 'example' serviceAccount. By default the name of the serviceAccount will be the name of the dictionary key unless overridden with serviceAccounts.*.nameOverride |
| serviceAccounts.example.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccounts.example.enabled | bool | `false` | Enables or disables the service account |
| serviceAccounts.example.fullNameOverride | string | `nil` | Override the name of this object. Default name if not overwritten will be releaseName-ChartName-objectName |
| serviceAccounts.example.labels | object | `{}` | Labels to add to the service account |
| services | object | See below | Configure the services for the chart here. Services can be added by adding a dictionary key similar to the 'example' service. By default the name of the service will be the name of the dictionary key TODO: nameOverride |
| services.example.annotations | object | `{}` | Provide additional annotations which may be required. |
| services.example.appName | list | `["example"]` | Optional list of apps to attach this service. This corresponds to apps configured in the `apps` key |
| services.example.clusterIP | string | `nil` | Set the clusterIP To deploy a headless service, set clusterIP: "None" |
| services.example.enabled | bool | `false` | Enables or disables the service |
| services.example.externalTrafficPolicy | string | `nil` | [[ref](https://kubernetes.io/docs/tutorials/services/source-ip/)] |
| services.example.fullNameOverride | string | `nil` | Override the name of this object. Default name if not overwritten will be releaseName-ChartName-objectName |
| services.example.ipFamilies | list | `[]` | The ip families that should be used. Options: IPv4, IPv6 |
| services.example.ipFamilyPolicy | string | `nil` | Specify the ip policy. Options: SingleStack, PreferDualStack, RequireDualStack |
| services.example.labels | object | `{}` | Provide additional labels which may be required. |
| services.example.ports | object | See below | Configure the Service port information here. Additional ports can be added by adding a dictionary key similar to the 'http' service. |
| services.example.ports.http.enabled | bool | `true` | Enables or disables the port |
| services.example.ports.http.nodePort | string | `nil` | Specify the nodePort value for the LoadBalancer and NodePort service types. [[ref]](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport) |
| services.example.ports.http.port | string | `nil` | The port number |
| services.example.ports.http.protocol | string | `"HTTP"` | Port protocol. Support values are `HTTP`, `HTTPS`, `TCP` and `UDP`. HTTPS and HTTPS spawn a TCP service and get used for internal URL and name generation |
| services.example.ports.http.targetPort | string | `nil` | Specify a service targetPort if you wish to differ the service port from the application port. If `targetPort` is specified, this port number is used in the container definition instead of the `port` value. Therefore named ports are not supported for this field. |
| services.example.selector | object | `{}` | Label sleector(s) for the service to associate Pods as Endpoints. This takes precedence over services.*.appName |
| services.example.type | string | `"ClusterIP"` | Set the service type |
| troubleshoot | object | See below | Configure the troubleshoot for the chart here. troubleshoot can be added by adding a dictionary key. By default the supportBundle default spec from replicated will be disabled and not installed |
| troubleshoot.preflights.my-preflights | object | `{"analyzers":[{"textAnalyze":{"checkName":"Said hi!","fileName":"/static-hi.log","outcomes":[{"fail":{"message":"Didn't say hi."}},{"pass":{"message":"Said hi!"}}],"regex":"hi static"}}],"collectors":[{"run":{"collectorName":"static-hi","command":["echo","hi static!"],"image":"alpine:3"}}],"enabled":true,"image":"replicated/preflight:latest"}` | Add custom support preflight spec here |
| troubleshoot.preflights.my-preflights.enabled | bool | `true` | Enables or disables the preflight |
| troubleshoot.preflights.my-preflights.image | string | `"replicated/preflight:latest"` | Specify the replicated preflight image for the container |
| troubleshoot.support-bundles | object | `{"replicated":{"enabled":true,"my-custom-bundle":{"collectors":[{"clusterInfo":{}},{"clusterResources":{}},{"ceph":{}},{"longhorn":{}},{"logs":{"collectorName":"wg-easy","containerNames":["wg-easy"],"namespace":"default","selector":{"app":"wg-easy"}}},{"logs":{"collectorName":"some-postgres-db","selector":{"app":"some-postgres-db"}}}],"enabled":true},"uri":"https://raw.githubusercontent.com/replicatedhq/troubleshoot-specs/main/in-cluster/default.yaml"}}` | Specify the type of troubleshoot, Preflight or SupportBundle |
| troubleshoot.support-bundles.replicated.enabled | bool | `true` | Enables or disables the support bundle |
| troubleshoot.support-bundles.replicated.my-custom-bundle | object | `{"collectors":[{"clusterInfo":{}},{"clusterResources":{}},{"ceph":{}},{"longhorn":{}},{"logs":{"collectorName":"wg-easy","containerNames":["wg-easy"],"namespace":"default","selector":{"app":"wg-easy"}}},{"logs":{"collectorName":"some-postgres-db","selector":{"app":"some-postgres-db"}}}],"enabled":true}` | Add custom support bundles here |
| troubleshoot.support-bundles.replicated.uri | string | `"https://raw.githubusercontent.com/replicatedhq/troubleshoot-specs/main/in-cluster/default.yaml"` | Default spec to install |

## Changelog

All notable changes to this library Helm chart will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

### [Unreleased]

#### Added

- Added capability to override service name for ingress hosts (shortcut story - 71019)

### [0.13.2]

#### Added

- Add support for preflights specs

### [0.13.1]

#### Changed

- Rename `troubleshoot.support-bundle` to `troubleshoot.support-bundles`

### [0.13.0]

#### Added

- Add support for support bundle specs

### [0.12.2]

- Tidied up extra whitespace for pod and conatiner templates

### [0.12.1]

#### Fixed

- Fixed an issue when specifying multiple containers in a single app caused the chart to fail to render

### [0.12.0]

#### Added

- Added support for RBAC objects

### [0.11.1]

#### Fixed

- Fixed an issue in YAML formatting that was causing `imagePullSecrets` not to render properly in Pod spec
- Fixed an issue with the logic to automatically set Readiness and Liveness probes if ports.containerPort is defined

### [0.11.0]

#### Changed

- Apps using ConfigMaps and Secrets as volumes or env vars will now have their pods automatically re-deployed whenever the data in the configmap or secret changes
- **NOTE**: This only applies to `volumes` and `envFrom`. This feature has not yet been implementd for `env`

### [0.10.0]

#### Changed

- The `replicated-library.names.fullname` template will now trim a leading or trailing hyphen to prevent invalid names when the prefix is empty

#### Fixed

- Init containers now work as expected and follow the same format as containers

### [0.9.0]

#### Changed

- Adding Global "Context" dictionaries for values and names with unique subkeys per object type to prevent collisions
- Removing class directory and collapsing all templates into a single directory
- Altered helm-docs to generate documentation from values-example.yaml file.

### [0.8.0]

#### Changed

- Fixed volumeClaimTemplate loop in lib/_statefulset.tpl so metadata.name is rendered correctly.
- Added daemonset templates

### [0.7.1]
#### Changed

- Fix fullNameOverride to work with a null input rather than just an empty string.
- Remove configmap name override, fixes label errors when configmaps are included.

### [0.7.0]
#### Changed

- BREAKING: The `appName` key for services is now an optional list instead of a string. Charts using the previous implementation will need to convert the string into a single entry list which will work as before.
- Services `selector` now overrides selectors set by `appName`.
- If no `appName` or `selector` is defined, we try and match on the service name itself

### [0.6.1]
#### Changed

- Fixed automatic prefix on volumes

### [0.6.0]
#### Added

- Added Statefulsets template
- Added a prefix function

### [0.5.3]
#### Added

- Automatically add prefix to Statefulset volumes if it's a volume defined and enabled in the chart

### [0.5.2]
#### Added

- added capability to set type of secret.

### [0.5.1]
#### Changed

- fix spelling error in pod annotations
- fix label selector using chart name instead of app name

### [0.5.0]
#### Changed

- Add a unique prefix with global overrides to prevent multiple installs from conflicting.
- Update readme for Advanced Templating clarification

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
