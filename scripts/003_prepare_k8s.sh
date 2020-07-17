#!/bin/sh
RESOURCE_GROUP=""
AKS_CLUSTER_NAME=""
IOT_HUB_CONNECTION_STRING=""

# Get the id of the service principal configured for AKS
# CLIENT_ID=$(az aks show --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME --query "servicePrincipalProfile.clientId" --output tsv)

# Get the ACR registry resource id
# ACR_ID=$(az acr show --name $ACR_NAME --resource-group $RESOURCE_GROUP --query "id" --output tsv)

# Create role assignment
# az role assignment create --assignee $CLIENT_ID --role acrpull --scope $ACR_ID

# az aks update --name tfm-aks --resource-group $RESOURCE_GROUP --attach-acr /subscriptions/0391015e-39a0-486a-810f-cd7e56d93206/resourceGroups/rgmsdetfm/providers/Microsoft.ContainerRegistry/registries/tfmacr

# Connect to AKS from local
az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME

# Create a Kubernetes namespace to house the IoT Edge connector
kubectl create ns hub0

# Create a Kubernetes secret in the namespace to hold the IoT Hub connection string
kubectl create secret generic my-secrets -n hub0 --from-literal=hub0-cs=$IOT_HUB_CONNECTION_STRING

# Install the iot-edge-connector
cd
cd Desktop/TFM/fireWarning/
helm install iot-edge-connector-hub0 iot-edge-connector --namespace hub0
watch kubectl get pods -n hub0
