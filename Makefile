
dev:
	@echo "Provisioning build stack on dev stage'"
	terraform init
	terraform workspace new dev
	terraform fmt -check
	terraform validate
	terraform plan -var-file="environment/dev/terraform.tfvars"
	terraform apply -auto-approve -var-file="environment/dev/terraform.tfvars"

prod:
	@echo "Provisioning build stack on dev stage'"
	terraform workspace select prod
	terraform plan -var-file="environment/prod/terraform.tfvars"

	#terraform apply -auto-approve

