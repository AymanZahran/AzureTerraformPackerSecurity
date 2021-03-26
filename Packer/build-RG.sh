#!/bin/bash
az group create --resource-group $BUILD_RESOURCE_GROUP --location $AZURE_LOCATION --tags webserver-env="Production"
