#Tóth Bence WDFP8X
include ../view/language_window
include postgreSQL_controller

proc startApp() =
  var n : int
  if lang_start() == 1:
    echo "hu"
  else:
    echo "en"