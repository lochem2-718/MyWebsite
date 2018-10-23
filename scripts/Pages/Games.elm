module Pages.Games exposing (Model, view, update, Msg(..), init)

import Html exposing (Attribute, Html, a, div, footer, li, text, ul)
import Task
import Materialize exposing (..)
import Time exposing (..)


type Msg
    = DoNothing
    | GameRestarted
    | GameWon
    | BoxClicked Int Int


type alias Model =
    { won : Bool
    , timeElapsed : Time.Posix
    }


view : Model -> Html msg
view model =
    div [] []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoNothing ->
            ( model, Cmd.none )

        GameRestarted ->
            ( model, Cmd.none )

        GameWon ->
            ( model, Cmd.none )

        BoxClicked row collumn ->
            ( model, Cmd.none )



init : ( Model, Cmd Msg )
init =
    ( { won = False, Task.perform Time.now }, Cmd.none )
