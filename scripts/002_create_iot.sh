#!/bin/sh

LOCATION=""
RESOURCE_GROUP=""
IOT_HUB=""

az iot hub device-identity create --hub-name $IOT_HUB --device-id iotedge1 --edge-enabled 
az iot hub device-identity create --hub-name $IOT_HUB --device-id iotedge2 --edge-enabled 
az iot hub device-identity create --hub-name $IOT_HUB --device-id iotedge3 --edge-enabled 