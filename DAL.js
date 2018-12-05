exports.createFool = createFool
exports.readFool = readFool
exports.readAllFools = readAllFools
exports.updateFool = updateFool
exports.deleteFool = deleteFool

const sqlite3 = require('sqlite3').verbose()
const dbPath = './db/misc.db'

function initDb()
{
    const database = new sqlite3.Database( dbPath, ( error ) => logErrorIfExists( error, 'Successfully connected to misc.db' ) )
    
    let createFormDataTable = 
        'CREATE TABLE IF NOT EXISTS Fools ' +
            '( id INTEGER NOT NULL PRIMARY KEY' +
            ', firstname nvarchar(50) NOT NULL' +
            ', lastname nvarchar(50) NOT NULL' +
            ', email nvarchar(80) NOT NULL' +
            ', phone nvarchar(20) NOT NULL' +
            ', password TEXT NOT NULL' +
            ', ssn TEXT NOT NULL' +
            ', credit TEXT NOT NULL' +
            ', bio TEXT NOT NULL' +
            ', senate INTEGER NOT NULL' +
            ', isHaxor INTEGER NOT NULL' +
            ', isInsane INTEGER NOT NULL ' +
            ');'
    database.exec( createFormDataTable, ( error ) => logErrorIfExists( error, 'Successfully created formData table' ) )
    
    return database
}

function closeDb( database )
{
    database.close( ( error ) => logErrorIfExists( error, 'Successfully closed misc.db' ) )
}

// fool CRUD
function createFool( fool )
{
    const database = initDb()
    let foolId = null
    const command = 
        'INSERT INTO Fools ' +
            '( firstname' +
            ', lastname' +
            ', email' +
            ', phone' +
            ', password' +
            ', ssn' +
            ', credit' +
            ', bio' +
            ', senate' +
            ', isHaxor' +
            ', isInsane ' +
            ') ' +
        'VALUES ' +
            '( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? );'
    database.run( command,
        [ fool.firstname
        , fool.lastname
        , fool.email
        , fool.phone
        , fool.password
        , fool.ssn
        , fool.credit
        , fool.bio
        , fool.senate
        , fool.isHaxor ? 1 : 0
        , fool.isInsane ? 1 : 0
        ],
        logErrorIfExists )
    
    database.get('SELECT last_insert_rowid();', ( error, rowId ) => {
        logErrorIfExists( error )
        if( ! error )
        {
            foolId = rowId
        }
    } )
    
    closeDb( database )

    return foolId
}

function readFool( formDataId )
{
    const database = initDb()
    const query = 'SELECT * FROM Fools WHERE id=?;'
    let fool = null
    database.get( query, [ formDataId ], ( error, row ) => {
        logErrorIfExists( error )
        if( ! error )
        {
            fool = row
        }
    } )
    closeDb( database )

    return dbFoolToJsFool( fool )
}

function readAllFools()
{
    const database = initDb()
    const query = 'SELECT * FROM Fools;'
    let fools = null
    database.all( query , [], ( error, rows ) => {
        logErrorIfExists( error )
        if( !error )
        {
            fools = rows
            console.error( fools )
        }
    } )

    closeDb( database )
    return fools ? fools.map( dbFoolToJsFool ) : null
}

function updateFool( foolId, updatedFool )
{
    const database = initDb()
    const command = 'UPDATE Fools ' +
                        'SET firstname = ?' +
                        ', lastname = ?' +
                        ', email = ?' +
                        ', phone = ?' +
                        ', password = ?' +
                        ', ssn = ?' +
                        ', credit = ?' +
                        ', bio = ?' +
                        ', senate = ?' +
                        ', isHaxor = ?' +
                        ', isInsane = ?' +
                        'WHERE id = ?;'
    database.run( command,
        [ updatedFool.firstname
        , updatedFool.lastname
        , updatedFool.email
        , updatedFool.phone
        , updatedFool.password
        , updatedFool.ssn
        , updatedFool.credit
        , updatedFool.bio
        , updatedFool.senate
        , updatedFool.isHaxor ? 1 : 0
        , updatedFool.isInsane ? 1 : 0
        , foolId
        ],
        logErrorIfExists )
    
    closeDb( database )

    return foolId
}

function deleteFool( formId )
{
    const database = initDb()
    const query = 'DELETE FROM Fools WHERE id=?;'
    const fool = readForm( formId );
    database.run( query, [ formId ], logErrorIfExists )

    closeDb( database )
    return dbFoolToJsFool( fool )
}

function dbFoolToJsFool( dbFool )
{
    dbFool.isHaxor = dbFool.isHaxor === 1
    dbFool.isInsane = dbFool.isInsane === 1
    return dbFool
}

function logErrorIfExists( error, successMessage = null )
{
    if( error )
    {
        console.log( error )
    }
    else if( successMessage )
    {
        console.log( successMessage )
    }
}
