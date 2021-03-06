module Pages.WebDevelopment exposing (Model, Msg(..), init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    ()


type Msg
    = DoNothing


view : Model -> Html msg
view _ =
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
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoNothing ->
            ( model, Cmd.none )


init : ( Model, Cmd Msg )
init =
    ( (), Cmd.none )
