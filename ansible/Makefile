inventory:
	ansible-playbook -i inventory.ini -v create_inventory.yml

deploy:
	ansible-playbook playbook.yml --vault-password-file vault_password -i inventory.ini -e "image_version=$(image_version)"

prepare-dev-env:
	ansible-playbook playbook-prepare-dev-env.yml --vault-password-file vault_password

encrypt:
	ansible-vault encrypt --ask-vault-password group_vars/webservers/vault.yml

decrypt:
	ansible-vault decrypt --ask-vault-password group_vars/webservers/vault.yml