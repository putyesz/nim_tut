## Tóth Bence WDFP8X
import ../view/tutorialWindow
# import ../view/sectionsWindow
# import mongoDBController
import strutils
## Not working yet

proc myEscape*(str: string): string =
  result = str.replace("\\n", $'\n').replace("\\t", $'\t')

proc myUnEscape*(str: string): string =
  result = str.replace($'\n', "\\n").replace($'\t', "\\t")

proc startApp*()=
  echo 0
  # echo getSectionNames()
  # tutorialWindow(getSection(0))
  # echo sectionsWindow(getTexts(0))
  # echo getTexts(getSection(0))[0]

# let msg = r"Some message:\n\t\tincludes newlines\n\t\tand tabs."

# echo msg.replace('\\'&'n', ""&'\n').replace('\\'&'t', ""&'\t')
# echo msg.replace("\\n", $'\n').replace("\\t", $'\t')
# echo myEscape(msg)

# startApp()