# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Youtube Video
https://www.youtube.com/watch?v=7BuStHF6-rI

### Introduction
For this project, you will write an Azure Policy, Packer Template and a Terraform Template to deploy a customizable, scalable, Highly Available  web server in Azure.

### Getting Started
1. Clone this repository
2. Set your Environment Variables in a file called .env (For Security reasons I hide mine but you can cp the env.example file to .env and modify it with your credentials. Modify the bellow variable for customization
	1. AZURE_SUBSCRIPTION_ID="put your Azure Subscription ID here"
	2. AZURE_TENANT_ID="put your Azure Tenant ID here"
	3. AZURE_CLIENT_ID="put your Azure Client ID here"
	4. AZURE_CLIENT_SECRET="put your Azure Client Secret here"
	5. AZURE_LOCATION="put the region you want the resources to be deployed"
	6. RESOURCE_GROUP="put your Pakcer resource group here"
	7. IMAGE_NAME="put your Packer Image name here"
	8. OS_TYPE="put your Packer OS required"
	9. IMAGE_PUBLISHER="put your Packer Image Publisher here"
	10. IMAGE_OFFER="put your Packer Image Offer here"
	11. IMAGE_SKU="put your Packer Image SKU here"
	12. BUILD_RESOURCE_GROUP="put your Packer resourece group here"
	13. VM_SIZE="Put your Azure VM Size"
	14. PUB_KEY=${HOME}/.ssh/id_rsa.pub
	15. PVT_KEY=${HOME}/.ssh/id_rsa
	16. SSH_FINGERPRINT="Put your SSH-FINGERPRINT here"
	17. TF_VAR_AZURE_SUBSCRIPTION_ID="put your Azure Subscription ID here"
	16. TF_VAR_AZURE_TENANT_ID="put your Azure Tenant ID here"
	17. TF_VAR_AZURE_CLIENT_ID="put your Azure Client ID here"
	18. TF_VAR_AZURE_CLIENT_SECRET="put your Azure Client Secret here"
	19. TF_VAR_AZURE_LOCATION="put the region you want the resources to be deployed"
	20. TF_VAR_IMAGE_NAME="/subscriptions/put your Azure Subscription ID here/resourceGroups/put your Packer resourece group here/providers/Microsoft.Compute/images/put your Packer Image name here"
	21. TF_VAR_VM_SIZE="Put your Azure VM Size"
	22. TF_VAR_HOSTNAME="Put your Azure VM hostname here"
	23. TF_VAR_USERNAME="Put your Azure VM username here"
	24. TF_VAR_PASSWORD="Put your Azure VM password here"
	25. TF_VAR_NO_VMs="Put the number of VMs, default is 2"

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions
Build your infrastructure by run "make Automate", That will build the following
1. Build your environment variables locally (.env file)
2. Give execute permissions to bash scripts
3. Create Azure Policy to Enforce Tagging on all resources
4. Assign the Policy on your subscription
5. Build Packer Web Server Image 
6. Build Terraform IaC with the following Resources:
	a. 1 Resource Group
	b. 1 Virtual Network with 1 Subnet
	c. 1 NSG that controls traffic
	d. N Azure Managed Disks
	e. N WebServers assigned in your .env file
	f. N Public IPs
	g. N vNICs
	h. 1 Availability Set
	f. 1 Loadbalancer

### Output
Curl your LoadBalancer Public IP to see your deployed highly available WebServers



