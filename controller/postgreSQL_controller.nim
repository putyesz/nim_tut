#Tóth Bence WDFP8X
import db_postgres
import strutils
include ../model/row_model

## Function to convert SQL result -> Row
proc rowizer(rec: seq[string]): Row =
  result = Row(id: parseInt(rec[0]), page: rec[1], is_puzzle: rec[2])

##Function to get text for page
proc getText(n : int) : string =
  let db = open("localhost", "postgres", "Ab123456", "nim_tut")
  result = db.getRow(sql"select page from texts where id = ?", n)[0]
  db.close()

proc getIsPuzzle(n : int) : bool =
  let db = open("localhost", "postgres", "Ab123456", "nim_tut")
  if db.getRow(sql"select is_puzzle from texts where id = ?", n)[0] == "f":
    db.close()
    return = false
  db.close()
  result = true

echo getIsPuzzle(1)