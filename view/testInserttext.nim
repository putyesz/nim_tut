## Tóth Bence WDFP8X

when defined(aio):
  import wNim
else:
  import wNim/[wApp, wFrame, wPanel, wEvent, wIcon,
    wStaticBox, wButton, wStaticText, wTextCtrl, wMessageDialog]

proc insertTextWindow *(question: string) : string=
  let app = App()
  let frame = Frame(title="Nim Tutorial", size=(500, 520))
  frame.setIcon(Icon(r"sources\tut_icon.ico"))
  frame.minSize = (500, 520)
  frame.maxSize = (500, 520)

  let panel = Panel(frame)
  let statictextbox = StaticBox(panel, label="Question")
  let staticansbox = StaticBox(panel, label="Answer")
  let statictext = StaticText(panel, label=question)
  let buttonOK = Button(panel, label="OK")
  buttonOK.enable(false)
  let textctrl = TextCtrl(panel, style=wBorderSunken)

  var res = ""

  proc layout() =
    panel.autolayout """
      H:|[statictextbox, staticansbox]|
      H:|->[buttonOK]-|
      V:|-[statictextbox(=280)]-[staticansbox(=70)]->[buttonOK]-|

      outer: statictextbox
      HV:|-30-[statictext]-30-|

      outer: staticansbox
      H:|-150-[textctrl]-150-|
      V:|-[textctrl]-|
    """

  textctrl.wEvent_Text do ():
    if textctrl.value != "":
      buttonOK.enable()
    else:
      buttonOK.disable()

  buttonOK.wEvent_Button do ():
    res = textctrl.getValue()
    frame.destroy()

  textctrl.wEvent_TextEnter do ():
    if textctrl.value != "":
      res = textctrl.getValue()
      frame.destroy()

  layout()
  frame.center()
  frame.show()
  app.mainLoop()
  result = res

# echo insertTextWindow("semmi")