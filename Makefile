include .env

Preparing-Environment:
	export $(cat .env | xargs)

Tagging-Policy-Definition:
	cd Policies &&\
	bash Tagging-Policy-Definition-Execute.sh &&\
	cd ..

Tagging-Policy-Assignment:
	cd Policies &&\
	bash Tagging-Policy-Assignment-Execute.sh &&\
	cd ..

Tagging-Policy: Tagging-Policy-Definition Tagging-Policy-Assignment

terraform-init:
	cd terraform && terraform init && cd -

terraform-plan:
	cd terraform && \
	terraform plan && \
	cd -

terraform-apply:
	cd terraform && \
	terraform apply && \
	cd -

packer-build:
	cd packer
	packer build server.json
	cd -
