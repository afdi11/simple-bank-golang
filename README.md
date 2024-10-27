# simple-bank-golang

## WEEK#1
### How to write & run migration in golang
notes : 
- Check migrate version => command : `migrate -v` if not install you can download `github.com/golang-migrate/migrate`
- Create migration file => command : `migrate create -ext sql -dir db/migration -seq init_schema`
"-ext" is extention of the file
"-dir" is directory of file when created
"-seq" is option to sequential version number of migration
![alt text](<public/screenshoots/Screenshot 2024-10-16 at 05.52.03.png>)
- SQLC Generate => command : `sqlc generate`
Install sqlc - http://sqlc.dev
Use version 1

