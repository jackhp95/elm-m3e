module Ui.SplitPane exposing
    ( SplitPane, new
    , withAttributes
    , withId, withStart, withEnd
    , Orientation(..), withOrientation
    , view
    )

{-| Typed builder for `<m3e-split-pane>` — a resizable two-pane layout with
a movable drag handle between the panes. Granular slot setters for the two
panes; each is wrapped in `M3e.ContentPane` automatically.

Reach for a split pane when the user needs to resize how space is divided
between two adjacent regions (a list/detail layout, an editor/preview).
For other surfaces in the "Containers & surfaces" family: `Ui.Card` groups
content about one subject, while `Ui.Disclosure` shows/hides sections in
place rather than resizing them.

    Ui.SplitPane.new
        |> Ui.SplitPane.withStart [ text "Navigation" ]
        |> Ui.SplitPane.withEnd [ text "Detail" ]
        |> Ui.SplitPane.view


# Construction

@docs SplitPane, new


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withStart, withEnd


# Layout

@docs Orientation, withOrientation


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import M3e.ContentPane
import M3e.SplitPane


{-| The split pane opaque type. Build via `new`.
-}
type SplitPane msg
    = SplitPane (Config msg)


{-| Direction of the split, controlling how the drag handle moves.

  - **Horizontal** — panes sit side by side; the handle moves left/right.
  - **Vertical** — panes stack; the handle moves up/down.

-}
type Orientation
    = Horizontal
    | Vertical


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , start : List (Html msg)
    , end : List (Html msg)
    , orientation : Orientation
    }


{-| Construct a fresh, `Horizontal` split pane with empty start/end slots.
The handle defaults to the midpoint (the element's `value` is 50, i.e. the
start pane takes half the space).
-}
new : SplitPane msg
new =
    SplitPane
        { id = Nothing
        , attributes = []
        , start = []
        , end = []
        , orientation = Horizontal
        }


{-| Append attributes to the underlying `<m3e-split-pane>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> SplitPane msg -> SplitPane msg
withAttributes attributes (SplitPane cfg) =
    SplitPane { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> SplitPane msg -> SplitPane msg
withId id (SplitPane cfg) =
    SplitPane { cfg | id = Just id }


{-| Set the content for the `start` slot — the pane at the logical start
side (left in a `Horizontal` split, top in a `Vertical` one). This is the
pane whose size the drag handle controls.
-}
withStart : List (Html msg) -> SplitPane msg -> SplitPane msg
withStart html (SplitPane cfg) =
    SplitPane { cfg | start = html }


{-| Set the content for the `end` slot — the pane at the logical end side
(right in a `Horizontal` split, bottom in a `Vertical` one). It fills
whatever space the start pane leaves.
-}
withEnd : List (Html msg) -> SplitPane msg -> SplitPane msg
withEnd html (SplitPane cfg) =
    SplitPane { cfg | end = html }


{-| Set the split orientation. Defaults to `Horizontal` (panes side by side).
-}
withOrientation : Orientation -> SplitPane msg -> SplitPane msg
withOrientation orientation (SplitPane cfg) =
    SplitPane { cfg | orientation = orientation }


toM3eOrientation : Orientation -> M3e.SplitPane.Orientation
toM3eOrientation orientation =
    case orientation of
        Horizontal ->
            M3e.SplitPane.Horizontal

        Vertical ->
            M3e.SplitPane.Vertical


{-| Render the split pane.
-}
view : SplitPane msg -> Html msg
view (SplitPane cfg) =
    M3e.SplitPane.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (M3e.SplitPane.orientation (toM3eOrientation cfg.orientation))
                ]
        )
        [ M3e.ContentPane.component [ M3e.SplitPane.startSlot ] cfg.start
        , M3e.ContentPane.component [ M3e.SplitPane.endSlot ] cfg.end
        ]
