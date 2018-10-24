module Materialize exposing
    ( Col
    , MediaSource
    , Row
    , circleImage
    , col
    , container
    , divider
    , image
    , nbsb
    , button
    , p
    , row
    , section
    , video
    )

import Html as H exposing (Attribute, Html, a, div, img, text)
import Html.Attributes exposing (class, href, id)


type alias Row msg =
    Html msg


type alias Col msg =
    Html msg


type alias MediaSource msg =
    Html msg


type Position
    = Center
    | Left
    | Right


row : List (Attribute msg) -> List (Col msg) -> Row msg
row attributes contents =
    let
        attrs =
            class "row" :: attributes
    in
    div attrs contents


col : List (Attribute msg) -> List (Html msg) -> Col msg
col attributes contents =
    let
        attrs =
            class "col" :: attributes
    in
    div attrs contents


container : List (Attribute msg) -> List (Row msg) -> Html msg
container attributes contents =
    let
        attrs =
            class "container" :: attributes
    in
    div attrs contents


divider : List (Attribute msg) -> Html msg
divider attributes =
    let
        attrs =
            class "divider" :: attributes
    in
    div attrs []


section : List (Attribute msg) -> List (Html msg) -> Html msg
section attributes contents =
    let
        attrs =
            class "section" :: attributes
    in
    div attrs contents


p : List (Attribute msg) -> List (Html msg) -> Html msg
p attributes contents =
    let
        attrs =
            class "flow-text" :: attributes
    in
    H.p attrs contents


nbsb : String
nbsb =
    String.fromChar '\u{00A0}'


button : List (Attribute msg) -> List (Html msg) -> Html msg
button attributes contents =
    a (class "waves-effect waves-light btn" :: attributes) contents


image : List (Attribute msg) -> List (Html msg) -> Html msg
image attributes contents =
    let
        attrs =
            class "resposive-img" :: attributes
    in
    img attrs contents


circleImage : List (Attribute msg) -> List (Html msg) -> Html msg
circleImage attributes contents =
    let
        attrs =
            class "circle resposive-img" :: attributes
    in
    img attrs contents


video : List (Attribute msg) -> List (Html msg) -> Html msg
video attributes contents =
    let
        attrs =
            class "responsive-video" :: attributes
    in
    H.video attrs contents
