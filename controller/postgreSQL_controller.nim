#Tóth Bence WDFP8X
import db_postgres
import strutils

var db = open("localhost", "user", "password", "db_name")
type
  Row = object
    id: int
    name: string
    email: string
# Function to convert SQL result -> Row
proc rowizer(rec: seq[string]): Row =
  result = Row(id: parseInt(rec[0]), name: rec[1], email: rec[2])
for rec in fastRows(db, sql"select * from contacts"):
  echo rowizer(rec)