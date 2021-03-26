Preparing-Environment:
	chmod +x setENV.sh && bash setENV.sh &&\
	chmod +x Policies/Tagging-Policy-Definition-Execute.sh &&\
	chmod +x Policies/Tagging-Policy-Assignment-Execute.sh &&\
	chmod +x Packer/build-RG.sh

Tagging-Policy-Definition:
	cd Policies && bash Tagging-Policy-Definition-Execute.sh && cd ..

Tagging-Policy-Assignment:
	cd Policies && bash Tagging-Policy-Assignment-Execute.sh && cd ..

Tagging-Policy: Tagging-Policy-Definition Tagging-Policy-Assignment

Packer-RG:
	cd Packer && bash build-RG.sh && cd ..

Packer-Template:
	cd Packer && Packer build server.json && cd ..

Packer-Build: Packer-RG Packer-Template

Terraform-init:
	cd terraform && terraform init && cd ..

Terraform-plan:
	cd terraform && terraform plan -out solution.plan && cd ..

Terraform-apply:
	cd terraform && terraform apply --auto-approve && cd ..

Terraform-build: Terraform-init Terraform-plan Terraform-apply

Automate: Preparing-Environment Tagging-Policy Packer-build Terraform-build

