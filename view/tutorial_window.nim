#Tóth Bence WDFP8X

when defined(aio):
  import wNim
else:
  import wNim/[wApp, wFrame, wPanel, wEvent, wIcon,
    wStaticBox, wButton, wStaticText]

let app = App()
let frame = Frame(title="Nim Tutorial", size=(500, 520))
frame.setIcon(Icon(r"sources\tut_icon.ico"))
frame.minSize = (500, 520)
frame.maxSize = (500, 520)

let panel = Panel(frame)

let staticbox = StaticBox(panel, label="")
let statictext = StaticText(panel, label="""Szövegek helye, amit majd az adatbázisból kérek le nagy valószínűségge, több nyelven is, mert talán errőlis tudok majd a későbbiekben írni a szakdolgozatomban.""")

let buttonNext = Button(panel, label="Next")
let buttonPrev  = Button(panel, label="Prev")

proc layout() =
  panel.autolayout """
    H:|-[staticbox]-|
    H:|->[buttonPrev]-[buttonNext]-|
    V:|-[staticbox(=430)]-[buttonPrev,buttonNext]-|

    outer: staticbox
    H:|-[statictext]-|
    V:|-[statictext]-|
  """

panel.wEvent_Size do ():
  layout()

layout()
frame.center()
frame.show()
app.mainLoop()