module M3e.Divider exposing
    ( view
    , Option
    , vertical, inset, insetStart, insetEnd
    )

{-| `<m3e-divider>` — a thin rule that separates content in lists or containers.

Spec (per docs/CONVENTIONS.md):

  - Required: none — a divider carries no required accessible name or content
  - Options: vertical, inset, insetStart, insetEnd
  - Slots: none (leaf element)
  - Properties: vertical, inset, inset-start, inset-end — all via Node.property
    (Cem.M3e.Divider uses Html.Attributes.property for all four;
    emitted via Node.property so tests can assert them)
  - Escape: none (leaf)
  - Tag: m3e-divider

Because there are no required fields, `view` takes only the options list:

    view : List (Option msg) -> Renderable { s | divider : Supported } msg

@docs view
@docs Option
@docs vertical, inset, insetStart, insetEnd

-}

import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


type alias Config =
    { vertical : Bool
    , inset : Bool
    , insetStart : Bool
    , insetEnd : Bool
    }


{-| Configuration option for `view`.
-}
type alias Option msg =
    Internal.Option Config msg


{-| Render the divider vertically (for side-by-side content). Default `False`.
Maps to the `vertical` DOM property.
-}
vertical : Bool -> Option msg
vertical b =
    Internal.option (\c -> { c | vertical = b })


{-| Indent the rule with equal padding on both sides (the M3 "inset divider").
Maps to the `inset` DOM property. Default `False`.
-}
inset : Bool -> Option msg
inset b =
    Internal.option (\c -> { c | inset = b })


{-| Indent the leading (start) edge only.
Maps to the `inset-start` DOM property. Default `False`.
-}
insetStart : Bool -> Option msg
insetStart b =
    Internal.option (\c -> { c | insetStart = b })


{-| Indent the trailing (end) edge only.
Maps to the `inset-end` DOM property. Default `False`.
-}
insetEnd : Bool -> Option msg
insetEnd b =
    Internal.option (\c -> { c | insetEnd = b })


{-| Render the divider.
-}
view : List (Option msg) -> Renderable { s | divider : Supported } msg
view opts =
    let
        c =
            Internal.applyOptions opts
                { vertical = False
                , inset = False
                , insetStart = False
                , insetEnd = False
                }
    in
    Internal.fromNode
        (Node.element "m3e-divider"
            (List.filterMap identity
                [ if c.vertical then
                    Just (Node.property "vertical" (Encode.bool True))

                  else
                    Nothing
                , if c.inset then
                    Just (Node.property "inset" (Encode.bool True))

                  else
                    Nothing
                , if c.insetStart then
                    Just (Node.property "inset-start" (Encode.bool True))

                  else
                    Nothing
                , if c.insetEnd then
                    Just (Node.property "inset-end" (Encode.bool True))

                  else
                    Nothing
                ]
            )
            []
        )
