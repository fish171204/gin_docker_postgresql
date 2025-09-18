import-db: 
    Get-Content ./backupdb-master-golang.sql | docker exec -i postgres-db psql -U root -d master-golang
	#		          (file ex)	   				             (db_name)	   (username) (from file name)
export-db: 
    docker exec -i postgres-db pg_dump -U root -d master-golang > ./backupdb-master-golang.sql
	#			   (db_name)			(username) (file name)


migrate create -ext sql -dir internal/db/migrations -seq users
	#			   (file ex)	   				             (dir name)	   (from file name) 

migrate -path internal/db/migrations -database "postgresql://root:khoa@123456@localhost:5433/master-golang?sslmode=disable" up
	#			   (dir name)	   (db connection string)	(username:password)						(command)