import db_mysql
let db = open("localhost", "root", "Ab123456", "nim_tut")
db.exec(sql"DROP TABLE IF EXISTS myTable")
db.exec(sql("""CREATE TABLE myTable (
                 id integer,
                 name varchar(50) not null)"""))
db.close()