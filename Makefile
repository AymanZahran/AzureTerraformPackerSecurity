Hello:
	echo "Begining the Udacity Deploying Web Server on Azure using Azure Policy, Packer and Terraform"
Policy:
	echo "Building Azure Policy"
	az policy definition create --name Tagging-Policy --display-name "Tagging-Policy" --description "Enforce Tagging on all Resources" --rules EnforceTags.json --mode All	
Packer:
	echo Building Packer Image
Terraform:
	Building the Infrastructure
all: Policy Packer Terraform
