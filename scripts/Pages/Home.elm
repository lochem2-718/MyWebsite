module Pages.Home exposing (Model, view, init)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    ()

type Msg = DoNothing

view : Model -> Html msg
view _ =
    article []
        [ section []
            [ h2 [] [ text "About This Site" ]
            , p []
                [ text <|
                    "This site exists to fulfill homework requirements for CS 212 - Introduction to Web Programming."
                        ++ "Many of the things I put on this site are not serious. I will, after I finish CS 212, refactor this website"
                        ++ "into a sort of resume website, but NOT TODAAAAAAAYYYYYYYYYYYYYYYYYYYYY!!!!!"
                ]
            ]
        , section []
            [ h2 [] [ text "Things I want To Learn" ]
            , ul []
                [ li [] [ text "Angular" ]
                , li [] [ text "React" ]
                , li [] [ text "More Elm" ]
                , li [] [ text "SQL server management" ]
                , li [] [ text "Flask" ]
                , li [] [ text "Django" ]
                , li [] [ text "Spring" ]
                , li [] [ text "Material Design library" ]
                ]
            ]
        ]


init : ( Model, Cmd Msg )
init =
    ( (), Cmd.none )
