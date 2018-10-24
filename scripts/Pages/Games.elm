module Pages.Games exposing (Model, Msg(..), init, update, view)

import Array exposing (Array)
import Html exposing (Attribute, Html, a, div, footer, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Materialize exposing (..)
import Random
import Task
import Time exposing (..)


type Msg
    = DoNothing
    | NewGame
    | GameWon
    | BoxClicked Int Int
    | AquiredCurrentTime Posix
    | AquiredRandomPairs (List ( Int, Int ))


type alias Model =
    { won : Bool
    , board : Array (Array Bool)
    , coordinates : Maybe (List ( Int, Int ))
    , startTime : Maybe Time.Posix
    , currentTime : Maybe Time.Posix
    , timeZone : Maybe Zone
    }


view : Model -> Html Msg
view model =
    container []
        [ row []
            [ col []
                [ button [ onClick NewGame, class "start-button" ] []
                , timeDifference model.timeZone model.startTime model.currentTime
                    |> displayClock
                ]
            ]
        ]


displayClock : Maybe ( Int, Int ) -> Html msg
displayClock time =
    let
        timeString =
            case time of
                Nothing ->
                    "00:00"

                Just t ->
                    let
                        ( mins, secs ) =
                            t

                        minStr =
                            if mins < 10 then
                                "0" ++ String.fromInt mins

                            else
                                String.fromInt mins

                        secStr =
                            if secs < 10 then
                                "0" ++ String.fromInt secs

                            else
                                String.fromInt secs
                    in
                    minStr ++ ":" ++ secStr
    in
    span [] [ text timeString ]


timeDifference : Maybe Zone -> Maybe Posix -> Maybe Posix -> Maybe ( Int, Int )
timeDifference timeZone previousTime currentTime =
    if timeZone == Nothing || previousTime == Nothing || currentTime == Nothing then
        Nothing

    else
        let
            z =
                Maybe.withDefault Time.utc timeZone

            c =
                Maybe.withDefault (Time.millisToPosix 0) currentTime

            p =
                Maybe.withDefault (Time.millisToPosix 0) previousTime

            minutes =
                Time.toMinute z c - Time.toMinute z p

            seconds =
                Time.toSecond z c - Time.toMinute z p
        in
        Just ( minutes, seconds )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoNothing ->
            ( model, Cmd.none )

        NewGame ->
            ( model, getCurrentTime )

        GameWon ->
            ( model, Cmd.none )

        AquiredRandomPairs pair ->
            ( { model | coordinates = Just pair }, Cmd.none )

        AquiredCurrentTime time ->
            ( { model | startTime = Just time }, Cmd.none )

        BoxClicked row collumn ->
            ( model, Cmd.none )


getRandomPairs : Cmd Msg
getRandomPairs =
    Random.generate AquiredRandomPairs <| Random.list 5 <| Random.pair (Random.int 0 4) (Random.int 0 4)


getCurrentTime : Cmd Msg
getCurrentTime =
    Task.perform AquiredCurrentTime Time.now


init : ( Model, Cmd Msg )
init =
    ( { won = False
      , startTime = Nothing
      , currentTime = Nothing
      , timeZone = Nothing
      , coordinates = Nothing
      , board = Array.repeat 5 (Array.repeat 5 True)
      }
    , Cmd.none
    )
