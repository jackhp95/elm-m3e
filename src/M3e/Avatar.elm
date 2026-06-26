module M3e.Avatar exposing (Option, view, image)

import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


type Option msg
    = Image String


image : String -> Option msg
image =
    Image


view : { alt : String } -> List (Option msg) -> Renderable { s | avatar : Supported } msg
view req opts =
    let
        src =
            List.foldl (\(Image u) _ -> Just u) Nothing opts
    in
    Renderable.fromNode
        (Node.element "m3e-avatar"
            (Node.attribute "alt" req.alt
                :: (case src of
                        Just u ->
                            [ Node.attribute "src" u ]

                        Nothing ->
                            []
                   )
            )
            []
        )
