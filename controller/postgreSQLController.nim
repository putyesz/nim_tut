#Tóth Bence WDFP8X
import db_postgres, strutils, db_common
include ../model/row_model

var
  conn, user, pass, sche : string

pass = "Ab123456"
sche = "nim_tut"


########################################




## Function to convert SQL result -> Row
proc rowizer*(rec: seq[string]): Row =
  result = Row(id: parseInt(rec[0]), page: rec[1], is_puzzle: rec[2])

##Function to get text for page
proc getEnText(n : int) : string =
  let db = open(conn, user, pass, sche)
  echo db.getRow(sql"select en_page from texts")[0]
  #result = db.getRow(sql"select en_page from texts where id = ?", n)[0]
  db.close()


echo getEnText(0)


proc getHuText*(n : int) : string =
  let db = open(conn, user, pass, sche)
  result = db.getRow(sql"select hu_page from texts where id = ?", n)[0]
  db.close()

proc getSectionId*(n : int) : int =
  let db = open(conn, user, pass, sche)
  result = parseInt(db.getRow(sql"select section_id from texts where id = ?", n)[0])
  db.close()

proc getSectionLen*(n : int) : int =
  let db = open(conn, user, pass, sche)
  result = parseInt(db.getRow(sql"select count(*) from texts where section_id = ?", n)[0])
  db.close()

########################################


proc getAnswer*(text_id : int) : char =
  let db = open(conn, user, pass, sche)
  result = db.getRow(sql"select answer from sections where id = (select section_id from texts where id = ?)", text_id)[0][0]
  db.close()

proc getAnswer*(section_name : string) : char =
  let db = open(conn, user, pass, sche)
  result = db.getRow(sql"select answer from sections where section_name = ?", section_name)[0][0]
  db.close()


proc getQuestion*(n : int) : string =
  let db = open(conn, user, pass, sche)
  result = db.getRow(sql"select question from sections where id = (select section_id from texts where id = ?)", n)[0]
  db.close()


proc getSectionNameForText*(n : int) : string =
  let db = open(conn, user, pass, sche)
  result = db.getRow(sql"select section_name from sections where id = (select section_id from texts where id = ?)", n)[0]
  db.close()

proc getSectionNameForSection*(n : int) : string =
  let db = open(conn, user, pass, sche)
  result = db.getRow(sql"select section_name from sections where id = ?", n)[0]
  db.close()

proc getLineNumber*(s : string) : int =
  let db = open(conn, user, pass, sche)
  result = parseInt(db.getRow(sql("select count(*) from " & s))[0])
  db.close()