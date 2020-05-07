## Tóth Bence WDFP8X

import ../model/colorPanel

import std/tables

when defined(aio):
  import wNim
else:
  import wNim/[wApp, wButton, wFrame, wPanel, wIcon, wStaticBox]

proc sectionsWindow* (table: OrderedTable[string, int]) : string =
  var res = "-1"
  let app = App()
  let frame = Frame(title="Nim Tutorial",  size=(840, 670))
  frame.minSize = (840, 670)
  frame.maxSize = (840, 670)
  frame.setIcon(Icon(r"sources\tut_icon.ico"))

  let panel = Panel(frame)
  let staticbox = StaticBox(panel, label="Sections")
  let exitButton = Button(panel, label="exit")
  let sectionsPanel = ColorPanel(staticbox, table)

  proc layout() =
    panel.autolayout """
      H:|-[staticbox]-|
      H:|->[exitButton]-|
      V:|-[staticbox(570)]-[exitButton]-|

      outer: staticbox
      HV:|-[sectionsPanel]-|
    """

  sectionsPanel.wEvent_LeftDown do (event: wEvent):
    res = sectionsPanel.getSectionName(event.mousePos)
    if res != "" :
      frame.destroy()

  exitButton.wEvent_Button do (event: wEvent):
    frame.destroy()

  layout()
  frame.center()
  frame.show()
  app.mainLoop()
  result = res