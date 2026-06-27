module M3e.SplitPane exposing
    ( Orientation(..), Option
    , view
    , orientation, disabled, label
    )

{-| `<m3e-split-pane>` — a resizable two-pane layout with a movable drag
handle between the panes.

Spec (per docs/CONVENTIONS.md):

  - Required:   { start : List (Renderable any msg)
                , end   : List (Renderable any msg) }
                (arbitrary content regions for the two panes; both are
                free-row — the `html` escape is valid inside either)
  - Options:    orientation, disabled, label (accessible label for the handle)
  - Slots:      "start" ← `m3e-content-pane` wrapping the start-side region;
                "end"   ← `m3e-content-pane` wrapping the end-side region
                (named slots — each pane is wrapped automatically)
  - Properties: disabled (DOM property — introspectable)
  - Attrs:      orientation via Node.rawAttr (Cem enum);
                label via Node.attribute (string attr)
  - Escape:     html (inside each pane region)
  - Tag:        splitPane

Each content region is wrapped in an `<m3e-content-pane>` element (faithfully
mirroring Ui.SplitPane) and assigned the appropriate slot name.

-}

import Cem.M3e.SplitPane as Cem
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.Internal as Internal


{-| Direction of the split.

  - **Horizontal** — panes side by side; handle moves left/right (default).
  - **Vertical** — panes stacked; handle moves up/down.
  - **Auto** — let the element decide based on available space.

-}
type Orientation
    = Horizontal
    | Vertical
    | Auto


type alias Option msg =
    Internal.Option Config msg


{-| Set the split orientation (default `Horizontal`). -}
orientation : Orientation -> Option msg
orientation o =
    Internal.option (\c -> { c | orientation = o })


{-| Disable the drag handle (content still renders, controls go inert). -}
disabled : Bool -> Option msg
disabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Accessible label for the drag handle (default: "Resize panes"). -}
label : String -> Option msg
label l =
    Internal.option (\c -> { c | label = Just l })


type alias Config =
    { orientation : Orientation
    , disabled : Bool
    , label : Maybe String
    }


view :
    { start : List (Renderable any msg)
    , end : List (Renderable any msg)
    }
    -> List (Option msg)
    -> Renderable { s | splitPane : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts
                { orientation = Horizontal, disabled = False, label = Nothing }
    in
    Internal.fromNode
        (Node.element "m3e-split-pane"
            (List.filterMap identity
                [ Just (Node.rawAttr (Cem.orientation (toCemOrientation c.orientation)))
                , if c.disabled then Just (Node.property "disabled" (Encode.bool True)) else Nothing
                , Maybe.map (\l -> Node.attribute "label" l) c.label
                ]
            )
            [ Node.withSlot "start"
                (Node.element "m3e-content-pane"
                    []
                    (List.map Renderable.toNode req.start)
                )
            , Node.withSlot "end"
                (Node.element "m3e-content-pane"
                    []
                    (List.map Renderable.toNode req.end)
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
