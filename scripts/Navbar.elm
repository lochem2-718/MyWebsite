module Navbar exposing (Position(..), link, logo, navbar)

import Html exposing (Attribute, Html, a, div, li, nav, text, ul)
import Html.Attributes exposing (class, href, id)
import Maybe


type alias Navbar msg =
    { fixed : Bool
    , extended : Bool
    , logo : Logo msg
    , items :
        { position : Position
        , contents : List (NavItem msg)
        }
    }


type Position
    = Center
    | Left
    | Right
    | None


type alias NavItem msg =
    Html msg


type alias Logo msg =
    Html msg


navbar : List (Attribute msg) -> Navbar msg -> Html msg
navbar attributes navbar_ =
    let
        contents =
            [ navbar_.logo
            , ul
                ((case navbar_.items.position of
                    Left ->
                        class "left"

                    _ ->
                        class "right"
                 )
                    :: [ class "hide-on-men-and-down", id "nav-mobile" ]
                )
                navbar_.items.contents
            ]

        attrs =
            [ class "nav-wrapper" ]

        navAttrs =
            if navbar_.extended then
                class "nav-extended" :: attributes

            else
                attributes
    in
    if navbar_.fixed then
        div [ class "navbar-fixed" ]
            [ nav navAttrs
                [ div attrs contents ]
            ]

    else
        nav navAttrs
            [ div attrs contents ]


logo : List (Attribute msg) -> Position -> List (Html msg) -> Logo msg
logo attributes position contents =
    let
        posClass =
            class <|
                "brand-logo"
                    ++ (case position of
                            Center ->
                                " center"

                            Right ->
                                " right"

                            _ ->
                                ""
                       )

        attrs =
            posClass :: attributes
    in
    a attrs contents


link : List (Attribute msg) -> Html msg -> NavItem msg
link attributes content =
    li attributes [ content ]
