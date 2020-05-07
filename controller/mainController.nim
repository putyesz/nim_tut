## Tóth Bence WDFP8X

import exercisesController
import mongoDBController
import sectionsController
import tutorialController

import strutils

proc myEscape*(str: string): string =
  result = str.replace("\\n", $'\n').replace("\\t", $'\t')

proc myUnEscape*(str: string): string =
  result = str.replace($'\n', "\\n").replace($'\t', "\\t")

proc startApp()=
  var section = sectionsControll()
  while section != -1:
    var tutorial = tutorialControll(section)
    setProgress(section, tutorial)
    if tutorial == 2 and hasExercise(section):
      exercisesControll(section)
    section = sectionsControll()