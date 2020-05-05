{ apiVersion = "apps/v1"
, kind = "Deployment"
, metadata =
  { annotations = Some
    [ { mapKey = "description"
      , mapValue = "Postgres database for various data."
      }
    ]
  , clusterName = None Text
  , creationTimestamp = None Text
  , deletionGracePeriodSeconds = None Natural
  , deletionTimestamp = None Text
  , finalizers = None (List Text)
  , generateName = None Text
  , generation = None Natural
  , labels = Some [ { mapKey = "deploy", mapValue = "sourcegraph" } ]
  , managedFields =
      None
        ( List
            { apiVersion : Text
            , fieldsType : Optional Text
            , fieldsV1 : Optional (List { mapKey : Text, mapValue : Text })
            , manager : Optional Text
            , operation : Optional Text
            , time : Optional Text
            }
        )
  , name = Some "pgsql"
  , namespace = None Text
  , ownerReferences =
      None
        ( List
            { apiVersion : Text
            , blockOwnerDeletion : Optional Bool
            , controller : Optional Bool
            , kind : Text
            , name : Text
            , uid : Text
            }
        )
  , resourceVersion = None Text
  , selfLink = None Text
  , uid = None Text
  }
, spec = Some
  { minReadySeconds = Some 10
  , paused = None Bool
  , progressDeadlineSeconds = None Natural
  , replicas = Some 1
  , revisionHistoryLimit = Some 10
  , selector =
    { matchExpressions =
        None
          (List { key : Text, operator : Text, values : Optional (List Text) })
    , matchLabels = Some [ { mapKey = "app", mapValue = "pgsql" } ]
    }
  , strategy = Some
    { rollingUpdate = Some
      { maxSurge = Some (< Int : Natural | String : Text >.Int 1)
      , maxUnavailable = Some (< Int : Natural | String : Text >.Int 1)
      }
    , type = Some "RollingUpdate"
    }
  , template =
    { metadata =
      { annotations = None (List { mapKey : Text, mapValue : Text })
      , clusterName = None Text
      , creationTimestamp = None Text
      , deletionGracePeriodSeconds = None Natural
      , deletionTimestamp = None Text
      , finalizers = None (List Text)
      , generateName = None Text
      , generation = None Natural
      , labels = Some
        [ { mapKey = "group", mapValue = "backend" }
        , { mapKey = "app", mapValue = "pgsql" }
        ]
      , managedFields =
          None
            ( List
                { apiVersion : Text
                , fieldsType : Optional Text
                , fieldsV1 : Optional (List { mapKey : Text, mapValue : Text })
                , manager : Optional Text
                , operation : Optional Text
                , time : Optional Text
                }
            )
      , name = None Text
      , namespace = None Text
      , ownerReferences =
          None
            ( List
                { apiVersion : Text
                , blockOwnerDeletion : Optional Bool
                , controller : Optional Bool
                , kind : Text
                , name : Text
                , uid : Text
                }
            )
      , resourceVersion = None Text
      , selfLink = None Text
      , uid = None Text
      }
    , spec = Some
      { activeDeadlineSeconds = None Natural
      , affinity =
          None
            { nodeAffinity :
                Optional
                  { preferredDuringSchedulingIgnoredDuringExecution :
                      Optional
                        ( List
                            { preference :
                                { matchExpressions :
                                    Optional
                                      ( List
                                          { key : Text
                                          , operator : Text
                                          , values : Optional (List Text)
                                          }
                                      )
                                , matchFields :
                                    Optional
                                      ( List
                                          { key : Text
                                          , operator : Text
                                          , values : Optional (List Text)
                                          }
                                      )
                                }
                            , weight : Natural
                            }
                        )
                  , requiredDuringSchedulingIgnoredDuringExecution :
                      Optional
                        { nodeSelectorTerms :
                            List
                              { matchExpressions :
                                  Optional
                                    ( List
                                        { key : Text
                                        , operator : Text
                                        , values : Optional (List Text)
                                        }
                                    )
                              , matchFields :
                                  Optional
                                    ( List
                                        { key : Text
                                        , operator : Text
                                        , values : Optional (List Text)
                                        }
                                    )
                              }
                        }
                  }
            , podAffinity :
                Optional
                  { preferredDuringSchedulingIgnoredDuringExecution :
                      Optional
                        ( List
                            { podAffinityTerm :
                                { labelSelector :
                                    Optional
                                      { matchExpressions :
                                          Optional
                                            ( List
                                                { key : Text
                                                , operator : Text
                                                , values : Optional (List Text)
                                                }
                                            )
                                      , matchLabels :
                                          Optional
                                            ( List
                                                { mapKey : Text
                                                , mapValue : Text
                                                }
                                            )
                                      }
                                , namespaces : Optional (List Text)
                                , topologyKey : Text
                                }
                            , weight : Natural
                            }
                        )
                  , requiredDuringSchedulingIgnoredDuringExecution :
                      Optional
                        ( List
                            { labelSelector :
                                Optional
                                  { matchExpressions :
                                      Optional
                                        ( List
                                            { key : Text
                                            , operator : Text
                                            , values : Optional (List Text)
                                            }
                                        )
                                  , matchLabels :
                                      Optional
                                        ( List
                                            { mapKey : Text, mapValue : Text }
                                        )
                                  }
                            , namespaces : Optional (List Text)
                            , topologyKey : Text
                            }
                        )
                  }
            , podAntiAffinity :
                Optional
                  { preferredDuringSchedulingIgnoredDuringExecution :
                      Optional
                        ( List
                            { podAffinityTerm :
                                { labelSelector :
                                    Optional
                                      { matchExpressions :
                                          Optional
                                            ( List
                                                { key : Text
                                                , operator : Text
                                                , values : Optional (List Text)
                                                }
                                            )
                                      , matchLabels :
                                          Optional
                                            ( List
                                                { mapKey : Text
                                                , mapValue : Text
                                                }
                                            )
                                      }
                                , namespaces : Optional (List Text)
                                , topologyKey : Text
                                }
                            , weight : Natural
                            }
                        )
                  , requiredDuringSchedulingIgnoredDuringExecution :
                      Optional
                        ( List
                            { labelSelector :
                                Optional
                                  { matchExpressions :
                                      Optional
                                        ( List
                                            { key : Text
                                            , operator : Text
                                            , values : Optional (List Text)
                                            }
                                        )
                                  , matchLabels :
                                      Optional
                                        ( List
                                            { mapKey : Text, mapValue : Text }
                                        )
                                  }
                            , namespaces : Optional (List Text)
                            , topologyKey : Text
                            }
                        )
                  }
            }
      , automountServiceAccountToken = None Bool
      , containers =
        [ { args = None (List Text)
          , command = None (List Text)
          , env =
              None
                ( List
                    { name : Text
                    , value : Optional Text
                    , valueFrom :
                        Optional
                          { configMapKeyRef :
                              Optional
                                { key : Text
                                , name : Optional Text
                                , optional : Optional Bool
                                }
                          , fieldRef :
                              Optional
                                { apiVersion : Optional Text, fieldPath : Text }
                          , resourceFieldRef :
                              Optional
                                { containerName : Optional Text
                                , divisor : Optional Text
                                , resource : Text
                                }
                          , secretKeyRef :
                              Optional
                                { key : Text
                                , name : Optional Text
                                , optional : Optional Bool
                                }
                          }
                    }
                )
          , envFrom =
              None
                ( List
                    { configMapRef :
                        Optional
                          { name : Optional Text, optional : Optional Bool }
                    , prefix : Optional Text
                    , secretRef :
                        Optional
                          { name : Optional Text, optional : Optional Bool }
                    }
                )
          , image = Some
              "index.docker.io/sourcegraph/postgres-11.4:3.15.1@sha256:63090799b34b3115a387d96fe2227a37999d432b774a1d9b7966b8c5d81b56ad"
          , imagePullPolicy = None Text
          , lifecycle =
              None
                { postStart :
                    Optional
                      { exec : Optional { command : Optional (List Text) }
                      , httpGet :
                          Optional
                            { host : Optional Text
                            , httpHeaders :
                                Optional (List { name : Text, value : Text })
                            , path : Optional Text
                            , port : < Int : Natural | String : Text >
                            , scheme : Optional Text
                            }
                      , tcpSocket :
                          Optional
                            { host : Optional Text
                            , port : < Int : Natural | String : Text >
                            }
                      }
                , preStop :
                    Optional
                      { exec : Optional { command : Optional (List Text) }
                      , httpGet :
                          Optional
                            { host : Optional Text
                            , httpHeaders :
                                Optional (List { name : Text, value : Text })
                            , path : Optional Text
                            , port : < Int : Natural | String : Text >
                            , scheme : Optional Text
                            }
                      , tcpSocket :
                          Optional
                            { host : Optional Text
                            , port : < Int : Natural | String : Text >
                            }
                      }
                }
          , livenessProbe = Some
            { exec = Some { command = Some [ "/liveness.sh" ] }
            , failureThreshold = None Natural
            , httpGet =
                None
                  { host : Optional Text
                  , httpHeaders : Optional (List { name : Text, value : Text })
                  , path : Optional Text
                  , port : < Int : Natural | String : Text >
                  , scheme : Optional Text
                  }
            , initialDelaySeconds = Some 15
            , periodSeconds = None Natural
            , successThreshold = None Natural
            , tcpSocket =
                None
                  { host : Optional Text
                  , port : < Int : Natural | String : Text >
                  }
            , timeoutSeconds = None Natural
            }
          , name = "pgsql"
          , ports = Some
            [ { containerPort = 5432
              , hostIP = None Text
              , hostPort = None Natural
              , name = Some "pgsql"
              , protocol = None Text
              }
            ]
          , readinessProbe = Some
            { exec = Some { command = Some [ "/ready.sh" ] }
            , failureThreshold = None Natural
            , httpGet =
                None
                  { host : Optional Text
                  , httpHeaders : Optional (List { name : Text, value : Text })
                  , path : Optional Text
                  , port : < Int : Natural | String : Text >
                  , scheme : Optional Text
                  }
            , initialDelaySeconds = None Natural
            , periodSeconds = None Natural
            , successThreshold = None Natural
            , tcpSocket =
                None
                  { host : Optional Text
                  , port : < Int : Natural | String : Text >
                  }
            , timeoutSeconds = None Natural
            }
          , resources = Some
            { limits = Some
              [ { mapKey = "memory", mapValue = "2Gi" }
              , { mapKey = "cpu", mapValue = "4" }
              ]
            , requests = Some
              [ { mapKey = "memory", mapValue = "2Gi" }
              , { mapKey = "cpu", mapValue = "4" }
              ]
            }
          , securityContext =
              None
                { allowPrivilegeEscalation : Optional Bool
                , capabilities :
                    Optional
                      { add : Optional (List Text)
                      , drop : Optional (List Text)
                      }
                , privileged : Optional Bool
                , procMount : Optional Text
                , readOnlyRootFilesystem : Optional Bool
                , runAsGroup : Optional Natural
                , runAsNonRoot : Optional Bool
                , runAsUser : Optional Natural
                , seLinuxOptions :
                    Optional
                      { level : Optional Text
                      , role : Optional Text
                      , type : Optional Text
                      , user : Optional Text
                      }
                , windowsOptions :
                    Optional
                      { gmsaCredentialSpec : Optional Text
                      , gmsaCredentialSpecName : Optional Text
                      , runAsUserName : Optional Text
                      }
                }
          , startupProbe =
              None
                { exec : Optional { command : Optional (List Text) }
                , failureThreshold : Optional Natural
                , httpGet :
                    Optional
                      { host : Optional Text
                      , httpHeaders :
                          Optional (List { name : Text, value : Text })
                      , path : Optional Text
                      , port : < Int : Natural | String : Text >
                      , scheme : Optional Text
                      }
                , initialDelaySeconds : Optional Natural
                , periodSeconds : Optional Natural
                , successThreshold : Optional Natural
                , tcpSocket :
                    Optional
                      { host : Optional Text
                      , port : < Int : Natural | String : Text >
                      }
                , timeoutSeconds : Optional Natural
                }
          , stdin = None Bool
          , stdinOnce = None Bool
          , terminationMessagePath = None Text
          , terminationMessagePolicy = Some "FallbackToLogsOnError"
          , tty = None Bool
          , volumeDevices = None (List { devicePath : Text, name : Text })
          , volumeMounts = Some
            [ { mountPath = "/data"
              , mountPropagation = None Text
              , name = "disk"
              , readOnly = None Bool
              , subPath = None Text
              , subPathExpr = None Text
              }
            , { mountPath = "/conf"
              , mountPropagation = None Text
              , name = "pgsql-conf"
              , readOnly = None Bool
              , subPath = None Text
              , subPathExpr = None Text
              }
            ]
          , workingDir = None Text
          }
        , { args = None (List Text)
          , command = None (List Text)
          , env = Some
            [ { name = "DATA_SOURCE_NAME"
              , value = Some "postgres://sg:@localhost:5432/?sslmode=disable"
              , valueFrom =
                  None
                    { configMapKeyRef :
                        Optional
                          { key : Text
                          , name : Optional Text
                          , optional : Optional Bool
                          }
                    , fieldRef :
                        Optional
                          { apiVersion : Optional Text, fieldPath : Text }
                    , resourceFieldRef :
                        Optional
                          { containerName : Optional Text
                          , divisor : Optional Text
                          , resource : Text
                          }
                    , secretKeyRef :
                        Optional
                          { key : Text
                          , name : Optional Text
                          , optional : Optional Bool
                          }
                    }
              }
            ]
          , envFrom =
              None
                ( List
                    { configMapRef :
                        Optional
                          { name : Optional Text, optional : Optional Bool }
                    , prefix : Optional Text
                    , secretRef :
                        Optional
                          { name : Optional Text, optional : Optional Bool }
                    }
                )
          , image = Some
              "wrouesnel/postgres_exporter:v0.7.0@sha256:785c919627c06f540d515aac88b7966f352403f73e931e70dc2cbf783146a98b"
          , imagePullPolicy = None Text
          , lifecycle =
              None
                { postStart :
                    Optional
                      { exec : Optional { command : Optional (List Text) }
                      , httpGet :
                          Optional
                            { host : Optional Text
                            , httpHeaders :
                                Optional (List { name : Text, value : Text })
                            , path : Optional Text
                            , port : < Int : Natural | String : Text >
                            , scheme : Optional Text
                            }
                      , tcpSocket :
                          Optional
                            { host : Optional Text
                            , port : < Int : Natural | String : Text >
                            }
                      }
                , preStop :
                    Optional
                      { exec : Optional { command : Optional (List Text) }
                      , httpGet :
                          Optional
                            { host : Optional Text
                            , httpHeaders :
                                Optional (List { name : Text, value : Text })
                            , path : Optional Text
                            , port : < Int : Natural | String : Text >
                            , scheme : Optional Text
                            }
                      , tcpSocket :
                          Optional
                            { host : Optional Text
                            , port : < Int : Natural | String : Text >
                            }
                      }
                }
          , livenessProbe =
              None
                { exec : Optional { command : Optional (List Text) }
                , failureThreshold : Optional Natural
                , httpGet :
                    Optional
                      { host : Optional Text
                      , httpHeaders :
                          Optional (List { name : Text, value : Text })
                      , path : Optional Text
                      , port : < Int : Natural | String : Text >
                      , scheme : Optional Text
                      }
                , initialDelaySeconds : Optional Natural
                , periodSeconds : Optional Natural
                , successThreshold : Optional Natural
                , tcpSocket :
                    Optional
                      { host : Optional Text
                      , port : < Int : Natural | String : Text >
                      }
                , timeoutSeconds : Optional Natural
                }
          , name = "pgsql-exporter"
          , ports =
              None
                ( List
                    { containerPort : Natural
                    , hostIP : Optional Text
                    , hostPort : Optional Natural
                    , name : Optional Text
                    , protocol : Optional Text
                    }
                )
          , readinessProbe =
              None
                { exec : Optional { command : Optional (List Text) }
                , failureThreshold : Optional Natural
                , httpGet :
                    Optional
                      { host : Optional Text
                      , httpHeaders :
                          Optional (List { name : Text, value : Text })
                      , path : Optional Text
                      , port : < Int : Natural | String : Text >
                      , scheme : Optional Text
                      }
                , initialDelaySeconds : Optional Natural
                , periodSeconds : Optional Natural
                , successThreshold : Optional Natural
                , tcpSocket :
                    Optional
                      { host : Optional Text
                      , port : < Int : Natural | String : Text >
                      }
                , timeoutSeconds : Optional Natural
                }
          , resources = Some
            { limits = Some
              [ { mapKey = "memory", mapValue = "50Mi" }
              , { mapKey = "cpu", mapValue = "10m" }
              ]
            , requests = Some
              [ { mapKey = "memory", mapValue = "50Mi" }
              , { mapKey = "cpu", mapValue = "10m" }
              ]
            }
          , securityContext =
              None
                { allowPrivilegeEscalation : Optional Bool
                , capabilities :
                    Optional
                      { add : Optional (List Text)
                      , drop : Optional (List Text)
                      }
                , privileged : Optional Bool
                , procMount : Optional Text
                , readOnlyRootFilesystem : Optional Bool
                , runAsGroup : Optional Natural
                , runAsNonRoot : Optional Bool
                , runAsUser : Optional Natural
                , seLinuxOptions :
                    Optional
                      { level : Optional Text
                      , role : Optional Text
                      , type : Optional Text
                      , user : Optional Text
                      }
                , windowsOptions :
                    Optional
                      { gmsaCredentialSpec : Optional Text
                      , gmsaCredentialSpecName : Optional Text
                      , runAsUserName : Optional Text
                      }
                }
          , startupProbe =
              None
                { exec : Optional { command : Optional (List Text) }
                , failureThreshold : Optional Natural
                , httpGet :
                    Optional
                      { host : Optional Text
                      , httpHeaders :
                          Optional (List { name : Text, value : Text })
                      , path : Optional Text
                      , port : < Int : Natural | String : Text >
                      , scheme : Optional Text
                      }
                , initialDelaySeconds : Optional Natural
                , periodSeconds : Optional Natural
                , successThreshold : Optional Natural
                , tcpSocket :
                    Optional
                      { host : Optional Text
                      , port : < Int : Natural | String : Text >
                      }
                , timeoutSeconds : Optional Natural
                }
          , stdin = None Bool
          , stdinOnce = None Bool
          , terminationMessagePath = None Text
          , terminationMessagePolicy = Some "FallbackToLogsOnError"
          , tty = None Bool
          , volumeDevices = None (List { devicePath : Text, name : Text })
          , volumeMounts =
              None
                ( List
                    { mountPath : Text
                    , mountPropagation : Optional Text
                    , name : Text
                    , readOnly : Optional Bool
                    , subPath : Optional Text
                    , subPathExpr : Optional Text
                    }
                )
          , workingDir = None Text
          }
        ]
      , dnsConfig =
          None
            { nameservers : Optional (List Text)
            , options :
                Optional (List { name : Optional Text, value : Optional Text })
            , searches : Optional (List Text)
            }
      , dnsPolicy = None Text
      , enableServiceLinks = None Bool
      , ephemeralContainers =
          None
            ( List
                { args : Optional (List Text)
                , command : Optional (List Text)
                , env :
                    Optional
                      ( List
                          { name : Text
                          , value : Optional Text
                          , valueFrom :
                              Optional
                                { configMapKeyRef :
                                    Optional
                                      { key : Text
                                      , name : Optional Text
                                      , optional : Optional Bool
                                      }
                                , fieldRef :
                                    Optional
                                      { apiVersion : Optional Text
                                      , fieldPath : Text
                                      }
                                , resourceFieldRef :
                                    Optional
                                      { containerName : Optional Text
                                      , divisor : Optional Text
                                      , resource : Text
                                      }
                                , secretKeyRef :
                                    Optional
                                      { key : Text
                                      , name : Optional Text
                                      , optional : Optional Bool
                                      }
                                }
                          }
                      )
                , envFrom :
                    Optional
                      ( List
                          { configMapRef :
                              Optional
                                { name : Optional Text
                                , optional : Optional Bool
                                }
                          , prefix : Optional Text
                          , secretRef :
                              Optional
                                { name : Optional Text
                                , optional : Optional Bool
                                }
                          }
                      )
                , image : Optional Text
                , imagePullPolicy : Optional Text
                , lifecycle :
                    Optional
                      { postStart :
                          Optional
                            { exec : Optional { command : Optional (List Text) }
                            , httpGet :
                                Optional
                                  { host : Optional Text
                                  , httpHeaders :
                                      Optional
                                        (List { name : Text, value : Text })
                                  , path : Optional Text
                                  , port : < Int : Natural | String : Text >
                                  , scheme : Optional Text
                                  }
                            , tcpSocket :
                                Optional
                                  { host : Optional Text
                                  , port : < Int : Natural | String : Text >
                                  }
                            }
                      , preStop :
                          Optional
                            { exec : Optional { command : Optional (List Text) }
                            , httpGet :
                                Optional
                                  { host : Optional Text
                                  , httpHeaders :
                                      Optional
                                        (List { name : Text, value : Text })
                                  , path : Optional Text
                                  , port : < Int : Natural | String : Text >
                                  , scheme : Optional Text
                                  }
                            , tcpSocket :
                                Optional
                                  { host : Optional Text
                                  , port : < Int : Natural | String : Text >
                                  }
                            }
                      }
                , livenessProbe :
                    Optional
                      { exec : Optional { command : Optional (List Text) }
                      , failureThreshold : Optional Natural
                      , httpGet :
                          Optional
                            { host : Optional Text
                            , httpHeaders :
                                Optional (List { name : Text, value : Text })
                            , path : Optional Text
                            , port : < Int : Natural | String : Text >
                            , scheme : Optional Text
                            }
                      , initialDelaySeconds : Optional Natural
                      , periodSeconds : Optional Natural
                      , successThreshold : Optional Natural
                      , tcpSocket :
                          Optional
                            { host : Optional Text
                            , port : < Int : Natural | String : Text >
                            }
                      , timeoutSeconds : Optional Natural
                      }
                , name : Text
                , ports :
                    Optional
                      ( List
                          { containerPort : Natural
                          , hostIP : Optional Text
                          , hostPort : Optional Natural
                          , name : Optional Text
                          , protocol : Optional Text
                          }
                      )
                , readinessProbe :
                    Optional
                      { exec : Optional { command : Optional (List Text) }
                      , failureThreshold : Optional Natural
                      , httpGet :
                          Optional
                            { host : Optional Text
                            , httpHeaders :
                                Optional (List { name : Text, value : Text })
                            , path : Optional Text
                            , port : < Int : Natural | String : Text >
                            , scheme : Optional Text
                            }
                      , initialDelaySeconds : Optional Natural
                      , periodSeconds : Optional Natural
                      , successThreshold : Optional Natural
                      , tcpSocket :
                          Optional
                            { host : Optional Text
                            , port : < Int : Natural | String : Text >
                            }
                      , timeoutSeconds : Optional Natural
                      }
                , resources :
                    Optional
                      { limits :
                          Optional (List { mapKey : Text, mapValue : Text })
                      , requests :
                          Optional (List { mapKey : Text, mapValue : Text })
                      }
                , securityContext :
                    Optional
                      { allowPrivilegeEscalation : Optional Bool
                      , capabilities :
                          Optional
                            { add : Optional (List Text)
                            , drop : Optional (List Text)
                            }
                      , privileged : Optional Bool
                      , procMount : Optional Text
                      , readOnlyRootFilesystem : Optional Bool
                      , runAsGroup : Optional Natural
                      , runAsNonRoot : Optional Bool
                      , runAsUser : Optional Natural
                      , seLinuxOptions :
                          Optional
                            { level : Optional Text
                            , role : Optional Text
                            , type : Optional Text
                            , user : Optional Text
                            }
                      , windowsOptions :
                          Optional
                            { gmsaCredentialSpec : Optional Text
                            , gmsaCredentialSpecName : Optional Text
                            , runAsUserName : Optional Text
                            }
                      }
                , startupProbe :
                    Optional
                      { exec : Optional { command : Optional (List Text) }
                      , failureThreshold : Optional Natural
                      , httpGet :
                          Optional
                            { host : Optional Text
                            , httpHeaders :
                                Optional (List { name : Text, value : Text })
                            , path : Optional Text
                            , port : < Int : Natural | String : Text >
                            , scheme : Optional Text
                            }
                      , initialDelaySeconds : Optional Natural
                      , periodSeconds : Optional Natural
                      , successThreshold : Optional Natural
                      , tcpSocket :
                          Optional
                            { host : Optional Text
                            , port : < Int : Natural | String : Text >
                            }
                      , timeoutSeconds : Optional Natural
                      }
                , stdin : Optional Bool
                , stdinOnce : Optional Bool
                , targetContainerName : Optional Text
                , terminationMessagePath : Optional Text
                , terminationMessagePolicy : Optional Text
                , tty : Optional Bool
                , volumeDevices :
                    Optional (List { devicePath : Text, name : Text })
                , volumeMounts :
                    Optional
                      ( List
                          { mountPath : Text
                          , mountPropagation : Optional Text
                          , name : Text
                          , readOnly : Optional Bool
                          , subPath : Optional Text
                          , subPathExpr : Optional Text
                          }
                      )
                , workingDir : Optional Text
                }
            )
      , hostAliases =
          None (List { hostnames : Optional (List Text), ip : Optional Text })
      , hostIPC = None Bool
      , hostNetwork = None Bool
      , hostPID = None Bool
      , hostname = None Text
      , imagePullSecrets = None (List { name : Optional Text })
      , initContainers = Some
        [ { args = None (List Text)
          , command = Some
            [ "sh"
            , "-c"
            , "if [ -d /data/pgdata-11 ]; then chmod 750 /data/pgdata-11; fi"
            ]
          , env =
              None
                ( List
                    { name : Text
                    , value : Optional Text
                    , valueFrom :
                        Optional
                          { configMapKeyRef :
                              Optional
                                { key : Text
                                , name : Optional Text
                                , optional : Optional Bool
                                }
                          , fieldRef :
                              Optional
                                { apiVersion : Optional Text, fieldPath : Text }
                          , resourceFieldRef :
                              Optional
                                { containerName : Optional Text
                                , divisor : Optional Text
                                , resource : Text
                                }
                          , secretKeyRef :
                              Optional
                                { key : Text
                                , name : Optional Text
                                , optional : Optional Bool
                                }
                          }
                    }
                )
          , envFrom =
              None
                ( List
                    { configMapRef :
                        Optional
                          { name : Optional Text, optional : Optional Bool }
                    , prefix : Optional Text
                    , secretRef :
                        Optional
                          { name : Optional Text, optional : Optional Bool }
                    }
                )
          , image = Some
              "sourcegraph/alpine:3.10@sha256:4d05cd5669726fc38823e92320659a6d1ef7879e62268adec5df658a0bacf65c"
          , imagePullPolicy = None Text
          , lifecycle =
              None
                { postStart :
                    Optional
                      { exec : Optional { command : Optional (List Text) }
                      , httpGet :
                          Optional
                            { host : Optional Text
                            , httpHeaders :
                                Optional (List { name : Text, value : Text })
                            , path : Optional Text
                            , port : < Int : Natural | String : Text >
                            , scheme : Optional Text
                            }
                      , tcpSocket :
                          Optional
                            { host : Optional Text
                            , port : < Int : Natural | String : Text >
                            }
                      }
                , preStop :
                    Optional
                      { exec : Optional { command : Optional (List Text) }
                      , httpGet :
                          Optional
                            { host : Optional Text
                            , httpHeaders :
                                Optional (List { name : Text, value : Text })
                            , path : Optional Text
                            , port : < Int : Natural | String : Text >
                            , scheme : Optional Text
                            }
                      , tcpSocket :
                          Optional
                            { host : Optional Text
                            , port : < Int : Natural | String : Text >
                            }
                      }
                }
          , livenessProbe =
              None
                { exec : Optional { command : Optional (List Text) }
                , failureThreshold : Optional Natural
                , httpGet :
                    Optional
                      { host : Optional Text
                      , httpHeaders :
                          Optional (List { name : Text, value : Text })
                      , path : Optional Text
                      , port : < Int : Natural | String : Text >
                      , scheme : Optional Text
                      }
                , initialDelaySeconds : Optional Natural
                , periodSeconds : Optional Natural
                , successThreshold : Optional Natural
                , tcpSocket :
                    Optional
                      { host : Optional Text
                      , port : < Int : Natural | String : Text >
                      }
                , timeoutSeconds : Optional Natural
                }
          , name = "correct-data-dir-permissions"
          , ports =
              None
                ( List
                    { containerPort : Natural
                    , hostIP : Optional Text
                    , hostPort : Optional Natural
                    , name : Optional Text
                    , protocol : Optional Text
                    }
                )
          , readinessProbe =
              None
                { exec : Optional { command : Optional (List Text) }
                , failureThreshold : Optional Natural
                , httpGet :
                    Optional
                      { host : Optional Text
                      , httpHeaders :
                          Optional (List { name : Text, value : Text })
                      , path : Optional Text
                      , port : < Int : Natural | String : Text >
                      , scheme : Optional Text
                      }
                , initialDelaySeconds : Optional Natural
                , periodSeconds : Optional Natural
                , successThreshold : Optional Natural
                , tcpSocket :
                    Optional
                      { host : Optional Text
                      , port : < Int : Natural | String : Text >
                      }
                , timeoutSeconds : Optional Natural
                }
          , resources =
              None
                { limits : Optional (List { mapKey : Text, mapValue : Text })
                , requests : Optional (List { mapKey : Text, mapValue : Text })
                }
          , securityContext = Some
            { allowPrivilegeEscalation = None Bool
            , capabilities =
                None { add : Optional (List Text), drop : Optional (List Text) }
            , privileged = None Bool
            , procMount = None Text
            , readOnlyRootFilesystem = None Bool
            , runAsGroup = None Natural
            , runAsNonRoot = None Bool
            , runAsUser = Some 0
            , seLinuxOptions =
                None
                  { level : Optional Text
                  , role : Optional Text
                  , type : Optional Text
                  , user : Optional Text
                  }
            , windowsOptions =
                None
                  { gmsaCredentialSpec : Optional Text
                  , gmsaCredentialSpecName : Optional Text
                  , runAsUserName : Optional Text
                  }
            }
          , startupProbe =
              None
                { exec : Optional { command : Optional (List Text) }
                , failureThreshold : Optional Natural
                , httpGet :
                    Optional
                      { host : Optional Text
                      , httpHeaders :
                          Optional (List { name : Text, value : Text })
                      , path : Optional Text
                      , port : < Int : Natural | String : Text >
                      , scheme : Optional Text
                      }
                , initialDelaySeconds : Optional Natural
                , periodSeconds : Optional Natural
                , successThreshold : Optional Natural
                , tcpSocket :
                    Optional
                      { host : Optional Text
                      , port : < Int : Natural | String : Text >
                      }
                , timeoutSeconds : Optional Natural
                }
          , stdin = None Bool
          , stdinOnce = None Bool
          , terminationMessagePath = None Text
          , terminationMessagePolicy = None Text
          , tty = None Bool
          , volumeDevices = None (List { devicePath : Text, name : Text })
          , volumeMounts = Some
            [ { mountPath = "/data"
              , mountPropagation = None Text
              , name = "disk"
              , readOnly = None Bool
              , subPath = None Text
              , subPathExpr = None Text
              }
            ]
          , workingDir = None Text
          }
        ]
      , nodeName = None Text
      , nodeSelector = None (List { mapKey : Text, mapValue : Text })
      , overhead = None (List { mapKey : Text, mapValue : Text })
      , preemptionPolicy = None Text
      , priority = None Natural
      , priorityClassName = None Text
      , readinessGates = None (List { conditionType : Text })
      , restartPolicy = None Text
      , runtimeClassName = None Text
      , schedulerName = None Text
      , securityContext = Some
        { fsGroup = None Natural
        , runAsGroup = None Natural
        , runAsNonRoot = None Bool
        , runAsUser = Some 0
        , seLinuxOptions =
            None
              { level : Optional Text
              , role : Optional Text
              , type : Optional Text
              , user : Optional Text
              }
        , supplementalGroups = None (List Natural)
        , sysctls = None (List { name : Text, value : Text })
        , windowsOptions =
            None
              { gmsaCredentialSpec : Optional Text
              , gmsaCredentialSpecName : Optional Text
              , runAsUserName : Optional Text
              }
        }
      , serviceAccount = None Text
      , serviceAccountName = None Text
      , shareProcessNamespace = None Bool
      , subdomain = None Text
      , terminationGracePeriodSeconds = None Natural
      , tolerations =
          None
            ( List
                { effect : Optional Text
                , key : Optional Text
                , operator : Optional Text
                , tolerationSeconds : Optional Natural
                , value : Optional Text
                }
            )
      , topologySpreadConstraints =
          None
            ( List
                { labelSelector :
                    Optional
                      { matchExpressions :
                          Optional
                            ( List
                                { key : Text
                                , operator : Text
                                , values : Optional (List Text)
                                }
                            )
                      , matchLabels :
                          Optional (List { mapKey : Text, mapValue : Text })
                      }
                , maxSkew : Natural
                , topologyKey : Text
                , whenUnsatisfiable : Text
                }
            )
      , volumes = Some
        [ { awsElasticBlockStore =
              None
                { fsType : Optional Text
                , partition : Optional Natural
                , readOnly : Optional Bool
                , volumeID : Text
                }
          , azureDisk =
              None
                { cachingMode : Optional Text
                , diskName : Text
                , diskURI : Text
                , fsType : Optional Text
                , kind : Text
                , readOnly : Optional Bool
                }
          , azureFile =
              None
                { readOnly : Optional Bool
                , secretName : Text
                , shareName : Text
                }
          , cephfs =
              None
                { monitors : List Text
                , path : Optional Text
                , readOnly : Optional Bool
                , secretFile : Optional Text
                , secretRef : Optional { name : Optional Text }
                , user : Optional Text
                }
          , cinder =
              None
                { fsType : Optional Text
                , readOnly : Optional Bool
                , secretRef : Optional { name : Optional Text }
                , volumeID : Text
                }
          , configMap =
              None
                { defaultMode : Optional Natural
                , items :
                    Optional
                      ( List
                          { key : Text, mode : Optional Natural, path : Text }
                      )
                , name : Optional Text
                , optional : Optional Bool
                }
          , csi =
              None
                { driver : Text
                , fsType : Optional Text
                , nodePublishSecretRef : Optional { name : Optional Text }
                , readOnly : Optional Bool
                , volumeAttributes :
                    Optional (List { mapKey : Text, mapValue : Text })
                }
          , downwardAPI =
              None
                { defaultMode : Optional Natural
                , items :
                    Optional
                      ( List
                          { fieldRef :
                              Optional
                                { apiVersion : Optional Text, fieldPath : Text }
                          , mode : Optional Natural
                          , path : Text
                          , resourceFieldRef :
                              Optional
                                { containerName : Optional Text
                                , divisor : Optional Text
                                , resource : Text
                                }
                          }
                      )
                }
          , emptyDir =
              None { medium : Optional Text, sizeLimit : Optional Text }
          , fc =
              None
                { fsType : Optional Text
                , lun : Optional Natural
                , readOnly : Optional Bool
                , targetWWNs : Optional (List Text)
                , wwids : Optional (List Text)
                }
          , flexVolume =
              None
                { driver : Text
                , fsType : Optional Text
                , options : Optional (List { mapKey : Text, mapValue : Text })
                , readOnly : Optional Bool
                , secretRef : Optional { name : Optional Text }
                }
          , flocker =
              None { datasetName : Optional Text, datasetUUID : Optional Text }
          , gcePersistentDisk =
              None
                { fsType : Optional Text
                , partition : Optional Natural
                , pdName : Text
                , readOnly : Optional Bool
                }
          , gitRepo =
              None
                { directory : Optional Text
                , repository : Text
                , revision : Optional Text
                }
          , glusterfs =
              None { endpoints : Text, path : Text, readOnly : Optional Bool }
          , hostPath = None { path : Text, type : Optional Text }
          , iscsi =
              None
                { chapAuthDiscovery : Optional Bool
                , chapAuthSession : Optional Bool
                , fsType : Optional Text
                , initiatorName : Optional Text
                , iqn : Text
                , iscsiInterface : Optional Text
                , lun : Natural
                , portals : Optional (List Text)
                , readOnly : Optional Bool
                , secretRef : Optional { name : Optional Text }
                , targetPortal : Text
                }
          , name = "disk"
          , nfs = None { path : Text, readOnly : Optional Bool, server : Text }
          , persistentVolumeClaim = Some
            { claimName = "pgsql", readOnly = None Bool }
          , photonPersistentDisk = None { fsType : Optional Text, pdID : Text }
          , portworxVolume =
              None
                { fsType : Optional Text
                , readOnly : Optional Bool
                , volumeID : Text
                }
          , projected =
              None
                { defaultMode : Optional Natural
                , sources :
                    List
                      { configMap :
                          Optional
                            { items :
                                Optional
                                  ( List
                                      { key : Text
                                      , mode : Optional Natural
                                      , path : Text
                                      }
                                  )
                            , name : Optional Text
                            , optional : Optional Bool
                            }
                      , downwardAPI :
                          Optional
                            { items :
                                Optional
                                  ( List
                                      { fieldRef :
                                          Optional
                                            { apiVersion : Optional Text
                                            , fieldPath : Text
                                            }
                                      , mode : Optional Natural
                                      , path : Text
                                      , resourceFieldRef :
                                          Optional
                                            { containerName : Optional Text
                                            , divisor : Optional Text
                                            , resource : Text
                                            }
                                      }
                                  )
                            }
                      , secret :
                          Optional
                            { items :
                                Optional
                                  ( List
                                      { key : Text
                                      , mode : Optional Natural
                                      , path : Text
                                      }
                                  )
                            , name : Optional Text
                            , optional : Optional Bool
                            }
                      , serviceAccountToken :
                          Optional
                            { audience : Optional Text
                            , expirationSeconds : Optional Natural
                            , path : Text
                            }
                      }
                }
          , quobyte =
              None
                { group : Optional Text
                , readOnly : Optional Bool
                , registry : Text
                , tenant : Optional Text
                , user : Optional Text
                , volume : Text
                }
          , rbd =
              None
                { fsType : Optional Text
                , image : Text
                , keyring : Optional Text
                , monitors : List Text
                , pool : Optional Text
                , readOnly : Optional Bool
                , secretRef : Optional { name : Optional Text }
                , user : Optional Text
                }
          , scaleIO =
              None
                { fsType : Optional Text
                , gateway : Text
                , protectionDomain : Optional Text
                , readOnly : Optional Bool
                , secretRef : { name : Optional Text }
                , sslEnabled : Optional Bool
                , storageMode : Optional Text
                , storagePool : Optional Text
                , system : Text
                , volumeName : Optional Text
                }
          , secret =
              None
                { defaultMode : Optional Natural
                , items :
                    Optional
                      ( List
                          { key : Text, mode : Optional Natural, path : Text }
                      )
                , optional : Optional Bool
                , secretName : Optional Text
                }
          , storageos =
              None
                { fsType : Optional Text
                , readOnly : Optional Bool
                , secretRef : Optional { name : Optional Text }
                , volumeName : Optional Text
                , volumeNamespace : Optional Text
                }
          , vsphereVolume =
              None
                { fsType : Optional Text
                , storagePolicyID : Optional Text
                , storagePolicyName : Optional Text
                , volumePath : Text
                }
          }
        , { awsElasticBlockStore =
              None
                { fsType : Optional Text
                , partition : Optional Natural
                , readOnly : Optional Bool
                , volumeID : Text
                }
          , azureDisk =
              None
                { cachingMode : Optional Text
                , diskName : Text
                , diskURI : Text
                , fsType : Optional Text
                , kind : Text
                , readOnly : Optional Bool
                }
          , azureFile =
              None
                { readOnly : Optional Bool
                , secretName : Text
                , shareName : Text
                }
          , cephfs =
              None
                { monitors : List Text
                , path : Optional Text
                , readOnly : Optional Bool
                , secretFile : Optional Text
                , secretRef : Optional { name : Optional Text }
                , user : Optional Text
                }
          , cinder =
              None
                { fsType : Optional Text
                , readOnly : Optional Bool
                , secretRef : Optional { name : Optional Text }
                , volumeID : Text
                }
          , configMap = Some
            { defaultMode = Some 777
            , items =
                None (List { key : Text, mode : Optional Natural, path : Text })
            , name = Some "pgsql-conf"
            , optional = None Bool
            }
          , csi =
              None
                { driver : Text
                , fsType : Optional Text
                , nodePublishSecretRef : Optional { name : Optional Text }
                , readOnly : Optional Bool
                , volumeAttributes :
                    Optional (List { mapKey : Text, mapValue : Text })
                }
          , downwardAPI =
              None
                { defaultMode : Optional Natural
                , items :
                    Optional
                      ( List
                          { fieldRef :
                              Optional
                                { apiVersion : Optional Text, fieldPath : Text }
                          , mode : Optional Natural
                          , path : Text
                          , resourceFieldRef :
                              Optional
                                { containerName : Optional Text
                                , divisor : Optional Text
                                , resource : Text
                                }
                          }
                      )
                }
          , emptyDir =
              None { medium : Optional Text, sizeLimit : Optional Text }
          , fc =
              None
                { fsType : Optional Text
                , lun : Optional Natural
                , readOnly : Optional Bool
                , targetWWNs : Optional (List Text)
                , wwids : Optional (List Text)
                }
          , flexVolume =
              None
                { driver : Text
                , fsType : Optional Text
                , options : Optional (List { mapKey : Text, mapValue : Text })
                , readOnly : Optional Bool
                , secretRef : Optional { name : Optional Text }
                }
          , flocker =
              None { datasetName : Optional Text, datasetUUID : Optional Text }
          , gcePersistentDisk =
              None
                { fsType : Optional Text
                , partition : Optional Natural
                , pdName : Text
                , readOnly : Optional Bool
                }
          , gitRepo =
              None
                { directory : Optional Text
                , repository : Text
                , revision : Optional Text
                }
          , glusterfs =
              None { endpoints : Text, path : Text, readOnly : Optional Bool }
          , hostPath = None { path : Text, type : Optional Text }
          , iscsi =
              None
                { chapAuthDiscovery : Optional Bool
                , chapAuthSession : Optional Bool
                , fsType : Optional Text
                , initiatorName : Optional Text
                , iqn : Text
                , iscsiInterface : Optional Text
                , lun : Natural
                , portals : Optional (List Text)
                , readOnly : Optional Bool
                , secretRef : Optional { name : Optional Text }
                , targetPortal : Text
                }
          , name = "pgsql-conf"
          , nfs = None { path : Text, readOnly : Optional Bool, server : Text }
          , persistentVolumeClaim =
              None { claimName : Text, readOnly : Optional Bool }
          , photonPersistentDisk = None { fsType : Optional Text, pdID : Text }
          , portworxVolume =
              None
                { fsType : Optional Text
                , readOnly : Optional Bool
                , volumeID : Text
                }
          , projected =
              None
                { defaultMode : Optional Natural
                , sources :
                    List
                      { configMap :
                          Optional
                            { items :
                                Optional
                                  ( List
                                      { key : Text
                                      , mode : Optional Natural
                                      , path : Text
                                      }
                                  )
                            , name : Optional Text
                            , optional : Optional Bool
                            }
                      , downwardAPI :
                          Optional
                            { items :
                                Optional
                                  ( List
                                      { fieldRef :
                                          Optional
                                            { apiVersion : Optional Text
                                            , fieldPath : Text
                                            }
                                      , mode : Optional Natural
                                      , path : Text
                                      , resourceFieldRef :
                                          Optional
                                            { containerName : Optional Text
                                            , divisor : Optional Text
                                            , resource : Text
                                            }
                                      }
                                  )
                            }
                      , secret :
                          Optional
                            { items :
                                Optional
                                  ( List
                                      { key : Text
                                      , mode : Optional Natural
                                      , path : Text
                                      }
                                  )
                            , name : Optional Text
                            , optional : Optional Bool
                            }
                      , serviceAccountToken :
                          Optional
                            { audience : Optional Text
                            , expirationSeconds : Optional Natural
                            , path : Text
                            }
                      }
                }
          , quobyte =
              None
                { group : Optional Text
                , readOnly : Optional Bool
                , registry : Text
                , tenant : Optional Text
                , user : Optional Text
                , volume : Text
                }
          , rbd =
              None
                { fsType : Optional Text
                , image : Text
                , keyring : Optional Text
                , monitors : List Text
                , pool : Optional Text
                , readOnly : Optional Bool
                , secretRef : Optional { name : Optional Text }
                , user : Optional Text
                }
          , scaleIO =
              None
                { fsType : Optional Text
                , gateway : Text
                , protectionDomain : Optional Text
                , readOnly : Optional Bool
                , secretRef : { name : Optional Text }
                , sslEnabled : Optional Bool
                , storageMode : Optional Text
                , storagePool : Optional Text
                , system : Text
                , volumeName : Optional Text
                }
          , secret =
              None
                { defaultMode : Optional Natural
                , items :
                    Optional
                      ( List
                          { key : Text, mode : Optional Natural, path : Text }
                      )
                , optional : Optional Bool
                , secretName : Optional Text
                }
          , storageos =
              None
                { fsType : Optional Text
                , readOnly : Optional Bool
                , secretRef : Optional { name : Optional Text }
                , volumeName : Optional Text
                , volumeNamespace : Optional Text
                }
          , vsphereVolume =
              None
                { fsType : Optional Text
                , storagePolicyID : Optional Text
                , storagePolicyName : Optional Text
                , volumePath : Text
                }
          }
        ]
      }
    }
  }
, status =
    None
      { availableReplicas : Optional Natural
      , collisionCount : Optional Natural
      , conditions :
          Optional
            ( List
                { lastTransitionTime : Optional Text
                , lastUpdateTime : Optional Text
                , message : Optional Text
                , reason : Optional Text
                , status : Text
                , type : Text
                }
            )
      , observedGeneration : Optional Natural
      , readyReplicas : Optional Natural
      , replicas : Optional Natural
      , unavailableReplicas : Optional Natural
      , updatedReplicas : Optional Natural
      }
}
