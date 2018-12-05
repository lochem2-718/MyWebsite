const express = require('express')
const bodyParser = require('body-parser')
const logger = require('morgan')
const expressLayouts = require('express-ejs-layouts')
const port = 8080
const server = express();
const DAL = require('./DAL')

const pagePaths = {
    base: '/',
    home: '/index.html',
    aboutMe: '/about-me.html',
    webDev: '/web-dev.html',
    martialArts: '/martial-arts.html',
    games: '/games.html',
    fetch: '/fetch.html',
    form: '/forms/form.html',
    responseOk: '/forms/response/ok.html',
    formSubmissions: '/forms/all-submissions.html'
}


function initServer( server )
{
    server.set( 'view engine', 'ejs' )
    server.use( expressLayouts )
    server.use( express.static('static') )
    server.use( bodyParser.urlencoded({ extended: true }) )

    server.locals.title = 'Jared Weinberger'
    server.locals.email = 'nonOfYourBusiness@mail.org'
    server.locals.pagePaths = pagePaths

    handleRouting( server )
    handleForm( server )

    server.listen( port )
}


function handleRouting( server )
{
    server.get( pagePaths.base, ( request, response ) => renderHome( response ) )
    server.get( pagePaths.home, ( request, response ) => renderHome( response ) )
    server.get( pagePaths.aboutMe, (request, response ) => renderAboutMe( response ) )
    server.get( pagePaths.webDev, ( request, response ) => renderWebDev( response ) )
    server.get( pagePaths.martialArts, ( request, response ) => renderMartialArts( response ) )
    server.get( pagePaths.games, ( request, response ) => renderGames( response ) )
    server.get( pagePaths.fetch, ( request, response ) => renderFetch( response ) )
    server.get( pagePaths.form, ( request, response ) => renderForm( response ) )
    server.get( pagePaths.responseOk, ( request, response ) => renderOk( response ) )
    server.get( pagePaths.formSubmissions, ( request, response ) => renderSubmissions( response, DAL.readAllFools() ) )
}

function handleForm( server )
{
    server.post( '/forms', ( request, response ) => {
        let ipAdress = request.ip

        let formData = {
            firstname: request.body.firstname,
            lastname: request.body.lastname,
            email: request.body.email,
            phone: request.body.phone,
            password: request.body.password,
            ssn: request.body.ssn,
            credit: request.body.credit,
            bio: request.body.bio,
            senate: request.body.senate,
            isHaxor: request.body.isUltimateHaxxor === 'on',
            isInsane: request.body.isInsane === 'on'
        }

        let emailRegex = /\w+@\w+.\w+/
        let numberRegex = /[0-9]+/
        let validFields = {
            firstname: Boolean( formData.firstname ),
            lastname: Boolean( formData.lastname ),
            email: emailRegex.test( formData.email ),
            phone: numberRegex.test( formData.phone ),
            password: formData.password ? formData.password.length >= 8 : false,
            ssn: formData.ssn ? numberRegex.test( formData.ssn ) && formData.ssn.length === 9 : false,
            credit: formData.credit ? numberRegex.test( formData.credit ) && formData.credit.length === 16 : false,
            bio: Boolean( formData.bio )
        }

        if( validFields.firstname 
         && validFields.lastname
         && validFields.email
         && validFields.phone
         && validFields.password
         && validFields.ssn
         && validFields.credit
         && validFields.bio )
        {
            DAL.createFool( formData )
            response.redirect( pagePaths.responseOk )
        }
        else
        {
            renderForm( response, formData, validFields )
        }
        
    } )
}

function renderHome( response )
{
    response.render( 'home', { page: 'home' })
}

function renderAboutMe( response )
{
    response.render( 'about-me', { page: 'about-me' })
}

function renderWebDev( response)
{
    response.render( 'web-dev', { page: 'web-dev' })
}

function renderMartialArts( response )
{
    response.render( 'martial-arts', { page: 'martial-arts' })
}

function renderGames( response )
{
    response.render( 'games', { page: 'games' })
}

function renderFetch( response )
{
    response.render( 'fetch', { page: 'fetch'})
}

function renderForm( response, formData = {}, validFields = {
    firstname: true,
    lastname: true,
    email: true,
    phone: true,
    password: true,
    ssn: true,
    credit: true,
    bio: true
} )
{
    response.render( 'forms/form', { 
        page: 'form',
        formData: formData,
        validFields: validFields
    } )
}

function renderOk( response )
{
    response.render( 'forms/form-response-ok' )
}

function renderSubmissions( response, fools )
{
    console.log('-------------------------------------------------------------------------')
    console.log( 'fools:' )
    console.log( fools )
    console.log('-------------------------------------------------------------------------')
    response.render( 'forms/all-submissions', {
        page: 'submissions',
        fools: fools ? fools : []
    } )
}
initServer( server )