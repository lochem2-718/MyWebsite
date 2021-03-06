module Pages.AboutMe exposing (Model, Msg(..), init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    ()


type Msg
    = DoNothing


view : Model -> Html msg
view _ =
    article []
        [ header []
            [ h1 []
                [ text "About Me" ]
            ]
        , section []
            [ h3 []
                [ text "Early Life" ]
            , p []
                [ text "I was in a military family and moved around a ton. I also got born and stuff." ]
            ]
        , section []
            [ h3 []
                [ text "Recent" ]
            , p []
                [ text "Spent the summer doing web programming making websites of the web variety for Wiegand Glas in Germany." ]
            ]
        , section []
            [ h2 []
                [ text "Work Experience" ]
            , div [ class "table-container" ]
                [ table [ class "table" ]
                    [ thead []
                        [ tr []
                            [ th []
                                [ text "Position" ]
                            , th []
                                [ text "Employer" ]
                            , th []
                                [ text "Start Year" ]
                            , th []
                                [ text "End Year" ]
                            ]
                        ]
                    , tbody []
                        [ tr []
                            [ td []
                                [ text "Lifeguard" ]
                            , td []
                                [ text "Oro Valley" ]
                            , td []
                                [ text "2015" ]
                            , td []
                                [ text "2017" ]
                            ]
                        , tr []
                            [ td []
                                [ text "Web Programming Intern" ]
                            , td []
                                [ text "Wiegand Glas" ]
                            , td []
                                [ text "2018" ]
                            , td []
                                [ text "2018" ]
                            ]
                        ]
                    ]
                ]
            ]
        , section []
            [ h2 []
                [ text "Accomplishments" ]
            , ul []
                [ li []
                    [ text "Dean's List" ]
                , li []
                    [ text "NAU Honors College" ]
                , li []
                    [ text "Other Cool Stuff" ]
                ]
            ]
        , section []
            [ h2 []
                [ text "Hobbies & Interests" ]
            , ul []
                [ li []
                    [ text "Sword Fighting" ]
                , li []
                    [ text "Karate" ]
                , li []
                    [ text "Swimming" ]
                , li []
                    [ text "Biking" ]
                , li []
                    [ text "Not running" ]
                , li []
                    [ text "Full Stack Web Development" ]
                , li []
                    [ text "Other cool stuff" ]
                ]
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoNothing ->
            ( model, Cmd.none )


init : ( Model, Cmd Msg )
init =
    ( (), Cmd.none )
