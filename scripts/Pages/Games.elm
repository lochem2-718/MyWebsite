module Pages.Games exposing (Model, Msg(..), init, update, view)

import Html exposing (Attribute, Html, a, div, footer, li, text, ul)
import Materialize exposing (..)
import Random
import Task
import Time exposing (..)


type Msg
    = DoNothing
    | GameRestarted
    | GameWon
    | BoxClicked Int Int
    | AquiredCurrentTime Posix
    | AquiredRandomPair ( Int, Int )


type alias Model =
    { won : Bool
    , coordinates : Maybe ( Int, Int )
    , startTime : Maybe Time.Posix
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
            ( model, getCurrentTime )

        GameWon ->
            ( model, Cmd.none )

        AquiredRandomPair pair ->
            ( { model | coordinates = Just pair }, Cmd.none )

        AquiredCurrentTime time ->
            ( { model | startTime = Just time }, Cmd.none )

        BoxClicked row collumn ->
            ( model, Cmd.none )


getRandomInt : Cmd Msg
getRandomInt =
    Random.generate AquiredRandomPair <| Random.pair (Random.int 0 4) (Random.int 0 4)


getCurrentTime : Cmd Msg
getCurrentTime =
    Task.perform AquiredCurrentTime Time.now


init : ( Model, Cmd Msg )
init =
    ( { won = False, startTime = Nothing, coordinates = Nothing }, getCurrentTime )
