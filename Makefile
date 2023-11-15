setup_test:
	cd tests/setup && terraform init
	cd tests/setup && terraform apply -auto-approve
	cd tests/configure && terraform init
	cd tests/configure && terraform apply -auto-approve

run_test:
	terraform test -var-file=./tests/secrets.auto.tfvars -var-file=./tests/boundary.auto.tfvars

clean:
	cd tests/configure && terraform destroy -auto-approve
	cd tests/setup && terraform destroy -auto-approve
