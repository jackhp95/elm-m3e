module M3e.IconButton exposing (Option, view, onClick, selected)

{-| One concept: a `view` returning slot-ready content (no builder type, no
lift). Required fields (incl the a11y `name`) in the record; optionals fold like
Html attributes; full config at `view` time so conditional rendering stays clean.
-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


type Option msg
    = OnClick msg
    | Selected Bool


onClick : msg -> Option msg
onClick =
    OnClick


selected : Bool -> Option msg
selected =
    Selected


type alias Config msg =
    { icon : String, name : String, onClick : Maybe msg, selected : Bool }


apply : Option msg -> Config msg -> Config msg
apply opt c =
    case opt of
        OnClick m ->
            { c | onClick = Just m }

        Selected b ->
            { c | selected = b }


view : { icon : String, name : String } -> List (Option msg) -> Renderable { s | iconButton : Supported } msg
view req opts =
    let
        c =
            List.foldl apply { icon = req.icon, name = req.name, onClick = Nothing, selected = False } opts
    in
    Renderable.fromNode
        (Node.element "m3e-icon-button"
            (List.concat
                [ [ Node.attribute "aria-label" c.name
                  , Node.property "selected" (Encode.bool c.selected)
                  ]
                , case c.onClick of
                    Just m ->
                        [ Node.on "click" (Decode.succeed m) ]

                    Nothing ->
                        []
                ]
            )
            [ Node.element "m3e-icon" [ Node.attribute "name" c.icon ] [] ]
        )
