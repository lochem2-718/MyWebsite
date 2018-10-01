module Pages.MartialArts exposing (view)

import Bootstrap.Grid as Grid
import Html exposing (..)
import Html.Attributes exposing (..)


view : Html msg
view =
    div [ class "main-content text-white bg-info" ]
        [ Grid.container
            [ Grid.row
                [ Grid.column []
                    [ div [ class "main-title text-secondary bg-warning" ]
                        [ header [] [ h1 [ class "text-info" ] [ text "Martial Arts" ] ] ]
                    ]
                ]
            , Grid.row
                [ Grid.column []
                    [ section []
                        [ h2 [] [ text "Sogobujutsu" ]
                        , p [] []
                        ]
                    , section []
                        [ h2 [] [ text "Karate Tech" ]
                        ]
                    ]
                , Grid.column []
                    [ section []
                        [ h2 [] [ text "Accomplishments" ] ]
                    ]
                ]
            , Grid.row
                [ Grid.column []
                    [ footer []
                        [ p [ id "copyright" ]
                            [ text "© Jared Weinberger the Magnificent" ]
                        ]
                    ]
                ]
            ]
        ]
