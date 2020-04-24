## Tóth Bence WDFP8X

import sectionsController
import tutorialController
import exercisesController

import strutils

proc myEscape*(str: string): string =
  result = str.replace("\\n", $'\n').replace("\\t", $'\t')

proc myUnEscape*(str: string): string =
  result = str.replace($'\n', "\\n").replace($'\t', "\\t")

proc startApp()=
  let section = sectionsControll()
  echo section
  let tutorial = tutorialControll(section)
  if tutorial == "2":
    exercisesControll(section)