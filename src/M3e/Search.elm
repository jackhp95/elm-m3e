module M3e.Search exposing (Option, view, onInput)

import Html.Events as E
import Json.Decode as Decode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


type Option msg
    = OnInput (String -> msg)


onInput : (String -> msg) -> Option msg
onInput =
    OnInput


type alias Config msg =
    { placeholder : String, onInput : Maybe (String -> msg) }


apply : Option msg -> Config msg -> Config msg
apply opt c =
    case opt of
        OnInput f ->
            { c | onInput = Just f }


view : { placeholder : String } -> List (Option msg) -> Renderable { s | search : Supported } msg
view req opts =
    let
        c =
            List.foldl apply { placeholder = req.placeholder, onInput = Nothing } opts
    in
    Renderable.fromNode
        (Node.element "m3e-search-bar"
            (Node.attribute "placeholder" c.placeholder
                :: (case c.onInput of
                        Just f ->
                            [ Node.on "input" (Decode.map f (Decode.at [ "target", "value" ] Decode.string)) ]

                        Nothing ->
                            []
                   )
            )
            []
        )
