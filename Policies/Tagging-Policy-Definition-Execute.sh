#!/bin/bash
az policy definition create --name 'Tagging-Policy' --display-name 'Tagging-Policy' --description 'Enforce Tagging on all Resources' --params Policies/Tagging-Policy-Definition-Params.json --rules Policies/Tagging-Policy-Definition-Rules.json  --subscription `echo $AZURE_SUBSCRIPTION_ID` --mode All
