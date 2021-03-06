## Tóth Bence WDFP8X

import mongoDBController
import ../view/tutorialWindow
import wNim/wMessageDialog
import strutils

proc myEscape(str: string): string =
  result = str.replace("\\n", $'\n').replace("\\t", $'\t')

proc tutorialControll*(n: int): int =
  result = 0
  var actualText = getTexts(n)[0].myEscape()
  var title = getTitle(n)
  var progression = 0
  var length = len(getTexts(n))
  while true:
    result = 1
    var ret = tutorialWindow(title, actualText, progression, length)
    if ret != 2 and ret != 0:
      progression += ret
    elif ret == 0:
      return result
    else:
      break
    actualText = getTexts(n)[progression].myEscape()

  MessageDialog(caption="Congratulations!",
                message="You have reached the end of this section!",style=wOk)
                .display()
  result = 2