module Ui.SplitPane exposing
    ( SplitPane, new
    , withAttributes
    , withId, withStart, withEnd
    , Orientation(..), withOrientation
    , view
    )

{-| Typed builder for M3 split panes. Granular slot setters for the two
panes; each is wrapped in `M3e.ContentPane` automatically.


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


type SplitPane msg
    = SplitPane (Config msg)


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


withId : String -> SplitPane msg -> SplitPane msg
withId id (SplitPane cfg) =
    SplitPane { cfg | id = Just id }


withStart : List (Html msg) -> SplitPane msg -> SplitPane msg
withStart html (SplitPane cfg) =
    SplitPane { cfg | start = html }


withEnd : List (Html msg) -> SplitPane msg -> SplitPane msg
withEnd html (SplitPane cfg) =
    SplitPane { cfg | end = html }


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
