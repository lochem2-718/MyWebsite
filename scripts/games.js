import { Timer } from "./Timer.mjs";

// global variables

const rows = 5;
const cols = 5;
let boardArray;
let timer = new Timer();
let timerDisplayJob = 0;

setup();

function setup()
{
    let startButtons = document.getElementsByClassName( "start-button" );
    startButtons[ 0 ].addEventListener( "click", startGame );
    startButtons[ 1 ].addEventListener( "click", startGame );
    let b = document.getElementById( "popup-button" );
    b.addEventListener( "click", function() {
        document.querySelector( ".popup" ).classList.toggle( "popup-active" )
    } );
}

// view change

function renderBoard()
{
    let boardContainer = getBoardContainer();
    let box;
    removeAllChildren( boardContainer );
    for( let row = 0; row < rows; row++ )
    {
        for ( let col = 0; col < cols; col++ )
        {
            box = createSquare( row, col, boardArray[ row ][ col ] );
            boardContainer.appendChild( box );
            box.addEventListener( "click", boardClicked );
        }
    }
}

function getBoardContainer()
{
    return document.getElementById( "board-container" );
}

function createSquare( row, col, on = true )
{
    let div = document.createElement( "div" );
    div.classList.add( "square" );
    if( on )
    {
        div.classList.add( "on" );
    }
    div.id = `${row}-${col}`;
    return div;
}

function removeAllChildren( node )
{
    while( node.firstChild )
    {
        node.firstChild.remove();
    }
}

// update

function boardClicked( event )
{
    let box = event.target;
    let [ row, col ] = idToCoords( box.id );
    lightsOutToggle( row, col );
    renderBoard();
    if( isGameWon() )
    {
        let popup = document.querySelector( ".popup" );
        let time = document.getElementById( "popup-time" );
        let gameBoard = document.getElementById( "board-container" );
        timer.stop();
        time.innerHTML = minsSecsToString( timer.minutes, timer.seconds );
        popup.classList.toggle( "popup-active" );
        gameBoard.classList.toggle( "disabled" );
        
    }
}

function isGameWon()
{
    let numberOfOnCells = 
        boardArray
            .flat()
            .filter( ( item ) => item )
            .length;
    return numberOfOnCells === 0;
}

function lightsOutToggle( row, col )
{
    toggle( row, col );
    toggle( row + 1, col );
    toggle( row, col + 1 );
    toggle( row - 1, col );
    toggle( row, col - 1 );
}

function toggle( row, col )
{
    if( row < rows && row >= 0 && col < cols && col >= 0 )
    {
        boardArray[ row ][ col ] = !boardArray[ row ][ col ];
    }
}

function idToCoords( id )
{
    let idArray = id.split( "-" );
    let row = parseInt( idArray[ 0 ] );
    let col = parseInt( idArray[ 1 ] );
    return [ row, col ];
}

function startGame()
{
    document.getElementById( "board-container" ).classList.remove( "disabled" );
    initBoardArray();
    renderBoard();
    startTimer();
}

function initBoardArray()
{
    boardArray = [];
    for( let row = 0; row < rows; row++ )
    {
        boardArray[ row ] = [];
        for( let col = 0; col < cols; col++ )
        {
            boardArray[ row ][ col ] = true;
        }
    }

    for( let randMoveCount = 3; randMoveCount > 0; randMoveCount-- )
    {
        lightsOutToggle( getRandomIndex(), getRandomIndex() );
    }
}

function startTimer()
{
    if( timerDisplayJob !== 0 )
    {
        window.clearInterval( timerDisplayJob );
        timerDisplayJob = 0;
    }
    timer.start();
    timerDisplayJob = window.setInterval( 
        function() {
            let timerElement = document.getElementById( "timer" );
            timerElement.innerHTML = minsSecsToString( timer.minutes, timer.seconds );
        }
    , 1000 );
}

function minsSecsToString( minutes, seconds )
{
    let minString;
    let secString;
    if( minutes < 10 )
    {
        minString = "0" + minutes;
    }
    else
    {
        minString = "" + minutes;
    }
    if( seconds < 10 )
    {
        secString = "0" + seconds;
    }
    else
    {
        secString = "" + seconds;
    }
    return minString + ":" + secString;
}

function getRandomIndex()
{
    return Math.floor( Math.random() * 5 );
}