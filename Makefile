docker-up:
	docker-compose up -d

docker-down:
	docker-compose down

createdb:
	docker exec -it simple-bank-golang-db-1 createdb --username=admin --owner=admin bank

dropdb:
	docker exec -it simple-bank-golang-db-1 dropdb bank --username=admin

migrateup:
	migrate -path db/migration -database "postgresql://admin:admin123@localhost:5432/bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://admin:admin123@localhost:5432/bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...
	
.PHONY: createdb dropdb migrateup migratedown sqlc docker-up docker-down