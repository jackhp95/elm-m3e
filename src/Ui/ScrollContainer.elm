module Ui.ScrollContainer exposing
    ( ScrollContainer, new
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


# Modifiers

@docs withId, withThin


# Dividers

@docs Dividers, withDividers


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import M3e.ScrollContainer


type ScrollContainer msg
    = ScrollContainer Config


{-| Which dividers to show when content is scrolled.
-}
type Dividers
    = Both
    | Top
    | Bottom
    | None


type alias Config =
    { id : Maybe String
    , thin : Bool
    , dividers : Dividers
    }


new : ScrollContainer msg
new =
    ScrollContainer
        { id = Nothing
        , thin = False
        , dividers = Both
        }


withId : String -> ScrollContainer msg -> ScrollContainer msg
withId id (ScrollContainer cfg) =
    ScrollContainer { cfg | id = Just id }


{-| Use thin scrollbars.
-}
withThin : Bool -> ScrollContainer msg -> ScrollContainer msg
withThin flag (ScrollContainer cfg) =
    ScrollContainer { cfg | thin = flag }


withDividers : Dividers -> ScrollContainer msg -> ScrollContainer msg
withDividers d (ScrollContainer cfg) =
    ScrollContainer { cfg | dividers = d }


view : List (Html msg) -> ScrollContainer msg -> Html msg
view children (ScrollContainer cfg) =
    M3e.ScrollContainer.component
        (List.filterMap identity
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
