module M3e.Divider exposing
    ( Option
    , view
    , vertical, inset, insetStart, insetEnd
    )

{-| `<m3e-divider>` — a thin rule that separates content in lists or containers.

Spec (per docs/CONVENTIONS.md):

  - Required:   none — a divider carries no required accessible name or content
  - Options:    vertical, inset, insetStart, insetEnd
  - Slots:      none (leaf element)
  - Properties: vertical, inset, inset-start, inset-end — all via Node.property
                (Cem.M3e.Divider uses Html.Attributes.property for all four;
                emitted via Node.property so tests can assert them)
  - Escape:     none (leaf)
  - Tag:        m3e-divider

Because there are no required fields, `view` takes only the options list:

    view : List (Option msg) -> Renderable { s | divider : Supported } msg

-}

import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


type Option msg
    = Vertical Bool
    | Inset Bool
    | InsetStart Bool
    | InsetEnd Bool


{-| Render the divider vertically (for side-by-side content). Default `False`.
Maps to the `vertical` DOM property.
-}
vertical : Bool -> Option msg
vertical =
    Vertical


{-| Indent the rule with equal padding on both sides (the M3 "inset divider").
Maps to the `inset` DOM property. Default `False`.
-}
inset : Bool -> Option msg
inset =
    Inset


{-| Indent the leading (start) edge only.
Maps to the `inset-start` DOM property. Default `False`.
-}
insetStart : Bool -> Option msg
insetStart =
    InsetStart


{-| Indent the trailing (end) edge only.
Maps to the `inset-end` DOM property. Default `False`.
-}
insetEnd : Bool -> Option msg
insetEnd =
    InsetEnd


type alias Config =
    { vertical : Bool
    , inset : Bool
    , insetStart : Bool
    , insetEnd : Bool
    }


apply : Option msg -> Config -> Config
apply opt c =
    case opt of
        Vertical b ->
            { c | vertical = b }

        Inset b ->
            { c | inset = b }

        InsetStart b ->
            { c | insetStart = b }

        InsetEnd b ->
            { c | insetEnd = b }


view : List (Option msg) -> Renderable { s | divider : Supported } msg
view opts =
    let
        c =
            List.foldl apply
                { vertical = False
                , inset = False
                , insetStart = False
                , insetEnd = False
                }
                opts
    in
    Renderable.fromNode
        (Node.element "m3e-divider"
            (List.filterMap identity
                [ if c.vertical then Just (Node.property "vertical" (Encode.bool True)) else Nothing
                , if c.inset then Just (Node.property "inset" (Encode.bool True)) else Nothing
                , if c.insetStart then Just (Node.property "inset-start" (Encode.bool True)) else Nothing
                , if c.insetEnd then Just (Node.property "inset-end" (Encode.bool True)) else Nothing
                ]
            )
            []
        )
