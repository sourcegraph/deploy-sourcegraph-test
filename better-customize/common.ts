import * as k8s from "@kubernetes/client-node";
import * as _ from "lodash";
import { readFileSync } from "fs";
import * as YAML from "yaml";
import * as path from "path";
import * as request from "request";
import { flatten } from "lodash";
import { V1ConfigMap, V1Deployment, V1Ingress, V1ObjectMeta, V1PersistentVolumeClaim, V1Service, V1StatefulSet } from "@kubernetes/client-node";

export interface Config {
  sourceDirectory: string
  additionalManifestDirectories?: string[]
  outputDirectory: string
  transformations: Transform[]
  filenameMapper: (sourceDir: string, filename: string) => string
}

export const clusterObjectKeys =  [
  'Deployments',
  'PersistentVolumeClaims',
  'PersistentVolumes',
  'Services',
  'ClusterRoles',
  'ClusterRoleBindings',
  'ConfigMaps',
  'DaemonSets',
  'Ingresss',
  'PodSecurityPolicys',
  'Roles',
  'RoleBindings',
  'ServiceAccounts',
  'Secrets',
  'StatefulSets',
'StorageClasses',
] as const

export interface Cluster {
  Deployments: [string, k8s.V1Deployment][];
  PersistentVolumeClaims: [string, k8s.V1PersistentVolumeClaim][];
  PersistentVolumes: [string, k8s.V1PersistentVolume][];
  Services: [string, k8s.V1Service][];
  ClusterRoles: [string, k8s.V1ClusterRole][];
  ClusterRoleBindings: [string, k8s.V1ClusterRoleBinding][];
  ConfigMaps: [string, k8s.V1ConfigMap][];
  DaemonSets: [string, k8s.V1DaemonSet][];
  Ingresss: [string, k8s.V1Ingress][];
  PodSecurityPolicys: [string, k8s.V1beta1PodSecurityPolicy][];
  Roles: [string, k8s.V1Role][];
  RoleBindings: [string, k8s.V1RoleBinding][];
  ServiceAccounts: [string, k8s.V1ServiceAccount][];
  Secrets: [string, k8s.V1Secret][];
  StatefulSets: [string, k8s.V1StatefulSet][];
  StorageClasses: [string, k8s.V1StorageClass][];

  RawFiles: [string, string][];
  Unrecognized: string[];
  ManualInstructions: string[];
}

export type Transform = (c: Cluster) => Promise<void>;

export const removeComponent = (name: string, kind: string): Transform => async (c: Cluster) => {
  c.Deployments = c.Deployments.filter(([,obj]) => obj.metadata?.name !== name && obj.kind !== kind)
  c.PersistentVolumeClaims = c.PersistentVolumeClaims.filter(([,obj]) => obj.metadata?.name !== name && obj.kind !== kind)
  c.PersistentVolumes = c.PersistentVolumes.filter(([,obj]) => obj.metadata?.name !== name && obj.kind !== kind)
  c.Services = c.Services.filter(([,obj]) => obj.metadata?.name !== name && obj.kind !== kind)
  c.ClusterRoles = c.ClusterRoles.filter(([,obj]) => obj.metadata?.name !== name && obj.kind !== kind)
  c.ClusterRoleBindings = c.ClusterRoleBindings.filter(([,obj]) => obj.metadata?.name !== name && obj.kind !== kind)
  c.ConfigMaps = c.ConfigMaps.filter(([,obj]) => obj.metadata?.name !== name && obj.kind !== kind)
  c.DaemonSets = c.DaemonSets.filter(([,obj]) => obj.metadata?.name !== name && obj.kind !== kind)
  c.Ingresss = c.Ingresss.filter(([,obj]) => obj.metadata?.name !== name && obj.kind !== kind)
  c.PodSecurityPolicys = c.PodSecurityPolicys.filter(([,obj]) => obj.metadata?.name !== name && obj.kind !== kind)
  c.Roles = c.Roles.filter(([,obj]) => obj.metadata?.name !== name && obj.kind !== kind)
  c.RoleBindings = c.RoleBindings.filter(([,obj]) => obj.metadata?.name !== name && obj.kind !== kind)
  c.ServiceAccounts = c.ServiceAccounts.filter(([,obj]) => obj.metadata?.name !== name && obj.kind !== kind)
  c.Secrets = c.Secrets.filter(([,obj]) => obj.metadata?.name !== name && obj.kind !== kind)
  c.StatefulSets = c.StatefulSets.filter(([,obj]) => obj.metadata?.name !== name && obj.kind !== kind)
  c.StorageClasses = c.StorageClasses.filter(([,obj]) => obj.metadata?.name !== name && obj.kind !== kind)
}

export const platform =
  (
    base: "gcp" | "aws" | "azure" | "minikube" | "generic",
    customizeStorageClass?: (sc: k8s.V1StorageClass) => void
  ): Transform =>
  (c: Cluster) => {
    const obj = YAML.parse(
      readFileSync(path.join("custom", `${base}.StorageClass.yaml`)).toString()
    );
    if (customizeStorageClass) {
      customizeStorageClass(obj);
    }
    c.StorageClasses.push(["sourcegraph.StorageClass.yaml", obj]);

    if (base === "minikube") {
      const removeResources = (
        deployOrSS: k8s.V1Deployment | k8s.V1StatefulSet
      ) => {
        deployOrSS.spec?.template.spec?.containers.forEach(
          (container) => delete container["resources"]
        );
      };
      c.Deployments.forEach(([, deployment]) => removeResources(deployment));
      c.StatefulSets.forEach(([, ss]) => removeResources(ss));
    }

    return Promise.resolve();
  };

export const ingress = (
  params:
    | {
        ingressType: "NginxIngressController";
        tls?: {
          certFile: string;
          keyFile: string;
          hostname: string;
        };
      }
    | {
        ingressType: "NginxNodePortService";
        tls: {
          certFile: string;
          keyFile: string;
        };
      }
    | {
        ingressType: "NodePort";
      }
): Transform => {
  switch (params.ingressType) {
    case "NginxIngressController":
      return ingressNginx(params.tls);
    case "NginxNodePortService":
      return serviceNginx(params.tls.certFile, params.tls.keyFile);
    case "NodePort":
      return nodePort();
    default:
        throw new Error('Unrecognized ingress type: ' + (params as any).ingressType)
  }
};

const ingressNginx =
  (tls?: { certFile: string; keyFile: string; hostname: string }): Transform =>
  async (c: Cluster) => {
    const body = await new Promise<any>((resolve) =>
      request(
        "https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.47.0/deploy/static/provider/cloud/deploy.yaml",
        (err, res, body) => {
          resolve(body);
        }
      )
    );

    // Add `deploy: sourcegraph` label
    const docs = YAML.parseAllDocuments(body);
    for (const doc of docs) {
      doc.setIn(["metadata", "labels", "deploy"], "sourcegraph");
    }

    if (tls) {
      c.Ingresss.forEach(([filepath, data]) => {
        data.spec!.tls = [
          {
            hosts: [tls.hostname],
            secretName: "sourcegraph-tls",
          },
        ];
        data.spec!.rules = [
          {
            http: {
              paths: [
                {
                  path: "/",
                  backend: {
                    service: {
                      name: "sourcegraph-frontend",
                      port: {
                        number: 300080,
                      },
                    },
                  },
                },
              ],
            },
            host: tls.hostname,
          },
        ];
      });

      const cert = readFileSync(tls.certFile).toString("base64");
      const key = readFileSync(tls.keyFile).toString("base64");
      c.Secrets.push([
        "sourcegraph-tls.Secret.yaml",
        {
          apiVersion: "v1",
          kind: "Secret",
          metadata: { name: "sourcegraph-tls" },
          type: "kubernetes.io/tls",
          data: {
            "tls.crt": cert,
            "tls.key": key,
          },
        },
      ]);

      c.ManualInstructions.push(
        `Update your [site configuration](https://docs.sourcegraph.com/admin/config/site_config) to set \`externalURL\` to ${tls.hostname}`
      );
    }

    c.RawFiles.push([
      "ingress-nginx.yaml",
      docs.map((doc) => doc.toString()).join("\n"),
    ]);
  };

const serviceNginx =
  (tlsCertFile: string, tlsKeyFile: string): Transform =>
  async (c: Cluster) => {
    const s = readFileSync(
      path.join("custom", "nginx-svc", "nginx.ConfigMap.yaml")
    ).toString();
    const y = YAML.parse(s) as k8s.V1ConfigMap;
    const tlsCert = readFileSync(tlsCertFile).toString();
    const tlsKey = readFileSync(tlsKeyFile).toString();
    y.data!["tls.crt"] = tlsCert;
    y.data!["tls.key"] = tlsKey;
    c.ConfigMaps.push(["nginx.ConfigMap.yaml", y]);
    c.Deployments.push([
      "nginx.Deployment.yaml",
      YAML.parse(
        readFileSync(
          path.join("custom", "nginx-svc", "nginx.Deployment.yaml")
        ).toString()
      ),
    ]);
    c.Services.push([
      "nginx.Service.yaml",
      YAML.parse(
        readFileSync(
          path.join("custom", "nginx-svc", "nginx.Service.yaml")
        ).toString()
      ),
    ]);
  };

const nodePort = (): Transform => async (c: Cluster) => {
  c.Services.forEach(([filename, service]) => {
    if (filename.endsWith("sourcegraph-frontend.Service.yaml")) {
      service.spec!.type = "NodePort";
      service.spec!.ports?.forEach((port) => {
        if (port.name === "http") {
          port.nodePort = port.port;
        }
      });
    }
  });
  c.ManualInstructions
    .push(`You've configured sourcegraph-frontend to be a NodePort service. This requires exposing a port on your cluster machines to the Internet.

If you are updating an existing service, you may need to delete the old service first:

  kubectl delete svc sourcegraph-frontend
  kubectl apply --prune -l deploy=sourcegraph -f .

Google Cloud Platform
=====================

  # Expose the necessary ports.
  gcloud compute --project=$PROJECT firewall-rules create sourcegraph-frontend-http --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:30080

  # Find a node name
  kubectl get pods -l app=sourcegraph-frontend -o=custom-columns=NODE:.spec.nodeName

  # Get the EXTERNAL-IP address (will be ephemeral unless you
  # [make it static](https://cloud.google.com/compute/docs/ip-addresses/reserve-static-external-ip-address#promote_ephemeral_ip)
  kubectl get node $NODE -o wide

AWS
===

Update the [AWS Security Group rules](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html) for the nodes in your cluster to expose the NodePort port.

Afterward, Sourcegraph should be accessible at $EXTERNAL_ADDR:30080, where $EXTERNAL_ADDR is the address of any node in the cluster.

Other cloud providers
=====================

Follow your cloud provider documentation to expose the NodePort port on the cluster VMs to the Internet.
`);
};

export const sshCloning =
  (
    sshKeyFile: string,
    knownHostsFile: string,
    root: boolean = true
  ): Transform =>
  async (c: Cluster) => {
    const sshKey = readFileSync(sshKeyFile).toString("base64");
    const knownHosts = readFileSync(knownHostsFile).toString("base64");
    const sshDir = root ? "/root" : "/home/sourcegraph";
    c.Secrets.push([
      "gitserver-ssh.Secret.yaml",
      {
        apiVersion: "v1",
        kind: "Secret",
        metadata: { name: "gitserver-ssh" },
        type: "Opaque",
        data: {
          id_rsa: sshKey,
          known_hosts: knownHosts,
        },
      },
    ]);
    c.StatefulSets.filter(([filename]) =>
      filename.endsWith("gitserver.StatefulSet.yaml")
    ).forEach(([filename, data]) => {
      data.spec!.template.spec!.containers.forEach((container) => {
        if (container.name === "gitserver") {
          if (!container.volumeMounts) {
            container.volumeMounts = [];
          }
          container.volumeMounts.push({
            mountPath: `${sshDir}/.ssh`,
            name: "ssh",
          });
        }
      });
      if (!data.spec!.template.spec!.volumes) {
        data.spec!.template.spec!.volumes = [];
      }
      !data.spec!.template.spec!.volumes!.push({
        name: "ssh",
        secret: { defaultMode: 0o644, secretName: "gitserver-ssh" },
      });
    });
  };

// TODO: change non-root to be the default, and runAsRoot to be an option
export const nonRoot = (): Transform => async (c: Cluster) => {
  const runAsUserAndGroup: {
    [name: string]: {
      runAsUser?: number;
      runAsGroup?: number;
      containers?: {
        [containerName: string]: {
          runAsUser?: number;
          runAsGroup?: number;
        };
      };
    };
  } = {
    "codeinsights-db": {
      runAsUser: 70,
      containers: {
        timescaledb: {
          runAsGroup: 70,
          runAsUser: 70,
        },
      },
    },
    "codeintel-db": {
      runAsGroup: 999,
      runAsUser: 999,
    },
    grafana: {
      containers: {
        grafana: {
          runAsUser: 472,
          runAsGroup: 472,
        },
      },
    },
    pgsql: {
      runAsGroup: 999,
      runAsUser: 999,
    },
    "redis-cache": {
      runAsUser: 999,
      runAsGroup: 1000,
    },
    "redis-store": {
      runAsUser: 999,
      runAsGroup: 1000,
    },
  };
  const update = (deployOrSS: k8s.V1Deployment | k8s.V1StatefulSet) => {
    if (!deployOrSS.metadata?.name) {
      return;
    }
    if (runAsUserAndGroup[deployOrSS.metadata.name]) {
      _.merge(deployOrSS, {
        spec: {
          template: {
            spec: {
              securityContext: _.omitBy(
                {
                  runAsUser:
                    runAsUserAndGroup[deployOrSS.metadata.name].runAsUser,
                  runAsGroup:
                    runAsUserAndGroup[deployOrSS.metadata.name].runAsGroup,
                },
                _.isUndefined
              ),
            },
          },
        },
      });
    }
    deployOrSS.spec?.template.spec?.containers.forEach((container) => {
      const containerSecurityContext = {
        allowPrivilegeEscalation: false,
        runAsUser: 100,
        runAsGroup: 101,
      };
      if (deployOrSS.metadata?.name) {
        const containers =
          runAsUserAndGroup[deployOrSS.metadata.name]?.containers;
        _.merge(
          containerSecurityContext,
          _.omit(runAsUserAndGroup[deployOrSS.metadata.name], "containers"),
          containers && containers[container.name]
        );
      }
      container.securityContext = containerSecurityContext;
    });
  };
  c.Deployments.forEach(([, deployOrSS]) => update(deployOrSS));
  c.StatefulSets.forEach(([, deployOrSS]) => update(deployOrSS));
  return Promise.resolve();
};

export const nonPrivileged = (): Transform => async (c: Cluster) => {
  await nonRoot()(c); // implies non-root for now
  return Promise.resolve();
};


interface NameAndKindOptions {
  omit: [string, string][]
}

export const setNamespace = (name: string, kind: string, namespace: string, options?: NameAndKindOptions) => setMetadata(name, kind, {namespace}, options)

export const setMetadata = (name: string, kind: string, toMerge: DeepPartial<V1ObjectMeta>, options?: NameAndKindOptions ): Transform => async (c: Cluster) => {
  flatten<[string, { metadata?: V1ObjectMeta, kind?: string }]>([
    c.Deployments,
    c.PersistentVolumeClaims,
    c.PersistentVolumes,
    c.Services,
    c.ClusterRoles,
    c.ClusterRoleBindings,
    c.ConfigMaps,
    c.DaemonSets,
    c.Ingresss,
    c.PodSecurityPolicys,
    c.Roles,
    c.RoleBindings,
    c.ServiceAccounts,
    c.Secrets,
    c.StatefulSets,
    c.StorageClasses
  ]).map(([, obj]) => obj)
    .filter(obj => (name === '*' || obj.metadata?.name === name) && (kind === '*' || obj.kind === kind))
    .filter(obj => !(options?.omit && _.some(options.omit.map(([omitName, omitKind]) => obj.metadata?.name === omitName && obj.kind === omitKind))))
    .forEach(obj=> {
    _.merge(obj.metadata, toMerge)

    // If we're updating a namespace, also update namespace references
    if (toMerge.namespace) {
      _.concat(
        c.ClusterRoleBindings,
        c.RoleBindings,
      ).forEach(([,roleBinding]) => {
      roleBinding.subjects?.
        filter(subject => (name === '*' || subject.name === name) && (kind === '*' || subject.kind === kind)).
        forEach(subject => _.merge(subject, {namespace: toMerge.namespace}))
      })
    }
  })
}

type DeepPartial<T> = T extends object ? {
  [P in keyof T]?: DeepPartial<T[P]>;
} : T;


function mergeArrayCustomizer<T>(objValue: T, srcValue: T): any | undefined {
  if (!_.isArray(objValue) || !_.isArray(srcValue)) {
    return
  }
  const elemKey = (elem: any) => elem.name || elem.metadata?.name
  if (!_.every(objValue.map(elemKey)) || !_.every(srcValue.map(elemKey))) {
    return
  }
  const mergedElemsObj = _.mergeWith(
    _.fromPairs(objValue.map(elem => [elemKey(elem), elem])),
    _.fromPairs(srcValue.map(elem => [elemKey(elem), elem])),
    mergeArrayCustomizer,
  )
  return _.toPairs(mergedElemsObj).map(([,elem]) => elem)
}

export const overlay = (
  name: string,
  kind: {
    ingress?: DeepPartial<V1Ingress>,
    deployment?: DeepPartial<V1Deployment>,
    configMap?: DeepPartial<V1ConfigMap>,
    statefulSet?: DeepPartial<V1StatefulSet>,
    persistentVolumeClaim?: DeepPartial<V1PersistentVolumeClaim>,
    service?: DeepPartial<V1Service>,
  },
  unsetPaths?: {
    ingress?: string[],
    deployment?: string[],
    configMap?: string[],
    statefulSet?: string[],
    persistentVolumeClaim?: string[],
    service?: string[],
  },
): Transform => async (c: Cluster) => {    
  const mergeObjs = <T extends { metadata?: { name?: string }}>(namedObjs: [string, T][], toMerge?: DeepPartial<T>, toUnset?: string[]) => {
    if (!toMerge && !unsetPaths) {
      return
    }
    for (const [, obj] of namedObjs) {
      if (obj.metadata?.name !== name) {
        continue
      }
      _.mergeWith(obj, toMerge, mergeArrayCustomizer)
      if (toUnset) {
        for (const unsetPath of toUnset) {
          _.unset(obj, unsetPath)
        }
      }
    }
  }
  mergeObjs(c.Ingresss, kind.ingress, unsetPaths?.ingress)
  mergeObjs(c.Deployments, kind.deployment, unsetPaths?.deployment)
  mergeObjs(c.ConfigMaps, kind.configMap, unsetPaths?.configMap)
  mergeObjs(c.StatefulSets, kind.statefulSet, unsetPaths?.statefulSet)
  mergeObjs(c.PersistentVolumeClaims, kind.persistentVolumeClaim, unsetPaths?.persistentVolumeClaim)
  mergeObjs(c.Services, kind.service, unsetPaths?.service)
}

export const normalize = (): Transform => async (c: Cluster) => {
  _.concat(
    c.Deployments || [],
    c.StatefulSets || [],
    ).forEach(([, deploymentOrStatefulSet]) => {
      _.concat(
        deploymentOrStatefulSet.spec?.template.spec?.containers || [],
        deploymentOrStatefulSet.spec?.template.spec?.initContainers || [],
        ).forEach(c => {
          if (c.env === null) {
            delete c.env
          }
        })
      })
}
  
export function defaultFilenameMapper(sourceDir: string, filename: string): string {
  return path.relative(sourceDir, filename)
}
