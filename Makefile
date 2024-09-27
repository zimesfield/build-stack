# Makefile for Terraform Workspace Management

# Default workspace name
WORKSPACE ?= dev

# Target to create or select a workspace
workspace:
	@terraform workspace select $(WORKSPACE) || terraform workspace new $(WORKSPACE)


# Target to initialize Terraform
init:
	terraform init -migrate-state -var-file="environment/dev/terraform.tfvars"
# Create backend for terraform
backend: init
	cat backend > backend.tf

# Validate terraform script
validate: backend
	terraform fmt -check
	terraform validate

# Target to apply Terraform configuration
apply: init
	terraform apply -auto-approve -var-file="environment/dev/terraform.tfvars"

# Target to destroy resources in the selected workspace
destroy:
	terraform destroy -auto-approve -var-file="environment/dev/terraform.tfvars"

# Target to plan Terraform changes
plan: init
	terraform plan -var-file="environment/dev/terraform.tfvars"

dev: init validate apply
	@echo "Provisioning build stack on dev stage'"

prod:
	@echo "Provisioning build stack on dev stage'"
	terraform workspace select prod
	terraform plan -var-file="environment/prod/terraform.tfvars"

	#terraform apply -auto-approve

