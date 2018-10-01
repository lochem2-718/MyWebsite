module Grid exposing (grid, item)

import Html exposing (..)
import Html.Attributes exposing (..) 


grid : List (Attribute msg) -> List (Html msg) -> Html msg
grid attributes items =
    div ((class "grid-container") :: attributes) items



item : List (Attribute msg) -> List (Html msg) -> Html msg
item attributes elements =
    div ((class "grid-item") :: attributes) elements