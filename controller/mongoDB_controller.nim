#Tóth Bence WDFP8X
import asyncdispatch  ## Nim async-supportive functions here
import oids

import nimongo/bson   ## MongoDB BSON serialization/deserialization
import nimongo/mongo  ## MongoDB client

## Create new Mongo client
var m: Mongo = newMongo(host="localhost", port=27017)  ## Still Mongo type

## Connect to Mongo server with asynchronous socket
let connected = m.connect()

## Testing connection establishing result
echo "Connection established: ", connected

## Inserting single document into MongoDB
m.insert()

## Inserting multiple documents into MongoDB
let
  doc1 = %*{"doc1": 15}
  doc2 = %*{"doc2": "string"}

waitFor(m.insert(@[doc1, doc2]))

## Removing single document from MongoDB
waitFor(m.remove(B("doc1", 15), limit=1))

## Removing multiple documents from MongoDB
waitFor(m.remove(B("doc1", 15)))