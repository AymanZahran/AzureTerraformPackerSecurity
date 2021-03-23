Preparing-Environment:
	chmod +x setENV.sh && bash setENV.sh

Tagging-Policy-Definition:
	cd Policies && bash Tagging-Policy-Definition-Execute.sh && cd ..

Tagging-Policy-Assignment:
	cd Policies && bash Tagging-Policy-Assignment-Execute.sh && cd ..

Tagging-Policy: Tagging-Policy-Definition Tagging-Policy-Assignment

Packer-build:
	cd Packer && Packer build server.json && cd ..

Terraform-init:
	cd terraform && terraform init && cd ..

Terraform-plan:
	cd terraform && terraform plan -out solution.plan && cd ..

Terraform-apply:
	cd terraform && terraform apply --auto-approve && cd ..

Terraform-build: Terraform-init Terraform-plan Terraform-apply

Automate: Preparing-Environment Tagging-Policy Packer-build Terraform-build

