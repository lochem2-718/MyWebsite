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
    | HomeMsg Home.Msg
    | AboutMeMsg AboutMe.Msg
    | MartialArtsMsg MartialArts.Msg
    | WebDevelopmentMsg WebDevelopment.Msg
    | GamesMsg Games.Msg

type Page
    = Home
    | AboutMe
    | MartialArts
    | WebDevelopment
    | Games

type PageModel
    = HomeModel Home.Model
    | AboutMeModel AboutMe.Model
    | MartialArtsModel MartialArts.Model
    | WebDevelopmentModel WebDevelopment.Model
    | GamesModel Games.Model

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
    let
        currentPage = (pageModelToPage model.pageModel)
    in
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
                        [ navbarButton Home currentPage "Home"
                        , navbarButton AboutMe currentPage "About Me"
                        , navbarButton MartialArts currentPage "Martial Arts"
                        , navbarButton WebDevelopment currentPage "Web Development"
                        , navbarButton Games currentPage "Games"
                        ]
                }
            }
        , container [ class "main-content" ]
            [ row []
                [ col []
                    [ pageModelToView model.pageModel
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

pageModelToView : PageModel -> Html Msg
pageModelToView pageModel =
    case pageModel of
        HomeModel mdl ->
            Home.view mdl
                |> Html.map GamesMsg

        AboutMeModel mdl ->
            AboutMe.view mdl
                |> Html.map AboutMeMsg

        MartialArtsModel mdl ->
            MartialArts.view mdl
                |> Html.map MartialArtsMsg

        WebDevelopmentModel mdl ->
            WebDevelopment.view mdl
                |> Html.map WebDevelopmentMsg

        GamesModel mdl ->
            Games.view mdl
                |> Html.map GamesMsg


navbarButton : Page -> Page -> String -> Html msg
navbarButton targetPage currentPage content =
    let
        linkPath =
            case targetPage of
                Home ->
                    "/#home"

                AboutMe ->
                    "/#about-me"

                MartialArts  ->
                    "/#martial-arts"

                WebDevelopment ->
                    "/#web-dev"

                Games ->
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

pageModelToPage : PageModel -> Page
pageModelToPage pageModel =
    case pageModel of
        HomeModel _ ->
            Home
        AboutMeModel _ ->
            AboutMe
        MartialArtsModel _ ->
            MartialArts
        WebDevelopmentModel _ ->
            WebDevelopment
        GamesModel _ ->
            Games

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
                            initPage page
                    in
                    ( { model
                        | pageModel = pageMdl

                      }
                    , Cmd.batch [ Nav.pushUrl model.key (Url.toString url), pageCmd ]
                    )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }, Cmd.none )

        HomeMsg msg_ ->
            case model.pageModel of
                HomeModel mdl ->
                    let
                        ( homeMdl, homeCmd ) =
                            Home.update msg_ mdl

                        command =
                            homeCmd |> Cmd.map HomeMsg
                    in
                    ( { model | pageModel = HomeModel homeMdl }, command )

                _ ->
                    ( model, Cmd.none )

        AboutMeMsg msg_ ->
            case model.pageModel of
                AboutMeModel mdl ->
                    let
                        ( aboutMeMdl, aboutMeCmd ) =
                            AboutMe.update msg_ mdl

                        command =
                            aboutMeCmd |> Cmd.map AboutMeMsg
                    in
                    ( { model | pageModel = AboutMeModel aboutMeMdl }, command )

                _ ->
                    ( model, Cmd.none )

        MartialArtsMsg msg_ ->
            case model.pageModel of
                MartialArtsModel mdl ->
                    let
                        ( martialArtsMdl, martialArtsCmd ) =
                            MartialArts.update msg_ mdl

                        command =
                            martialArtsCmd |> Cmd.map MartialArtsMsg
                    in
                    ( { model | pageModel = MartialArtsModel martialArtsMdl }, command )

                _ ->
                    ( model, Cmd.none )
        WebDevelopmentMsg msg_ ->
            case model.pageModel of
                WebDevelopmentModel mdl ->
                    let
                        ( webDevMdl, webDevCmd ) =
                            WebDevelopment.update msg_ mdl

                        command =
                            webDevCmd |> Cmd.map WebDevelopmentMsg
                    in
                    ( { model | pageModel = WebDevelopmentModel webDevMdl }, command )

                _ ->
                    ( model, Cmd.none )

        GamesMsg msg_ ->
            case model.pageModel of
                GamesModel mdl ->
                    let
                        ( gamesMdl, gamesCmd ) =
                            Games.update msg_ mdl

                        command =
                            Cmd.map GamesMsg gamesCmd
                    in
                    ( { model | pageModel = GamesModel gamesMdl }, command )

                _ ->
                    ( model, Cmd.none )


initPage : Page -> ( PageModel, Cmd Msg )
initPage page =
    case page of
        Home ->
            let
                ( pageMdl, pageCmd ) =
                    Home.init

                command =
                    Cmd.map HomeMsg pageCmd
            in
            ( HomeModel pageMdl, command )

        AboutMe ->
            let
                ( pageMdl, pageCmd ) =
                    AboutMe.init

                command =
                    Cmd.map AboutMeMsg pageCmd
            in
            ( AboutMeModel pageMdl, command )

        MartialArts ->
            let
                ( pageMdl, pageCmd ) =
                    MartialArts.init

                command =
                    Cmd.map MartialArtsMsg pageCmd
            in
            ( MartialArtsModel pageMdl, command )

        WebDevelopment ->
            let
                ( pageMdl, pageCmd ) =
                    WebDevelopment.init

                command =
                    Cmd.map WebDevelopmentMsg pageCmd
            in
            ( WebDevelopmentModel pageMdl, command )

        Games ->
            let
                ( pageMdl, pageCmd ) =
                    Games.init

                command =
                    Cmd.map GamesMsg pageCmd
            in
            ( GamesModel pageMdl, command )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        page = urlToPage url
        
        ( pageModel, pageCmd ) =
            initPage page
    in
    ( { key = key
      , url = url
      , pageModel = pageModel
      }
    , pageCmd
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
