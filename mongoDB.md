MongoDB
$-prefixed conditions and operators in MongoDB https://chatgpt.com/share/68512c73-60dc-8012-9587-33ba543561ec

Read operations
    – find vs findOne:
    .find = return all records. Returns array of documents
    .findOne = returns first matching document. It returns single object

    Select column:
    .findMany({},{ field:1, field:0}); 1 = true, 0 = false
    
    Projection refers to specifying which fields should be included or excluded in the documents returned by a find() query.

Write/Create operations
    – InsertOne vs insertMany
 		.insertOne = insert one record
		.insertMany = inserts morethan one records Eg. .insertMany({}, {}, {})

Update operations
    – updateOne vs updateMany
		Syntax:
			db.<colleaction>.updateMany({field: {$cond: value}},{$set:{ field: value}})
		// It adds new value if not present

Delete operations
    deleteOne vs deleteMany

Embedded/Nested documents
    Document have nested objects:
    Read Syntax: .find( { 'nestedField.childField' :  true} )
    Nested document limit is 16 mb.

Data Types in MongoDB
    Text
    Boolean
    Number: Integer, NumberLong, …
    ObjectId
    ISODate
    Timestamp
    Array
    Emd document


SchemaValidations
    While creating
      db.createCollection("books",		      							 
        validator:{
            $jsonSchema:{
                required: ["name", "price"],
                properties:{
                    name: {
                        bsonType: "string",
                        description: "Must be a string and require"
                    },
                    ... Other-validations
                }
            }
        },
        validationAction: 'error'|'warn'
        })

    While altering
    db.runCommand({										      	 
        collMod: "books",
        validator:{
            $jsonSchema:{
                required: ["name", "price", "author"],
                properties:{
                    name: {
                        bsonType: "string",
                        description: "Must be a string and require"
                    },
                    author:{
                        bsonType: "array",
                   description: "Must be an array and is required",
                   items: {
                       bsonType: 'object',
                       required: ["name", "email"],
                       properties:{
                           email:{
                               bsonType: "string",
                               description: "Email required"
                           }
                        }
                    }
                }
            }
        },
        validationAction: 'error'|'warn'
    })

Write concern:
    Write concern describes the level of acknowledgment requested from MongoDB for write operations to a standalone mongod, replica sets, or sharded clusters.

Atomicity: 
    atomicity means that a transaction (a sequence of operations) is treated as a single, indivisible unit of work. It ensures that either all operations within the transaction are completed successfully, or none of them are.

$exists, $type
    $ exists: it checks whether field is present or not in the document and returns
    $type: checks the type of field 
		Eg. db.college.find({hasMacBook: { $exists: true, $type: 8}}) → 8 is number type of datatype

$expr
    The $expr operator in MongoDB allows you to use aggregation expressions within query operations, enabling more complex comparisons between fields within the same document or using logical and mathematical operations

$text
    The $text operator in MongoDB is used to search the text index. This operator performs text search operations on the collection with a text index.

$elemMatch
    The $elemMatch operator is used to match documents that contain an array field with at least one element that matches all the specified query criteria. 

Sort
    db.teachers.find().sort({ field_1: 1, field_2: -1 });
    1 = asc, -1 = desc 

Advanced update operator
    $inc - increment value by the provided num
        d.collection.find({}, {$inc: { age: 2 } })
    $unset - to remove field from document
    $rename - to rename field name in document
    $upsert - 'upsert' is a blend of 'update' and 'insert'. It denotes an operation in MongoDB that updates an existing document, or if the document doesn't exist, inserts a new one. 
        db.collection.updateOne({name:”golu”}, { $set: { age: 1 }, { upsert: true }} )

Array update methods
    $push - it used to push an object in array field
    Eg. db.collection.updateOne({name:”ram”}, { $push: { experience: { field: value } } } );
    $addToSet - it pushes the object into the array if not present with the same values. No redundancy  
    $pull - it removes object from array which are matching 
    $pop - it removes object from start or end based on value → 1 = from end, -1 = from start

Indexing
    Indexing is a mechanism to improve the performance of search queries in a MongoDB collection. Just like the index of a book helps you find a topic quickly, a MongoDB index helps find documents faster, without scanning the entire collection.
    Issue: 
        When there is no index, MongoDB must perform a collection scan:
        MongoDB checks every single document in the collection.
        It compares the query condition against each document.
    How solves issue:
        With an index, MongoDB builds a sorted data structure (B-tree) that allows:
        Queries jump directly to relevant documents.
        No need to scan the whole collection. Eg. db.users.createIndex({ email: 1 }); 1 = asce order
    It stores: 1. Index keys and Pointers to documents in collection
    Trade-off - 
        Storage space
        Write performance - because it writes every record separately in the index + collection
    partialFilterExpression is used to add a condition to the index.
        Eg. db.collection.createIndex({ age:1}, {partialFilterExpression : { age: {$gt: 22 }}})

In the case of an index on an array field. MongoDB will create seperate index entry for each value in the array.

Winning plan:
    — In case of multiple indexes on the same field
    In MongoDB, the Winning Plan refers to the query plan that the query optimizer chooses to execute among multiple possible strategies for a given query.
    It checks a better index on the first query and stores it in the cache. And the second time it does not compare between two indexes. It takes directly from the cache.

Text index:
    Supports full-text search on string content. It enables queries that can search for words within string fields.
    – Single text index per collection
    – Tokenization - Input strings are split into tokens (words), removing most punctuation. For example, "hello world!" becomes ["hello", "world"].
    – stemming - Words are reduced to their base/root form. For example, "running", "runs" → "run". This helps match different variations of a word.

Aggregate queries
    An aggregate query in MongoDB is used to process data records and return computed results.
    It uses a pipeline of stages, where each stage transforms the data and passes it to the next.
    
    Pipeline : A pipeline is a sequence of stages (operations), where each stage transforms the documents it receives.
    db.collection.aggregate(pipeline, options); pipeliane = [{ $_id:$”$column”}, { field: expression} ….]
    Expression is condition which you want to apply
    Eg. db.students.aggrerate([{ $group: { _id:”$age”, array:{ $push:  “$$ROOT” }}}]) $$ROOT = referet to whole document.
    
    $filter: Used to add condition while using $group
    Eg. $filter:{ input: field, as: identifier, con: expression }

$bucket
    The $bucket stage in MongoDB’s aggregation pipeline is used to group documents into buckets based on a range of values — like a histogram. Think of $bucket as "range-based grouping", where you manually define the boundaries of the buckets.
    Syntax. 
        {
            $bucket: {
                groupBy: <expression>,       // Field or computed expression to group by
                boundaries: [ <val1>, <val2>, ..., <valN> ],  // Sorted list of bucket edges
                default: "Other",            // (Optional) Bucket for out-of-range values
                output: {
                <field1>: { <accumulator> },
                ...
                }
            }
        }

    Example
    db.orders.aggregate([
        {
            $bucket: {
            groupBy: "$amount",
            boundaries: [0, 100, 500, 1000],
            default: "Other",
            output: {
                count: { $sum: 1 },
                avgAmount: { $avg: "$amount" }
            }
            }
        }
    ])


	

$lookup
    The $lookup stage in MongoDB is used to perform a left outer join between documents in one collection with documents in another collection (or the same collection).

Syntax
    db.orders.aggregate([
        {
            $lookup: {
            from: "customers",
            localField: "customerId",
            foreignField: "_id",
            as: "customerInfo"
            }
        }
    ])

Example
    db.orders.aggregate([
        {
            $bucket: {
            groupBy: "$amount",
            boundaries: [0, 100, 500, 1000],
            default: "Other",
            output: {
                count: { $sum: 1 },
                avgAmount: { $avg: "$amount" }
            }
            }
        }
    ])

Example
    db.orders.aggregate([
        {
            $lookup: {
                from: "customers",
                localField: "customerId",
                foreignField: "_id",
                as: "customerInfo"
            }
        }
    ])


Replication
    In MongoDB, replication is the process of synchronizing data across multiple servers, and replicas are the copies of the same data stored on different MongoDB instances.
    MongoDB uses Replica Sets for high availability and data redundancy.
    Comannd to create replica db
    Sudo mongod –port  27018 –dbpath <your-mongodb-path> –replSet <replica-set-id>

    rs.initiate({
    _id: "rs0",
    members: [
        { _id: 0, host: "mongo1:27017" },
        { _id: 1, host: "mongo2:27017" },
        { _id: 2, host: "mongo3:27017", arbiterOnly: true }
    ]
    })


    Bydefault secondary dbs don’t have read access also so you will get error “ not master and slaveOk=false - to solve issue use below steps

    Use admin - switch to admin
    db.getMongo().setSlaveOk()

Sharding
    Sharding is MongoDB's approach to horizontal scaling, where data is distributed across multiple servers (called shards) to handle large data volumes and high throughput.
    Enable sharding on db - sh.enableSharding("myDB")
    Shard the collection - sh.shardCollection("myDB.users", { userId: 1 })

Transactions
    Transactions in MongoDB allow you to group multiple read and write operations into a single atomic unit. This means either all operations succeed, or none are applied, just like in SQL databases.
    Phases:
        Create transaction:
        const session = await mongoose.startSession();

    Operations:
        session.startTransaction();
        Let customer = db.getDatabase(“db-name”).<collection-name>
        customer.updateOne({Id:’122’, {$inc::{ bal:  -200 }});
        customer.updateOne({Id:’123’, {$inc::{ bal:  200 }});

    Commit phase/abort phase:
        Commit: in then - session.commitTransaction(); – It will addd changes in DB
        Abort: in catch - session.abortTransaction(); –  If error got abort whole transaction
        Finally – session.endSession();
