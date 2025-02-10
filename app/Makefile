.PHONY: migrate

migrate:
	php vendor/bin/phinx migrate -e development
migrate-status:
	php vendor/bin/phinx status
migrate-rollback:
	php vendor/bin/phinx rollback