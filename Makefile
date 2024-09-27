# Makefile for Terraform Workspace Management

# Default workspace name
WORKSPACE ?= dev

# Create backend for terraform
backend:
	cat backend > backend.tf

# Target to initialize Terraform
init: backend
	terraform init
# Validate terraform script
validate:
	terraform fmt -check
	terraform validate
# Target to create or select a workspace
workspace: init validate
	@terraform workspace select $(WORKSPACE) || terraform workspace new $(WORKSPACE)

# Target to apply Terraform configuration
apply: workspace
	terraform apply -auto-approve -var-file="environment/dev/terraform.tfvars"

# Target to destroy resources in the selected workspace
destroy: workspace
	terraform destroy -auto-approve -var-file="environment/dev/terraform.tfvars"

# Target to plan Terraform changes
plan: workspace
	terraform plan -var-file="environment/dev/terraform.tfvars"

dev: workspace apply
	@echo "Provisioning build stack on dev stage'"

prod:
	@echo "Provisioning build stack on dev stage'"
	terraform workspace select prod
	terraform plan -var-file="environment/prod/terraform.tfvars"

	#terraform apply -auto-approve

