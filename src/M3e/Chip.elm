module M3e.Chip exposing (Option, view, onClick)

import Json.Decode as Decode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


type Option msg
    = OnClick msg


onClick : msg -> Option msg
onClick =
    OnClick


view : { label : String } -> List (Option msg) -> Renderable { s | chip : Supported } msg
view req opts =
    let
        click =
            List.foldl (\(OnClick m) _ -> Just m) Nothing opts
    in
    Renderable.fromNode
        (Node.element "m3e-chip"
            (case click of
                Just m ->
                    [ Node.on "click" (Decode.succeed m) ]

                Nothing ->
                    []
            )
            [ Node.text req.label ]
        )
