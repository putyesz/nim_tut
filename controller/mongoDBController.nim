## Tóth Bence WDFP8X

import mongopool, bson

connectMongoPool("mongodb://localhost/nim_tut")
var db = getNextConnection()


proc getSection*(order : int) : Bson =
  ## Gets a whole section from the db, returns a Bson object /usage: getSection(n: int (0 - 10))/
  result = db.find("sections", @@{"order": order}).returnOne()



proc getSectionNames*() : seq[string] =
  ## Gets every sections title, returns with a sequence /usage: getSectionsNames()/
  var s = db.find("sections").returnMany()
  for i in 0..<len(s):
    result.add(s[i]["title"])



proc getSectionNamesAndProgress*() : seq[tuple[sectionName: string, sectionProgress: int]] =
  ## Gets every sections title, returns with a sequence /usage: getSectionsNames()/
  var s = db.find("sections").returnMany()
  for i in 0..<len(s):
    var name: string
    var num: int
    name = $s[i]["title"]
    num = s[i]["progress"]
    var myTuple : tuple[sectionName: string, sectionProgress: int] = (name, num)
    result.add(myTuple)



proc getTitle*(section: Bson) : string =
  result = section["title"]

proc getTitle*(n: int) : string =
  result = getTitle(getSection(n))



proc getTexts*(section : Bson) : seq[string] =
  ## Converts a section Bson input to sequence of texts /usage: getTexts(getSection(n: int (0 - 10)))/
  for i in 0..<len(section["texts"]):
    result.add(section["texts"][i])

proc getTexts*(order : int) : seq[string] =
  ## Converts a section Bson input to sequence of texts /usage: getTexts(n: int (0 - 10))/
  result = getTexts(getSection(order))



proc getExercises*(section : Bson) : seq[tuple[exercise: string, inputType: string, answer: string]] =
  ## Gets the exercises from the section, returns a tuple with all the necessary informations /usage getExercises(getSection(n : int (0 - 10)))/
  type returnExercise = tuple[exercise: string, inputType: string, answer: string]
  for ex in 0..<len(section["exercises"]):
    var n, t, a : string
    n = section["exercises"][ex]["exercise"]
    t = section["exercises"][ex]["type"]
    a = section["exercises"][ex]["answer"]
    var exer : returnExercise = (n, t, a)
    result.add(exer)


proc getExercises*(order : int) : seq[tuple[exercise: string, inputType: string, answer: string]] =
  ## Gets the exercises from the section, returns a tuple with all the necessary informations /usage getExercises(n : int (0 - 10))/
  result = getExercises(getSection(order))



releaseConnection(db)