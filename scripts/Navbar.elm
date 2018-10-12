module Navbar exposing (centerNavLogo, navbar)

import Html exposing (Attribute, Html, a, div, li, nav, text, ul)
import Html.Attributes exposing (class, href, id)
import Maybe


navbar : List (Attribute msg) -> List (Html msg) -> Maybe (Html msg) -> Html msg
navbar attributes links logo =
    let
        logoElement =
            case logo of
                Just l ->
                    [ l ]

                Nothing ->
                    []

        contents =
            ul
                [ class "left hide-on-med-and-down"
                , id "nav-mobile"
                ]
                (List.map (\link -> li [] [ link ]) links)
                :: logoElement
        
        navAttrs =
            (class "nav-wrapper") :: attributes
    in
    nav attributes
        [ div navAttrs contents ]


centerNavLogo : List (Attribute msg) -> List (Html msg) -> Html msg
centerNavLogo attributes contents =
    let
        attrs = (class "brand-logo center") :: attributes
    in
    a attrs contents
