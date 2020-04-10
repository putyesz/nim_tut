## Tóth Bence WDFP8X

import ../view/tutorialWindow
import mongoDBController
import wNim/wMessageDialog
from mainController import myEscape, myUnEscape

proc tutorialControll*(n: int): string =
  result = "0"
  var actualText = getTexts(n)[0].myEscape()
  var title = getTitle(n)
  var progression = 0
  var length = len(getTexts(n))
  while true:
    result = "1"
    var ret = tutorialWindow(title, actualText, progression, length)
    if ret != 2:
      progression += ret
    else:
      break
    actualText = getTexts(n)[progression].myEscape()

  # buttonNext.wEvent_Button do (event: wEvent):
  #   var i = texts.find($textctrl.getValue()) + 1
  #   if i < len(texts):
  #     gauge.setValue(i)
  #     textctrl.setLabel(texts[i])

  MessageDialog(caption="Congratulations!", message="You have reached the end of this section!", style=wOk).display()
  result = "2"

echo tutorialControll(0)