import asyncdispatch  ## Nim async-supportive functions here
import oids

import nimongo/bson   ## MongoDB BSON serialization/deserialization
import nimongo/mongo  ## MongoDB client

## Create new Mongo client
var m: AsyncMongo = newAsyncMongo().slaveOk(false)  ## Still Mongo type

## Connect to Mongo server with asynchronous socket
let connected = waitFor(m.connect())

## Testing connection establishing result
echo "Async connection established: ", connected

## Inserting single document into MongoDB
waitFor(m.insert(B("hello-async", "victory")))

## Inserting multiple documents into MongoDB
let
  doc1 = %*{"doc1": 15}
  doc2 = %*{"doc2": "string"}

waitFor(m.insert(@[doc1, doc2]))

## Removing single document from MongoDB
waitFor(m.remove(B("doc1", 15), limit=1))

## Removing multiple documents from MongoDB
waitFor(m.remove(B("doc1", 15)))