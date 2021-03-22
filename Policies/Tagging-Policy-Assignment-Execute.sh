#!/bin/bash
az policy assignment create --name 'Tagging-Policy-Assignment' --display-name 'Tagging-Policy-Assignement' --params Tagging-Policy-Assignment-Params.json --scope /subscriptions/`echo $AZURE_SUBSCRIPTION_ID` --policy /subscriptions/`echo $AZURE_SUBSCRIPTION_ID`/providers/Microsoft.Authorization/policyDefinitions/Tagging-Policy
