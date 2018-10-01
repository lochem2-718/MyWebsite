module Pages.MartialArts exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)


view : Html msg
view =
    article []
        [ div [ class "main-title" ]
            [ header [] [ h1 [] [ text "Martial Arts" ] ] ]
        , section []
            [ h2 [] [ text "Benefits" ]
            , p [] [ text "It can be really cool because you get to scream a lot in white pajamas." ]
            ]
        , section []
            [ h2 [] [ text "Weapons" ]
            , p [] [ text "We get to use cool-ass weapons like spears and sticks and swords and nunchaku and stuff." ]
            ]
        , section []
            [ h2 [] [ text "Accomplishments" ]
            , p [] [ text "I done got like a billion million-dan black belts and stuff." ]
            ]
        , footer []
            [ p [ id "copyright" ]
                [ text "© Jared Weinberger the Magnificent" ]
            ]
        ]
