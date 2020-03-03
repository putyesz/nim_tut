#Tóth Bence WDFP8X
import ../view/progress_window
# import postgreSQL_controller

proc startApp*() =
  var n : int
  lang_start(n)
  if n == 1:
    echo "hu"
  else:
    echo "en"