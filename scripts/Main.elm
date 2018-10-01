module Main exposing (Model, Msg, init, subscriptions, update, view)

import Bootstrap.Buttons as Button exposing (..)
import Bootstrap.Navbar as Nav exposing (navbar)
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Pages.AboutMe as AboutMe
import Pages.MartialArts as MartialArts
import Pages.WebDevelopment as WebDevelopment
import Url exposing (Url)


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


view : Model -> Browser.Document Msg
view model =
    { title = "Jared Weinberger"
    , body =
        [ div [ class "background" ]
            [ div [ class "navbar" ]
                [ navbarButton (model.page == Home)  "Home"
                , navbarButton (model.page == AboutMe) "About Me"
                , img [ class "logo", src "./images/logo-no-bg.png" ] []
                , navbarButton (model.page == MartialArts) "Martial Arts"
                , navbarButton (model.page == WebDevelopment) "Web Development"
                ]
            , AboutMe.view
            ]
        ]
    }


navbarButton : Bool -> String -> Html msg
navbarButton selected content =
    div
        [ classList
            [ ( "nav-item", True )
            , ( "item-active", selected )
            ]
        ]
        [ text content ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoNothing ->
            ( model, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

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
