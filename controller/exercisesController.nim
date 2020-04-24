## Tóth Bence WDFP8X

import mongoDBController
import ../view/testInserttext
import ../view/testRadiobutton
import wNim/wMessageDialog
import strutils

proc myEscape(str: string): string =
  result = str.replace("\\n", $'\n').replace("\\t", $'\t')

proc exercisesControll*(n: int)=
  # var i : tuple[exercise: string, inputType: string, answer: string]
  var score: int = 0
  for i in getExercises(n):
    var ans : string
    case i.inputType
    of "radio":
      ans = radioButtonWindow(i.exercise.myEscape())
    of "text":
      ans = insertTextWindow(i.exercise.myEscape())

    if ans == i.answer:
      score += 1
    #   MessageDialog(message="Good Answer", style=wOk).display()
    # else:
    #   MessageDialog(message="Bad Answer", style=wOk).display()
  MessageDialog(caption="Your score is:",message= $score & "/" & $len(getExercises(n)), style=wOk).display()