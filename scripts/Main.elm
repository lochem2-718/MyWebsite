module Main exposing (Model, Msg, init, subscriptions, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (Attribute, Html, a, div, footer, li, text, ul)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Materialize exposing (..)
import Navbar exposing (..)
import Pages.AboutMe as AboutMe
import Pages.Home as Home
import Pages.MartialArts as MartialArts
import Pages.WebDevelopment as WebDevelopment
import Url exposing (Url)
import Url.Parser as UrlParser exposing (Parser)


type alias Model =
    { key : Nav.Key
    , url : Url
    , page : Page
    }


type Msg
    = DoNothing
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url


type Page
    = Home
    | AboutMe
    | MartialArts
    | WebDevelopment


routeParser : Parser (Page -> a) a
routeParser =
    UrlParser.oneOf
        [ UrlParser.map Home <| UrlParser.s "home"
        , UrlParser.map AboutMe <| UrlParser.s "about-me"
        , UrlParser.map MartialArts <| UrlParser.s "martial-arts"
        , UrlParser.map WebDevelopment <| UrlParser.s "web-development"
        , UrlParser.map Home <| UrlParser.top
        ]


view : Model -> Browser.Document Msg
view model =
    { title = "Jared Weinberger"
    , body =
        [ navbar []
            [ navbarButton Home model.page "Home"
            , navbarButton AboutMe model.page "About Me"
            , navbarButton MartialArts model.page "Martial Arts"
            , navbarButton WebDevelopment model.page "Web Development"
            ]
            (Just (centerNavLogo [] [ image [ class "logo", src "./images/logo-no-bg.png" ] [] ]))
        , divider []
        , container [ class "main-content" ]
            [ row []
                [ col []
                    [ case model.page of
                        Home ->
                            Home.view

                        AboutMe ->
                            AboutMe.view

                        MartialArts ->
                            MartialArts.view

                        WebDevelopment ->
                            WebDevelopment.view
                    ]
                ]
            , row []
                [ col []
                    [ footer []
                        [ p [ id "copyright" ] [ text "© Jared Weinberger the Magnificent" ]
                        ]
                    ]
                ]
            ]
        ]
    }


navbarButton : Page -> Page -> String -> Html msg
navbarButton targetPage currentPage content =
    let
        linkPath =
            case targetPage of
                Home ->
                    "/home"

                AboutMe ->
                    "/about-me"

                MartialArts ->
                    "/martial-arts"

                WebDevelopment ->
                    "/web-dev"

        attrs =
            [ href linkPath
            , classList
                [ ( "nav-link", True )
                , ( "nav-item", True )
                , ( "item-active", targetPage == currentPage )
                ]
            ]
    in
    a attrs [ text content ]


urlToPage : Url -> Page
urlToPage url =
    case url.path of
        "/home" ->
            Home

        "/about-me" ->
            AboutMe

        "/martial-arts" ->
            MartialArts

        "/web-dev" ->
            WebDevelopment

        _ ->
            Home


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoNothing ->
            ( model, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( { model | page = urlToPage url }, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url Home, Cmd.none )


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }
