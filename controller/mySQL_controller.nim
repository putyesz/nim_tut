#Tóth Bence WDFP8X
import db_mysql
let db = open("localhost", "root", "Ab123456", "nim_tut")
db.exec(sql"DROP TABLE IF EXISTS myTable")
db.exec(sql("create table myTestTbl (" &
" Id    INT(11)     NOT NULL AUTO_INCREMENT PRIMARY KEY, " &
" Name  VARCHAR(50) NOT NULL, " &
" i     INT(11), " &
" f     DECIMAL(18,10))"))
db.close()