## Tóth Bence WDFP8X

import system

when defined(aio):
  import wNim
else:
  import wNim/[wApp, wFrame, wPanel, wEvent, wIcon,
    wStaticBox, wButton, wGauge, wStaticText, wTextCtrl]

proc tutorialWindow *(title: string, text : string, progress: int, length: int): int =
  let app = App()
  let frame = Frame(title="Nim Tutorial", size=(500, 520))
  frame.setIcon(Icon(r"sources\tut_icon.ico"))
  frame.minSize = (500, 520)
  frame.maxSize = (500, 520)

  let panel = Panel(frame)
  let staticbox = StaticBox(panel, label=title)
  let statictext = StaticText(panel, label=text)

  let buttonNext = Button(panel, label="Next")
  if progress == length - 1:
    buttonNext.setLabel("Finish")


  let buttonPrev  = Button(panel, label="Prev")
  let gauge = Gauge(panel, value=progress, range=length)
  var res = 0

  proc layout() =
    panel.autolayout """
      H:|-[staticbox]-|
      H:|-[gauge]->[buttonPrev]-[buttonNext]-|
      V:|-[staticbox(=430)]-[gauge, buttonPrev,buttonNext]-|

      outer: staticbox
      H:|-[statictext]-|
      V:|-[statictext]-|
    """


  buttonPrev.wEvent_Button do ():
    if progress - 1 >= 0:
      res = -1
      frame.destroy()

  buttonNext.wEvent_Button do ():
    if progress + 1 < length:
      res = 1
      frame.destroy()
    if buttonNext.getLabel() == "Finish":
      res = 2
      frame.destroy

  layout()
  frame.center()
  frame.show()
  app.mainLoop()
  result = res