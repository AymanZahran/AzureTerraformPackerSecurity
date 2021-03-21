Hello:
	echo "Begining the Udacity Deploying Web Server on Azure using Azure Policy, Packer and Terraform"
Policy:
	echo "Building Azure Policy"
	cd Policies
	az policy definition create --name Tagging-Policy --display-name "Tagging-Policy" --description "Enforce Tagging on all Resources" --rules EnforceTags.json --mode All	
	cd ..
Packer:
	echo "Building Images"
	cd Packer
	packer build -var-file=".pkrvars" server.json
	cd ..
Terraform:
	echo "Building Infrastructure"
	cd Terraform
	terraform apply -var-file=".tfvars"
	cd ..
all: Policy Packer Terraform
