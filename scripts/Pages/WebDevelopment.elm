module Pages.WebDevelopment exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)


view : Html msg
view =
    article []
        [ header []
            [ h1 []
                [ text "Web Development" ]
            ]
        , section []
            [ h2 [] [ text "The Good" ]
            , p [] [ text "I get to make cool stuff and watch them work immediately." ]
            ]
        , section []
            [ h2 []
                [ text "The Bad" ]
            , p [] [ text "JavaScript or EF6 is a glorified mess and I want it to either go through a major refactoring or die." ]
            ]
        , section []
            [ h2 []
                [ text "The Ugly" ]
            , p [] [ text "CSS. 'Nuff said." ]
            ]
        , footer []
            [ p [ id "copyright" ]
                [ text "© Jared Weinberger the Magnificent" ]
            ]
        ]
