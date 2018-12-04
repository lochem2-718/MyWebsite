module.exports = {
    DAL: function()
    {
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
        this.createFool = function( fool )
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
            
            closeDb()
        
            console.log( database )
        
            return foolId
        }
        
        this.readFool = function( formDataId )
        {
            const database = initDb()
            const query = 'SELECT * FROM Fools WHERE id=?;'
            let fool = null
            database.get( query, [ formDataId ], ( error, row ) => {
                logErrorIfExists( error )
                if( ! error )
                {
                    console.log( row )
                    fool = row
                }
            } )
            closeDb()
        
            return dbFoolToJsFool( fool )
        }
        
        this.readAllFools = function()
        {
            const database = initDb()
            const query = 'SELECT * FROM Fools;'
            let fools = null;
        
            database.all( query, ( error, rows ) => {
                logErrorIfExists( error )
                if( !error )
                {
                    console.log( rows )
                    fools = rows
                }
            } )
        
            fools.map( dbFoolToJsFool )
        
            closeDb()
            return fools
        }
        
        this.updateFool = function( foolId, updatedFool )
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
                , foolId
                ],
                logErrorIfExists )
            
            closeDb()
        
            console.log( database )
        
            return foolId
        }
        
        this.deleteFool = function( formId )
        {
            const database = initDb()
            const query = 'DELETE FROM Fools WHERE id=?;'
            const fool = readForm( formId );
            database.run( query, [ formId ], logErrorIfExists )
        
            closeDb()
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
    }
}