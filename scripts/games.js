// global variables
const rows = 5
const cols = 5

initGame()

// view change

function renderBoard( boardArray )
{
    let boardContainer = document.getElementById("board-container")
    removeAllChildren( boardContainer )
    for( let row = 0; row < rows; row++ )
    {
        for ( let col = 0; col < cols; col++ )
        {
            boardContainer.appendChild( createSquare( row, col, boardArray[ row ][ col ] ) )
        }
    }
}

function createSquare( row, col, on = true )
{
    let div = document.createElement( "div" )
    div.classList.add( "square" )
    if( on )
    {
        div.classList.add( "on" )
    }
    div.id = `${row}-${col}`
    return div
}

function removeAllChildren( node )
{
    while( node.firstChild != null )
    {
        node.firstChild.remove();
    }
}


// update

function boardClicked( event, boardArray )
{
    let box = event.target
    let [ row, col ] = idToCoords( box.id )
    lightsOutToggle( boardArray, row, col )
    renderBoard( boardArray )
}

function lightsOutToggle( boardArray, row, col )
{
    if( row < rows && col < cols )
    {
        boardArray[ row ][ col ] = !boardArray[ row ][ col ]
    }
    if( row + 1 < rows && col < cols )
    {
        boardArray[ row + 1 ][ col ] = !boardArray[ row + 1 ][ col ]
    }
    if( row - 1 < rows && col < cols )
    {
        boardArray[ row - 1 ][ col ] = !boardArray[ row - 1 ][ col ]
    }
    if( row < rows && col + 1 < cols )
    {
        boardArray[ row ][ col + 1 ] = !boardArray[ row ][ col + 1 ]
    }
    if( row < rows && col - 1 < cols )
    {
        boardArray[ row ][ col - 1 ] = !boardArray[ row ][ col - 1 ]
    }
}

function idToCoords( id )
{
    return id.split( "-" ).map( parseInt )
}

function initGame()
{
    let boardArray = initBoardArray()
    renderBoard( boardArray )
}

initBoardArray()
{
    let boardArray = new Array()
    for( let row = 0; row < rows; row++ )
    {
        for( let col = 0; col < cols; col++ )
        {
            boardArray[ row ][ col ] = true
        }
    }

    for( let randMoveCount = 3; randMoveCount > 0; randMoveCount-- )
    {
        lightsOutToggle( boardArray, getRandomIndex(), getRandomIndex() )
    }
    return boardArray
}

function getRandomIndex()
{
    Math.floor( Math.random() * 5 )
}