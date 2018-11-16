const express = require('express')
const logger = require('morgan')
const port = 8080
const server = express();

// best stab at enum for page
const Home = 0
const About = 1
const WebDev = 2
const MartialArts = 3
const Games = 4
const Fetch = 5

let page = Home;

server.set('view-engine', 'ejs')

server.get('/', (request, response) => {
    page = Home
    response.render('index', { page: page })
})

server.get('/about-me.html', (request, response) => {
    page = About
    response.render( 'about', { page: page })
})

server.use( express.static('static') )

