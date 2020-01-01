import wNim/wApp
import wNim/wFrame

let app = App()
let frame = Frame(title="Hello World", size=(400, 300))

frame.center()
frame.show()
app.mainLoop()

# button.wEvent_Button do ():
  # frame.delete()

frame.wIdExit do ():
  frame.delete()

frame.wEvent_Size do ():
  layout()