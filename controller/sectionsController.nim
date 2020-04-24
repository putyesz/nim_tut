## Tóth Bence WDFP8X

import mongoDBController
from sequtils import zip
import std/tables
import ../view/sectionsWindow

proc sectionsControll*(): int =
  var sectionsTable = initOrderedTable[string, int]()
  let pairs : seq[(string, int)]= zip(getSectionNames(), getSectionProgress())
  for i in 0..<len(pairs):
    let (a, b) = pairs[i]
    sectionsTable[a] = b

  result = getSectionByTitle(sectionsWindow(sectionsTable))