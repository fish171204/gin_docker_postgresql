import-db: 
    Get-Content ./backupdb-master-golang.sql | docker exec -i postgres-db psql -U root -d master-golang
	#		          (file ex)	   				             (db_name)	   (username) (from file name)
export-db: 
    docker exec -i postgres-db pg_dump -U root -d master-golang > ./backupdb-master-golang.sql
	#			   (db_name)			(username) (file name)
