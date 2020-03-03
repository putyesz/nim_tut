#Tóth Bence WDFP8X

import strutils

when defined(aio):
  import wNim
else:
  import wNim/[wApp, wFrame, wPanel, wEvent, wIcon,
    wStaticBox, wButton, wGauge, wStaticText]

let app = App()
let frame = Frame(title="Nim Tutorial", size=(500, 520))
frame.setIcon(Icon(r"sources\tut_icon.ico"))
frame.minSize = (500, 520)
frame.maxSize = (500, 520)

let panel = Panel(frame)

let staticbox = StaticBox(panel, label="Installation")
#let statictext = StaticText(panel, label="""Szövegek helye, amit majd az adatbázisból kérek le nagy valószínűségge, több nyelven is, mert talán errőlis tudok majd a későbbiekben írni a szakdolgozatomban.""")
let statictext = StaticText(panel, label="Nim has ready made distributions for all three major operating systems and there are several options when it comes to installing Nim.\n\n" & indent("You can follow the official installation procedure to install the latest stable version, or you can use a tool called choosenim which enables you to easily switch between the stable and the latest development version if you’re interested in the latest features and bugfixes.", 4) & "\n\nWhichever way you choose, just follow the installation procedure explained at each link and Nim should be installed. We will check that the installation went well in a coming chapter.\n\nIf you’re using Linux, there is a high probability that your distribution has Nim in the package manager. If you are installing it that way, make sure it’s the most recent version (see the website for what is the latest version), otherwise install via one of two methods mentioned above.")

let buttonNext = Button(panel, label="Next")
let buttonPrev  = Button(panel, label="Prev")

let gauge = Gauge(panel)

proc layout() =
  panel.autolayout """
    H:|-[staticbox]-|
    H:|-[gauge]->[buttonPrev]-[buttonNext]-|
    V:|-[staticbox(=430)]-[gauge, buttonPrev,buttonNext]-|

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