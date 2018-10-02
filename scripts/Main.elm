module Main exposing (Model, Msg, init, subscriptions, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
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
    | PageChanged Page
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
        ]


view : Model -> Browser.Document Msg
view model =
    { title = "Jared Weinberger"
    , body =
        [ div [ class "background" ]
            [ div [ class "navbar" ]
                [ ul [ class "nav-list" ]
                    [ navbarButton [ onClick (PageChanged Home) ] "Home" (model.page == Home)
                    , navbarButton [ onClick (PageChanged AboutMe) ] "About Me" (model.page == AboutMe)
                    , li [] [ div [ class "nav-item logo-div" ] [ img [ class "logo", src "./images/logo-no-bg.png" ] [] ] ]
                    , navbarButton [ onClick (PageChanged MartialArts) ] "Martial Arts" (model.page == MartialArts)
                    , navbarButton [ onClick (PageChanged WebDevelopment) ] "Web Development" (model.page == WebDevelopment)
                    ]
                ]
            , hr [] []
            , div [ class "grid-container" ]
                [ div [ class "main-content" ]
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
            , footer [] [ p [ id "copyright" ] [ text "© Jared Weinberger the Magnificent" ] ]
            ]
        ]
    }


navbarButton : List (Attribute msg) -> String -> Bool -> Html msg
navbarButton attributes content selected =
    li []
        [ div
            (class
                ("nav-link nav-item"
                    ++ (if selected then
                            " item-active"

                        else
                            ""
                       )
                )
                :: attributes
            )
            [ text content ]
        ]


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

        PageChanged page ->
            ( { model | page = page }, Cmd.none )

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
