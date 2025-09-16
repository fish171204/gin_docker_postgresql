import-db: 
    Get-Content ./backupdb-hoc-golang.sql | docker exec -i postgres-db psql -U root -d hoc_golang
	#		          (file ex)	   				             (db_name)	   (username) (from file name)
export-db: 
    docker exec -i postgres-db pg_dump -U root -d hoc_golang > ./backupdb-hoc-golang.sql
	#			   (db_name)			(username) (file name)
