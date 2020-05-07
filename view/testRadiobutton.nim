## Tóth Bence WDFP8X

when defined(aio):
  import wNim
else:
  import wNim/[wApp, wFrame, wPanel, wEvent, wIcon,
    wStaticBox, wButton, wStaticText, wRadioButton, wMessageDialog]

const
  wEvent_RadioButtonOn = wEvent_App + 1

proc radioButtonWindow *(question: string) : string=
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
  buttonOK.disable()
  let radioMessage1 = RadioButton(panel, label="a")
  let radioMessage2 = RadioButton(panel, label="b")
  let radioMessage3 = RadioButton(panel, label="c")
  let radioMessage4 = RadioButton(panel, label="d")
  var res : string

  proc layout() =
    panel.autolayout """
      spacing: 8
      H:|[statictextbox, staticansbox]|
      H:|->[buttonOK]-|
      V:|-[statictextbox(=280)]-[staticansbox(=150)]->[buttonOK]-|

      outer: statictextbox
      HV:|-[statictext]-|

      outer: staticansbox
      H:|[radioMessage1, radioMessage2, radioMessage3, radioMessage4]|
      V:|[radioMessage1]-[radioMessage2]-[radioMessage3]-[radioMessage4]|
    """

  panel.wEvent_Size do ():
    layout()

  panel.wEvent_RadioButton do (event: wEvent):
    let radioButton = wRadioButton event.window
    if radioButton.value == true:
      buttonOK.enable()
      let event = Event(radioButton, msg=wEvent_RadioButtonOn)
      radioButton.processEvent(event)

  radioMessage1.wEvent_RadioButtonOn do ():
    buttonOK.wEvent_Button do ():
      res = "a"
      frame.destroy()

  radioMessage2.wEvent_RadioButtonOn do ():
    buttonOK.wEvent_Button do ():
      res = "b"
      frame.destroy()

  radioMessage3.wEvent_RadioButtonOn do ():
    buttonOK.wEvent_Button do ():
      res = "c"
      frame.destroy()

  radioMessage4.wEvent_RadioButtonOn do ():
    buttonOK.wEvent_Button do ():
      res = "d"
      frame.destroy()

  layout()
  frame.center()
  frame.show()
  app.mainLoop()
  result = res