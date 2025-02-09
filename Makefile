dev:
	docker-compose up app

test:
	docker-compose -f docker-compose.yml up --abort-on-container-exit --exit-code-from app

ci:
	docker-compose -f docker-compose.yml up --abort-on-container-exit

migrate:
	make -C app migrate

migrate-status:
	make -C app migrate-status

migrate-rollback:
	make -C app migrate-rollback

install:
	make -C ansible install

prepare-dev-env:
	make -C ansible prepare-dev-env

deploy:
	make -C ansible deploy -e "image_version=$(VERSION)"

rollback:
	make -C ansible rollback -e rollback_batch=$(ROLLBACK_BATCH)"

inventory:
	make -C ansible inventory

encrypt:
	ansible-vault encrypt --ask-vault-password ansible/group_vars/ec2_instance/vault.yml

decrypt:
	ansible-vault decrypt --ask-vault-password ansible/group_vars/ec2_instance/vault.yml

init:
	make -C terraform init

apply:
	make -C terraform apply

output:
	make -C terraform output

destroy:
	make -C terraform destroy