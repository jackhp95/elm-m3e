module Ui.ScrollContainer exposing
    ( ScrollContainer, new
    , withAttributes
    , withId, withThin
    , Dividers(..), withDividers
    , view
    )

{-| Typed builder for `<m3e-scroll-container>`. Wraps
`M3e.ScrollContainer`.

**Utility element — outside the documented Material component set.**
`m3e-scroll-container` is not one of the 53 documented Material 3
components; it ships only as a vendor binding (`M3e.ScrollContainer`) as
a layout helper. It is kept here for parity with the vendor surface, but
it does not correspond to a documented Material component, so it sits
outside the "one module per documented component" map.

A vertically scrollable area that shows dividers above and below
content when scrolled, providing a visual cue that more content exists.

    Ui.ScrollContainer.new
        |> Ui.ScrollContainer.withId "sidebar-scroll"
        |> Ui.ScrollContainer.withThin True
        |> Ui.ScrollContainer.view [ longContent ]


# Construction

@docs ScrollContainer, new


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withThin


# Dividers

@docs Dividers, withDividers


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import M3e.ScrollContainer


{-| The scroll container opaque type. Build via `new`.
-}
type ScrollContainer msg
    = ScrollContainer (Config msg)


{-| Which dividers to show when content is scrolled.
-}
type Dividers
    = Both
    | Top
    | Bottom
    | None


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , thin : Bool
    , dividers : Dividers
    }


{-| Construct a fresh scroll container with default scrollbars and both dividers.
-}
new : ScrollContainer msg
new =
    ScrollContainer
        { id = Nothing
        , attributes = []
        , thin = False
        , dividers = Both
        }


{-| Append attributes to the underlying `<m3e-…>` host element — the escape
hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> ScrollContainer msg -> ScrollContainer msg
withAttributes attributes (ScrollContainer cfg) =
    ScrollContainer { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> ScrollContainer msg -> ScrollContainer msg
withId id (ScrollContainer cfg) =
    ScrollContainer { cfg | id = Just id }


{-| Use thin scrollbars.
-}
withThin : Bool -> ScrollContainer msg -> ScrollContainer msg
withThin flag (ScrollContainer cfg) =
    ScrollContainer { cfg | thin = flag }


{-| Choose which dividers appear when content is scrolled.
-}
withDividers : Dividers -> ScrollContainer msg -> ScrollContainer msg
withDividers d (ScrollContainer cfg) =
    ScrollContainer { cfg | dividers = d }


{-| Render the scroll container around the given children.
-}
view : List (Html msg) -> ScrollContainer msg -> Html msg
view children (ScrollContainer cfg) =
    M3e.ScrollContainer.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , if cfg.thin then
                    Just (M3e.ScrollContainer.thin True)

                  else
                    Nothing
                , Just (M3e.ScrollContainer.dividers (dividersToM3e cfg.dividers))
                ]
        )
        children


dividersToM3e : Dividers -> M3e.ScrollContainer.Dividers
dividersToM3e d =
    case d of
        Both ->
            M3e.ScrollContainer.AboveBelow

        Top ->
            M3e.ScrollContainer.Above

        Bottom ->
            M3e.ScrollContainer.Below

        None ->
            M3e.ScrollContainer.None
