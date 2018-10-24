module Pages.MartialArts exposing (Model, Msg(..), init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    ()


type Msg
    = DoNothing


view : Model -> Html msg
view _ =
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
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoNothing ->
            ( model, Cmd.none )


init : ( Model, Cmd Msg )
init =
    ( (), Cmd.none )
