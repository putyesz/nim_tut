#Tóth Bence WDFP8X

when defined(aio):
  import wNim
else:
  import wNim/[wApp, wFrame, wPanel, wEvent, wIcon,
    wStaticBox, wButton]


# proc lang_start*(res: var int) =
  # let app = App()
  # let frame = Frame(title="Nim Tutorial", size=(280, 130))
  # frame.setIcon(Icon(r"sources\tut_icon.ico"))
  # frame.setMaxSize(280, 130)
  # frame.setMinSize(280, 130)
  # frame.disableMaximizeButton()

  # let panel = Panel(frame)

  # let staticbox = StaticBox(panel, label="Choose Language:")

  # let buttonEN = Button(panel, label="English")
  # let buttonHU = Button(panel, label="Magyar")
  # buttonEN.setIcon(Icon(r"sources\eng.ico"))
  # buttonHU.setIcon(Icon(r"sources\hun.ico"))

  # buttonEN.wEvent_Button do () :
  #   res = 1

  # buttonHU.wEvent_Button do ():
  #   res = 0

  # proc layout() =
  #   panel.autolayout """
  #     HV:|[staticbox]|

  #     outer: staticbox
  #     H:|[buttonHU(==buttonEN)]-[buttonEN(==buttonHU)]|
  #     V:|-10-[buttonHU, buttonEN]-10-|
  #   """

  # panel.wEvent_Size do ():
  #   layout()

  # layout()
  # frame.center()
  # frame.show()
  # app.mainLoop()

let app = App()
let frame = Frame(title="Nim Tutorial", size=(280, 130))
frame.setIcon(Icon(r"sources\tut_icon.ico"))
frame.setMaxSize(280, 130)
frame.setMinSize(280, 130)
frame.disableMaximizeButton()

let panel = Panel(frame)

let staticbox = StaticBox(panel, label="Choose Language:")

let buttonEN = Button(panel, label="English")
let buttonHU = Button(panel, label="Magyar")
buttonEN.setIcon(Icon(r"sources\eng.ico"))
buttonHU.setIcon(Icon(r"sources\hun.ico"))

# buttonEN.wEvent_Button do () :
#   res = 1

# buttonHU.wEvent_Button do ():
#   res = 0

proc layout() =
  panel.autolayout """
    HV:|[staticbox]|

    outer: staticbox
    H:|[buttonHU(==buttonEN)]-[buttonEN(==buttonHU)]|
    V:|-10-[buttonHU, buttonEN]-10-|
  """

panel.wEvent_Size do ():
  layout()

layout()
frame.center()
frame.show()
app.mainLoop()