setup_test:
	cd tests/setup && terraform init
	cd tests/setup && terraform apply
	cd tests/boundary && terraform init
	cd tests/boundary && terraform apply


run_test:
	./terraform test -var-file=./tests/secrets.auto.tfvars -var-file=./tests/boundary.auto.tfvars