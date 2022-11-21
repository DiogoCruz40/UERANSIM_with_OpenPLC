# UERANSIM with OpenPLC 

​	This is a project composed by UERANSIM v2.2.6 and OpenPLC v3 to run in a Kubernetes environment.

## Prerequisites:

[Kubernetes](https://kubernetes.io/docs/setup/)

[HELM](https://helm.sh/docs/intro/install/)

## Installation:

1. $ `kubectl create namespace core5g`
2. $ `helm repo add openverso https://gradiant.github.io/openverso-charts/`
3. $ `helm repo update`
4. $ `helm install <name-of-gnb> openverso/ueransim-gnb -n core5g `
5. $ `git clone https://github.com/DiogoCruz40/UERANSIM_with_OpenPLC`
6. Change **supi** (only the **MSISDN** property) if u want to have different UEs  -> [ue.yaml](https://github.com/DiogoCruz40/UERANSIM_with_OpenPLC/blob/main/ue.yaml)
7. $ `docker login registry.gitlab.com`
8. $ `docker build -t registry.gitlab.com/<your-repository>/<name>:<tag> .`
9. $ `docker push registry.gitlab.com/<your-repository>/<name>:<tag>` 
10. Change **initialMSISDN** to match **supi** property in *ue.yaml*  folder if u want to have different UEs -> [values.yaml](https://github.com/DiogoCruz40/UERANSIM_with_OpenPLC/blob/main/ueransim-ues/values.yaml)
11. $ `helm install <name-of-ue>-<number-of-ue> ./ueransim-ues -n core5g`

## References:

OpenPLC v3 -> https://github.com/thiagoralves/OpenPLC_v3

UERANSIM -> https://github.com/aligungr/UERANSIM

Charts for ueransim -> https://github.com/Gradiant/openverso-charts
