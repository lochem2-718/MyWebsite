const express = require('express')
const logger = require('morgan')
const expressLayouts = require('express-ejs-layouts')
const port = 8080
const server = express();

const pagePaths = {
    home: 'home',
    aboutMe: 'about-me',
    webDev: 'web-dev',
    martialArts: 'martial-arts',
    games: 'games',
    fetch: 'fetch',
    form: 'form'
}


function initServer( server )
{
    server.set( 'view engine', 'ejs' )
    server.use( expressLayouts )
    server.use( express.static('static') )

    handleRouting( server )

    server.listen( port )
}


function handleRouting( server )
{
    server.get( '/', ( request, response ) => renderHome( response ) )
    server.get( '/index.html', ( request, response ) => renderHome( response ) )
    server.get( '/about-me.html', (request, response ) => renderAboutMe( response ) )
    server.get( '/web-dev.html', ( request, response ) => renderWebDev( response ) )
    server.get( '/martial-arts.html', ( request, response ) => renderMartialArts( response ) )
    server.get( '/games.html', ( request, response ) => renderGames( response ) )
    server.get( '/fetch.html', ( request, response ) => renderFetch( response ) )
    server.get( '/form.html', ( request, response ) => renderForm( response ) )
}


function renderHome( response )
{
    response.render( pagePaths.home, { page: 'home' })
}

function renderAboutMe( response )
{
    response.render( pagePaths.aboutMe, { page: 'about-me' })
}

function renderWebDev( response )
{
    response.render( pagePaths.webDev, { page: 'web-dev' })
}

function renderMartialArts( response )
{
    response.render( pagePaths.martialArts, { page: 'martial-arts' })
}

function renderGames( response )
{
    response.render( pagePaths.games, { page: 'games' })
}

function renderFetch( response )
{
    response.render( pagePaths.fetch, { page: 'fetch'})
}

function renderForm( response )
{
    response.render( pagePaths.form, { page: 'form' })
}

initServer( server )