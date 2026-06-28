module M3e.SplitPane exposing
    ( view
    , Option, Orientation(..)
    , orientation, disabled, label
    , name, value
    )

{-| `<m3e-split-pane>` — a resizable two-pane layout with a movable drag
handle between the panes.

Spec (per docs/CONVENTIONS.md):

  - Required: { start : List (Element any msg)
    , end : List (Element any msg) }
    (arbitrary content regions for the two panes; both are
    free-row — the `html` escape is valid inside either)
  - Options: orientation, disabled, label (accessible label for the handle)
  - Slots: "start" ← `m3e-content-pane` wrapping the start-side region;
    "end" ← `m3e-content-pane` wrapping the end-side region
    (named slots — each pane is wrapped automatically)
  - Properties: disabled (DOM property — introspectable)
  - Attrs: orientation via Node.rawAttr (Cem enum);
    label via Node.attribute (string attr)
  - Escape: html (inside each pane region)
  - Tag: splitPane

Each content region is wrapped in an `<m3e-content-pane>` element (faithfully
mirroring Ui.SplitPane) and assigned the appropriate slot name.

@docs view
@docs Option, Orientation
@docs orientation, disabled, label
@docs name, value

-}

import Cem.M3e.SplitPane as Cem
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| Direction of the split.

  - **Horizontal** — panes side by side; handle moves left/right (default).
  - **Vertical** — panes stacked; handle moves up/down.
  - **Auto** — let the element decide based on available space.

-}
type Orientation
    = Horizontal
    | Vertical
    | Auto


{-| An option configuring a split pane.
-}
type alias Option msg =
    Internal.Option Config msg


{-| Set the split orientation (default `Horizontal`).
-}
orientation : Orientation -> Option msg
orientation o =
    Internal.option (\c -> { c | orientation = o })


{-| Disable the drag handle (content still renders, controls go inert).
-}
disabled : Bool -> Option msg
disabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Accessible label for the drag handle (default: "Resize panes").
-}
label : String -> Option msg
label l =
    Internal.option (\c -> { c | label = Just l })


{-| Set the form field name (the `name` attribute on `<m3e-split-pane>`).
This identifies the split pane when its containing form is submitted.
Upstream: `FormAssociated` mixin → `name` attribute.
-}
name : String -> Option msg
name v =
    Internal.option (\c -> { c | name = Just v })


{-| Set the initial split position as a percentage (0–100). This is the
`value` attribute on `<m3e-split-pane>`; upstream default is `50`.
Upstream: `FormAssociated` mixin → `value` attribute (number, default `50`).
-}
value : Float -> Option msg
value v =
    Internal.option (\c -> { c | value = Just v })


type alias Config =
    { orientation : Orientation
    , disabled : Bool
    , label : Maybe String
    , name : Maybe String
    , value : Maybe Float
    }


{-| Render the resizable two-pane layout. The `start` and `end` regions are
each wrapped in an `<m3e-content-pane>` and placed in their named slots, with a
movable drag handle between them.
-}
view :
    { start : List (Element any msg)
    , end : List (Element any msg)
    }
    -> List (Option msg)
    -> Element { s | splitPane : Supported } msg
view req opts =
    let
        c : Config
        c =
            Internal.applyOptions opts
                { orientation = Horizontal
                , disabled = False
                , label = Nothing
                , name = Nothing
                , value = Nothing
                }
    in
    Internal.fromNode
        (Node.element "m3e-split-pane"
            (List.filterMap identity
                [ Just (Node.rawAttr (Cem.orientation (toCemOrientation c.orientation)))
                , Just (Node.property "disabled" (Encode.bool c.disabled))
                , Maybe.map (\l -> Node.attribute "label" l) c.label
                , Maybe.map (\v -> Node.attribute "name" v) c.name
                , Maybe.map (\v -> Node.attribute "value" (String.fromFloat v)) c.value
                ]
            )
            [ Node.withSlot "start"
                (Node.element "m3e-content-pane"
                    []
                    (List.map Element.toNode req.start)
                )
            , Node.withSlot "end"
                (Node.element "m3e-content-pane"
                    []
                    (List.map Element.toNode req.end)
                )
            ]
        )


toCemOrientation : Orientation -> Cem.Orientation
toCemOrientation o =
    case o of
        Horizontal ->
            Cem.Horizontal

        Vertical ->
            Cem.Vertical

        Auto ->
            Cem.Auto
