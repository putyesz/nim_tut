## Tóth Bence WDFP8X

import std/[colors, tables]

import wNim/[wApp, wBrush, wFrame, wFont, wMacros,
  wPaintDC, wPanel, wPen]

#wMenu, wMenuBar, wDataObject, wUtils

type
  wColorPanel = ref object of wPanel
    mColorTable: OrderedTable[string, wColor]
    mRects: Table[string, wRect]
    mBoxSize: wSize
    mBoxGap: int
    mFocusColor: string

wClass(wColorPanel of wPanel):

  proc onPaint*(self: wColorPanel) =
    var dc = PaintDC(self)
    var currentY = 0
    if self.hasScrollbar(wVertical): currentY = self.getScrollPos(wVertical)

    let clientSize = self.clientSize
    var x, y = self.mBoxGap

    y -= currentY

    dc.clear()
    for name, color in self.mColorTable:
      let intensColor = wColor intensity(Color color, 0.4)

      if x + self.mBoxSize.width + self.mBoxGap >= clientSize.width:
        y += self.mBoxSize.height + self.mBoxGap
        x = self.mBoxGap

      self.mRects[name] = (x, y, self.mBoxSize.width, self.mBoxSize.height)

      let height = dc.fontMetrics.height + 4
      let rect: wRect = (x + 20, y , self.mBoxSize.width - 20, height)

      if self.mFocusColor in [name, "all"]:
        dc.pen = Pen(intensColor, width=6, style=wPenStyleInsideFrame)
        dc.brush = Brush(intensColor)
      else:
        dc.pen = wTransparentPen
        dc.brush = Brush(wColor intensity(Color color, 0.0))

      dc.brush = Brush(color)
      dc.drawRectangle((x, y), self.mBoxSize)
      dc.textForeground = wWhite
      dc.textBackground = intensColor
      dc.drawLabel(name, rect, wMiddle)

      x += self.mBoxSize.width + self.mBoxGap

    let scrollHeight = y + currentY + (self.mBoxSize.height) * 2 + self.mBoxGap - clientSize.height
    if scrollHeight >= self.mBoxSize.height:
      self.showScrollBar(wVertical, true)
      self.setScrollbar(wVertical, currentY, self.mBoxSize.height, scrollHeight)
      if self.getScrollPos(wVertical) != currentY:
        self.refresh(false)
    else:
      self.showScrollBar(wVertical, false)

  proc getSectionName*(self: wColorPanel, pos: wPoint): string =
    for name, rect in self.mRects:
      if pos.x in (rect.x .. rect.x + rect.width) and
          pos.y in (rect.y .. rect.y + rect.height):
        return name

  proc onKeyMouse*(self: wColorPanel, event: wEvent) =
    let oldFocusColor = self.mFocusColor
    self.mFocusColor = self.getSectionName(event.mousePos)

    if oldFocusColor != self.mFocusColor:
      self.refresh(false)


  proc setTable*(self: wColorPanel, table: OrderedTable[string, int]) =
    template towColor(r: untyped, g: untyped, b: untyped): wColor =
      wColor(wColor(r and 0xff) or (wColor(g and 0xff) shl 8) or (wColor(b and 0xff) shl 16))

    self.mColorTable.clear
    for name, color in table:
      case color:
      of 0:
        self.mColorTable[name] = towColor(255, 0, 0)
      of 1:
        self.mColorTable[name] = towColor(255, 255, 0)
      of 2:
        self.mColorTable[name] = towColor(0, 255, 0)
      else:
        self.mColorTable[name] = towColor(0, 0, 0)
    self.mRects.clear()
    self.refresh(false)

  proc init*(self: wColorPanel, parent: wWindow, table: OrderedTable[string, int]) =
    wPanel(self).init(parent)
    self.backgroundColor = parent.backgroundColor
    self.setDoubleBuffered(true)
    self.disableFocus(false)

    self.font = Font(8.0, weight=wFontWeightNormal, faceName="Arial Bold")
    self.mBoxSize = (150, 100)
    self.mBoxGap = 10
    self.mRects = initTable[string, wRect]()
    self.mFocusColor = ""
    self.showScrollBar(wVertical, true)
    self.setTable(table)

    self.wEvent_Paint do (): self.onPaint()
    self.wEvent_Size do (): self.refresh(false)
    self.wEvent_ScrollWin do (): self.refresh(false)
    self.wEvent_MouseMove do (event: wEvent): self.onKeyMouse(event)