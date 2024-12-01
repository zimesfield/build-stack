# Makefile for Terraform Workspace Management

# Default workspace name
WORKSPACE ?= dev

# Target to create or select a workspace
workspace:
	@terraform workspace select $(WORKSPACE) || terraform workspace new $(WORKSPACE)


# Target to initialize Terraform
init: workspace
	terraform init -migrate-state -input=false -var-file="environment/dev/terraform.tfvars"

# Create backend for terraform
backend: init
	cat environment/dev/backend > backend.tf

# Validate terraform script
validate: environment/dev/backend
	terraform fmt -check
	terraform validate


# Target to plan Terraform changes
plan: workspace backend
	terraform init -migrate-state -input=false -var-file="environment/dev/terraform.tfvars"
	terraform plan -var-file="environment/dev/terraform.tfvars"

# Target to apply Terraform configuration
apply:
	terraform apply -auto-approve -var-file="environment/dev/terraform.tfvars"

# Target to destroy resources in the selected workspace
destroy:
	terraform destroy -auto-approve -var-file="environment/dev/terraform.tfvars"

local: backend init validate plan
	@echo "Provisioning build stack on dev stage"

dev: apply
	@echo "Provisioning build stack on dev stage"

prod:
	@echo "Provisioning build stack on dev stage"
	terraform workspace select prod
	terraform plan -var-file="environment/prod/terraform.tfvars"

	#terraform apply -auto-approve

