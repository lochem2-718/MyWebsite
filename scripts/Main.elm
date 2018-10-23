module Main exposing (Model, Msg, init, subscriptions, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (Attribute, Html, a, div, footer, li, text, ul)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Materialize exposing (..)
import Navbar exposing (..)
import Pages.AboutMe as AboutMe
import Pages.Games as Games
import Pages.Home as Home
import Pages.MartialArts as MartialArts
import Pages.WebDevelopment as WebDevelopment
import Url exposing (Url)
import Url.Parser as UrlParser exposing (Parser)


type alias Model =
    { key : Nav.Key
    , url : Url
    , pageModel : PageModel
    }


type Msg
    = DoNothing
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url
    | PageMessage PageMsg


type PageMsg
    = GamesMsg Games.Msg


type PageModel
    = Home Home.Model
    | AboutMe AboutMe.Model
    | MartialArts MartialArts.Model
    | WebDevelopment WebDevelopment.Model
    | Games Games.Model


routeParser : Parser (PageModel -> a) a
routeParser =
    UrlParser.oneOf
        [ UrlParser.map Home <| UrlParser.s "home"
        , UrlParser.map AboutMe <| UrlParser.s "about-me"
        , UrlParser.map MartialArts <| UrlParser.s "martial-arts"
        , UrlParser.map WebDevelopment <| UrlParser.s "web-development"
        , UrlParser.map Games <| UrlParser.s "games"
        ]


view : Model -> Browser.Document Msg
view model =
    { title = "Jared Weinberger"
    , body =
        [ navbar []
            { fixed = False
            , extended = False
            , logo =
                logo [ class "logo" ]
                    Left
                    [ image [ class "logo-image", src "./images/logo-no-bg.png" ] []
                    , div [ class "logo-text" ] [ text <| nbsb ++ "Jared Weinberger" ]
                    ]
            , items =
                { position = Right
                , contents =
                    List.map (link [])
                        [ navbarButton Home model.page "Home"
                        , navbarButton AboutMe model.page "About Me"
                        , navbarButton MartialArts model.page "Martial Arts"
                        , navbarButton WebDevelopment model.page "Web Development"
                        , navbarButton Games model.page "Games"
                        ]
                }
            }
        , container [ class "main-content" ]
            [ row []
                [ col []
                    [ case model.pageModel of
                        Home mdl ->
                            Home.view mdl

                        AboutMe mdl ->
                            AboutMe.view mdl

                        MartialArts mdl ->
                            MartialArts.view mdl

                        WebDevelopment mdl ->
                            WebDevelopment.view mdl

                        Games mdl ->
                            Games.view mdl
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


navbarButton : PageModel -> PageModel -> String -> Html msg
navbarButton targetPage currentPage content =
    let
        linkPath =
            case targetPage of
                Home _ ->
                    "/#home"

                AboutMe _ ->
                    "/#about-me"

                MartialArts _ ->
                    "/#martial-arts"

                WebDevelopment _ ->
                    "/#web-dev"

                Games _ ->
                    "/#games"

        attrs =
            [ href linkPath
            , classList
                [ ( "nav-link", True )
                , ( "link-active", targetPage == currentPage )
                ]
            ]
    in
    a attrs [ text content ]


urlToPage : Url -> PageModel
urlToPage url =
    case url.fragment of
        Just "about-me" ->
            AboutMe

        Just "martial-arts" ->
            MartialArts

        Just "web-dev" ->
            WebDevelopment

        Just "games" ->
            Games

        _ ->
            Home


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoNothing ->
            ( model, Cmd.none )

        PageMessage pageMsg ->
            case pageMsg of
                GamesMsg msg_ ->
                    let
                        ( gamesModel, gamesCmd ) =
                            Games.update msg_ model.pageModel
                    in
                    ( { model | pageModel = GamesMsg gamesModel }, gamesCmd )

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
    let
        ( homeModel, homeCmd ) = 
            Home.init
    in
    
    ( Model key url Home, homeCmd )


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
