# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, you will write an Azure Policy, Packer Template and a Terraform Template to deploy a customizable, scalable, Highly Available  web server in Azure.

### Getting Started
1. Clone this repository
2. Set your Environment Variables in a file called .env (For Security reasons I hide mine but you can cp the env.example file to .env and modify it with your credentials

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions
Build your infrastructure by run "make Automate", That will build the following
1. Build your environment variables locally 
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
	f. Loadbalancer

### Output
Curl your LoadBalancer Public IP to see your deployed highly available WebServe

