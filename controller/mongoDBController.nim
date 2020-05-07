## Tóth Bence WDFP8X

import mongopool, bson

connectMongoPool("mongodb://localhost/nim_tut")
var db = getNextConnection()

var secLen = db.find("sections").returnMany().len()

proc getSection(order : int) : Bson =
  ## Gets a whole section from the db, returns a Bson object
  ## /usage: getSection(n: int (0 - 10))/
  result = @@{}
  if order >= 0 and order < secLen:
    result = db.find("sections", @@{"order": order}).returnOne()
  else:
    result = @@{}
    echo "Could not load Section!"

proc getSectionByTitle*(title : string) : int =
  ## Returns a Section by the given title
  ## /usage getSectionByTitle(s: string)/
  if title != "-1":
    result = db.find("sections", @@{"title": title}).returnOne()["order"]
  else:
    result = -1


proc getSectionNames*() : seq[string] =
  ## Gets every sections title,
  ## returns with a sequence
  ## /usage: getSectionsNames()/
  var s = db.find("sections").returnMany()
  for i in 0..<len(s):
    result.add(s[i]["title"])

proc getSectionProgress*() : seq[int] =
  ## Gets every sections title,
  ## returns with a sequence
  ## /usage: getSectionsNames()/
  var s = db.find("sections").returnMany()
  for i in 0..<len(s):
    result.add(s[i]["progress"])



proc getSectionNamesAndProgress*() : seq[tuple[sectionName: string, sectionProgress: int]] =
  ## Gets every sections title,
  ## returns with a sequence
  ## /usage: getSectionsNames()/
  var s = db.find("sections").returnMany()
  for i in 0..<len(s):
    var name: string
    var num: int
    name = $s[i]["title"]
    num = s[i]["progress"]
    var myTuple : tuple[sectionName: string, sectionProgress: int] = (name, num)
    result.add(myTuple)



proc getTitle(section: Bson) : string =
  ## Returns a Sections title
  ## /usage getTitle(getSection(n: int(0 - 10)))/
  result = section["title"]

proc getTitle*(order: int) : string =
  ## Returns the orderth Sections title
  ## /usage getTitle(n: int(0 - 10))/
  if order < secLen and order >= 0:
    result = getTitle(getSection(order))
  else:
    result = ""
    echo "Could not load Title!"



proc getTexts(section : Bson) : seq[string] =
  ## Converts a section Bson input to sequence of texts
  ## /usage: getTexts(getSection(n: int (0 - 10)))/
  for i in 0..<len(section["texts"]):
    result.add(section["texts"][i])

proc getTexts*(order : int) : seq[string] =
  ## Converts a section Bson input to sequence of texts
  ## /usage: getTexts(n: int (0 - 10))/
  if order >= 0 and order < secLen:
    result = getTexts(getSection(order))
  else:
    result = @[]
    echo "Could not load Texts!"


proc hasExercise*(section : int) : bool =
  if "exercises" in getSection(section):
    result = true
  else:
    result = false


proc getExercises(section : Bson) : seq[tuple[exercise: string, inputType: string, answer: string]] =
  ## Gets the exercises from the section, returns a tuple with all the necessary informations
  ## /usage getExercises(getSection(n : int (0 - 10)))/
  type returnExercise = tuple[exercise: string, inputType: string, answer: string]
  for ex in 0..<len(section["exercises"]):
    var n, t, a : string
    n = section["exercises"][ex]["exercise"]
    t = section["exercises"][ex]["type"]
    a = section["exercises"][ex]["answer"]
    let exer : returnExercise = (n, t, a)
    result.add(exer)

proc getExercises*(order : int) : seq[tuple[exercise: string, inputType: string, answer: string]] =
  ## Gets the exercises from the section, returns a tuple with all the necessary informations
  ## /usage getExercises(n : int (0 - 10))/
  if order > 1 and order < secLen:
    result = getExercises(getSection(order))
  else:
    result = @[]



proc setProgress*(sectionNumber: int, value: int)=
  let section = getSection(sectionNumber)
  section["progress"] = value
  var update = db.replaceOne("sections", @@{"_id": section["_id"]}, section)

releaseConnection(db)