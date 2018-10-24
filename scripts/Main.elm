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
    , page : Page
    }


type Msg
    = DoNothing
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url
    | HomeMsg Home.Msg
    | AboutMeMsg AboutMe.Msg
    | MartialArtsMsg MartialArts.Msg
    | WebDevelopmentMsg WebDevelopment.Msg
    | GamesMsg Games.Msg

type Page
    = Home Home.Model
    | AboutMe AboutMe.Model
    | MartialArts MartialArts.Model
    | WebDevelopment WebDevelopment.Model
    | Games Games.Model


routeParser : Parser (Page -> a) a
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
                    [ case model.page of
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
                                |> Html.map GamesMsg
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
                Home _ ->
                    "/#home"

                AboutMe _ ->
                    "/#about-me"

                MartialArts _  ->
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


urlToPage : Url -> Page
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

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    let
                        page =
                            urlToPage url

                        ( pageMdl, pageCmd ) =
                            loadPage page
                    in
                    ( { model
                        | page = page
                        , pageModel = pageMdl
                      }
                    , Cmd.batch [ Nav.pushUrl model.key (Url.toString url), pageCmd ]
                    )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }, Cmd.none )

        HomeMsg msg_ ->
            case model.page of
                Home mdl ->
                    let
                        ( homeMdl, homeCmd ) =
                            Home.update msg_ mdl

                        command =
                            homeCmd |> Cmd.map HomeMsg
                    in
                    ( { model | page = Home homeMdl }, command )

                _ ->
                    ( model, Cmd.none )

        AboutMeMsg msg_ ->
            case model.page of
                AboutMe mdl ->
                    let
                        ( aboutMeMdl, aboutMeCmd ) =
                            AboutMe.update msg_ mdl

                        command =
                            aboutMeCmd |> Cmd.map AboutMeMsg
                    in
                    ( { model | page = AboutMe aboutMeMdl }, command )

                _ ->
                    ( model, Cmd.none )

        MartialArtsMsg msg_ ->
            case model.page of
                MartialArts mdl ->
                    let
                        ( martialArtsMdl, martialArtsCmd ) =
                            MartialArts.update msg_ mdl

                        command =
                            martialArtsCmd |> Cmd.map MartialArtsMsg
                    in
                    ( { model | page = MartialArts martialArtsMdl }, command )

                _ ->
                    ( model, Cmd.none )
        WebDevelopmentMsg msg_ ->
            case model.page of
                WebDevelopment mdl ->
                    let
                        ( webDevMdl, webDevCmd ) =
                            WebDevelopment.update msg_ mdl

                        command =
                            webDevCmd |> Cmd.map WebDevelopmentMsg
                    in
                    ( { model | page = WebDevelopment webDevMdl }, command )

                _ ->
                    ( model, Cmd.none )

        GamesMsg msg_ ->
            case Debug.log "model" model.page of
                Games mdl ->
                    let
                        ( gamesMdl, gamesCmd ) =
                            Games.update msg_ mdl

                        command =
                            gamesCmd |> Cmd.map GamesMsg
                    in
                    ( { model | page = Games gamesMdl }, command )

                _ ->
                    ( model, Cmd.none )


loadPage : Page -> ( Page, Cmd Msg )
loadPage page =
    case page of
        Home _ ->
            let
                ( pageMdl, pageCmd ) =
                    Home.init

                command =
                    Cmd.map HomeMsg pageCmd
            in
            ( Home pageMdl, command )

        AboutMe _ ->
            let
                ( pageMdl, pageCmd ) =
                    AboutMe.init

                command =
                    Cmd.map AboutMeMsg pageCmd
            in
            ( AboutMe pageMdl, command )

        MartialArts _ ->
            let
                ( pageMdl, pageCmd ) =
                    MartialArts.init

                command =
                    Cmd.map MartialArtsMsg pageCmd
            in
            ( MartialArts pageMdl, command )

        WebDevelopment _ ->
            let
                ( pageMdl, pageCmd ) =
                    WebDevelopment.init

                command =
                    Cmd.map WebDevelopmentMsg pageCmd
            in
            ( WebDevelopment pageMdl, command )

        Games _ ->
            let
                ( pageMdl, pageCmd ) =
                    Games.init

                command =
                    Cmd.map GamesMsg pageCmd
            in
            ( Games pageMdl, command )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        ( homeModel, homeCmd ) =
            Home.init

        command =
            Cmd.map HomeMsg homeCmd
        
        page = urlToPage url
    in
    ( { key = key
      , url = url
      , page = Home homeModel
      }
    , command
    )


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
