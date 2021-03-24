#!/bin/bash
az group create --resource-group MyResourceGroup3 --location $AZURE_LOCATION --tags webserver-env="Production"
