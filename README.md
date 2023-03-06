# UERANSIM with OpenPLC 

​	This is a project composed by UERANSIM v2.2.6 and OpenPLC v3 to run in a Kubernetes environment.

## Prerequisites:

[Kubernetes](https://kubernetes.io/docs/setup/)

[Open5GS 2.6.0](https://open5gs.org/)

[HELM](https://helm.sh/docs/intro/install/)

## Installation:

1. First create a **namespace** or use the same namespace as your core 5G in your Kubernetes cluster.

```sh
$ kubectl create namespace core5g
```

2. Instantiate the **gnb** of *UERANSIM* for radio simulator purposes.

```sh
$ helm repo add openverso https://gradiant.github.io/openverso-charts/

$ helm repo update

$ helm install <name-of-gnb> openverso/ueransim-gnb -n core5g
```

3. Clone my repository in order to build the UEs and OpenPLC and enter it.

```sh
$ git clone https://github.com/DiogoCruz40/UERANSIM_with_OpenPLC && chmod -R 755 UERANSIM_with_OpenPLC && cd UERANSIM_with_OpenPLC
```

4. Change **supi** (only the **MSISDN** property) if u want to have different UEs in [ue.yaml](https://github.com/DiogoCruz40/UERANSIM_with_OpenPLC/blob/main/ue.yaml) file.

   The supi will serve as a unique identifier for your UE.

   #### Framed Routing

   1. Change the **ip addr** on line 28 from *192.168.20.100/24* to other for ex: *192.168.20.101/24* in [entrypoint.sh](https://github.com/DiogoCruz40/UERANSIM_with_OpenPLC/blob/main/entrypoint.sh) file.

   2. Add manually to subscribers in Open5GS mongodb the **ipv4_framed_routes** field as shown bellow:

      ```json
      {
        "_id": {
          "$oid": "637b8c4a829ed200017f05e6"
        },
        "imsi": "999700000000001",
        "subscribed_rau_tau_timer": 12,
        "network_access_mode": 0,
        "subscriber_status": 0,
        "access_restriction_data": 32,
        "slice": [
          {
            "sst": 1,
            "default_indicator": true,
            "_id": {
              "$oid": "637b8c4a829ed200017f05e7"
            },
            "session": [
              {
                "name": "internet",
                "type": 3,
                "_id": {
                  "$oid": "637b8c4a829ed200017f05e8"
                },
                "pcc_rule": [],
                "ambr": {
                  "uplink": {
                    "value": 1,
                    "unit": 3
                  },
                  "downlink": {
                    "value": 1,
                    "unit": 3
                  }
                },
                "qos": {
                  "index": 9,
                  "arp": {
                    "priority_level": 8,
                    "pre_emption_capability": 1,
                    "pre_emption_vulnerability": 1
                  }
                },
      -->          "ipv4_framed_routes": [
      -->            "192.168.20.0/24"
      -->          ]
              }
            ]
          }
        ],
        "ambr": {
          "uplink": {
            "value": 1,
            "unit": 3
          },
          "downlink": {
            "value": 1,
            "unit": 3
          }
        },
        "security": {
          "k": "465B5CE8 B199B49F AA5F0A2E E238A6BC",
          "amf": "8000",
          "op": null,
          "opc": "E8ED289D EBA952E4 283B54E8 8E6183CA",
          "sqn": {
            "$numberLong": "129"
          }
        },
        "purge_flag": [],
        "mme_realm": [],
        "mme_host": [],
        "imeisv": [
          "4370816125816151"
        ],
        "msisdn": [],
        "schema_version": 1,
        "__v": 0
      }
      ```

      


5. Build the image from the [Dockerfile](https://github.com/DiogoCruz40/UERANSIM_with_OpenPLC/blob/main/Dockerfile) presented in this repository.

```sh
$ docker login registry.gitlab.com

$ docker build -t registry.gitlab.com/<your-repository>/<name>:<tag> .

$ docker push registry.gitlab.com/<your-repository>/<name>:<tag> 
```

6. Change **initialMSISDN** (match **supi** property in *ue.yaml* folder) if u want to have different UEs in ueransim-ues/[values.yaml](https://github.com/DiogoCruz40/UERANSIM_with_OpenPLC/blob/main/ueransim-ues/values.yaml) file.
7. Change the **image sub-properties** if u want to have different UEs in ueransim-ues/[values.yaml](https://github.com/DiogoCruz40/UERANSIM_with_OpenPLC/blob/main/ueransim-ues/values.yaml) file.
8. Finally instantiate the UE that you have just built to your Kubernetes cluster.

```sh
$ helm install <name-of-ue>-<number-of-ue> ./ueransim-ues -n core5g
```

9. Repeat since the **4 step** if you want to implement different UEs.

## References:

OpenPLC v3 -> https://github.com/thiagoralves/OpenPLC_v3

UERANSIM -> https://github.com/aligungr/UERANSIM

Framed Routes -> https://github.com/s5uishida/open5gs_5gc_ueransim_framed_routing_sample_config

Charts for ueransim -> https://github.com/Gradiant/openverso-charts



If you have any problems you can always put an issue, in this project.
