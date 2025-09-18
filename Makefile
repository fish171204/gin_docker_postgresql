include .env
export

CONN_STRING = postgresql://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST):$(DB_PORT)/$(DB_NAME)?sslmode=$(DB_SSLMODE)

MIGRATION_DIRS = internal/db/migrations

# Import database
importdb:
	docker exec -i postgres-db psql -U root -d master-golang < ./backupdb-master-golang.sql

# Export database
exportdb:
	docker exec -i postgres-db pg_dump -U root -d master-golang > ./backupdb-master-golang.sql

# Run server
server:
	go run .

# Create a new migration (make migrate-create NAME=profiles)
migrate-create:
	migrate create -ext sql -dir $(MIGRATION_DIRS) -seq $(NAME)

# Run all pending migration (make migrate-up)
migrate-up:
	migrate -path $(MIGRATION_DIRS) -database "$(CONN_STRING)" up

# Rollback the last migration
migrate-down:
	migrate -path $(MIGRATION_DIRS) -database "$(CONN_STRING)" down 1
