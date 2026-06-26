module Ui.Badge exposing
    ( Badge, dot, count, label
    , withAttributes
    , withId, withFor
    , Position(..), withPosition
    , view
    )

{-| Typed builder for M3 badges. Wraps `M3e.Badge`.

A badge is a compact count or dot attached to an icon or item — use it for
unread counts, presence, or short status emphasis. For a dismissible message
about a completed action reach for [`Ui.Snackbar`](Ui-Snackbar); for on-hover /
focus context on a control, [`Ui.Tooltip`](Ui-Tooltip).

M3 sanctions exactly two badge types: **small** (shape only, no text) and
**large** (text/count). These map to three constructors so the content rules
are enforced by construction rather than by settable-but-ignored modifiers:

  - [`dot`](#dot) — small; a shape-only indicator with no content slot.
  - [`count`](#count) — large; a numeric badge. Applies the M3 "999+"
    truncation (max 4 chars including `+`).
  - [`label`](#label) — large; short status text.

Anchor a badge to another element by that element's id and m3e positions it
relative to the anchor:

    Ui.Badge.count 10
        |> Ui.Badge.withFor "inbox-button"
        |> Ui.Badge.view


# Construction

@docs Badge, dot, count, label


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withFor


# Position

@docs Position, withPosition


# Render

@docs view

@figma-code-connect node=<https://www.figma.com/design/cbhz1J779WAI7gYkjCQwS0/Avetta---ADS-Material-Rebrand?node-id=70622-99> entry=label valueProp=Label

-}

import Html exposing (Attribute, Html, text)
import Html.Attributes as Attr
import Html.Extra
import M3e.Badge


{-| The badge opaque type. Build via `dot`, `count`, or `label`.
-}
type Badge msg
    = Badge (Config msg)


{-| Where the badge sits relative to the element it is attached to (via
[`withFor`](#withFor)), mirroring the `m3e-badge` `position` enum. The element
default is `AboveAfter` (top-trailing corner).
-}
type Position
    = Above
    | AboveAfter
    | AboveBefore
    | After
    | Before
    | Below
    | BelowAfter
    | BelowBefore


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , content : Maybe (Html msg)
    , size : M3e.Badge.Size
    , for : Maybe String
    , position : Position
    }


{-| A small, shape-only badge (no content) — the M3 "small" type.
-}
dot : Badge msg
dot =
    Badge { id = Nothing, attributes = [], content = Nothing, size = M3e.Badge.Small, for = Nothing, position = AboveAfter }


{-| A large numeric badge. Applies the M3 "999+" truncation: counts above 999
render as `999+` (the spec caps the badge at 4 characters including the `+`).
-}
count : Int -> Badge msg
count n =
    Badge { id = Nothing, attributes = [], content = Just (text (countLabel n)), size = M3e.Badge.Large, for = Nothing, position = AboveAfter }


{-| A large badge displaying short status text — the M3 "large" type.
-}
label : String -> Badge msg
label content =
    Badge { id = Nothing, attributes = [], content = Just (text content), size = M3e.Badge.Large, for = Nothing, position = AboveAfter }


countLabel : Int -> String
countLabel n =
    if n > 999 then
        "999+"

    else
        String.fromInt n


{-| Append attributes to the underlying `<m3e-badge>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Badge msg -> Badge msg
withAttributes attributes (Badge cfg) =
    Badge { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute on the underlying `<m3e-badge>`.
-}
withId : String -> Badge msg -> Badge msg
withId id (Badge cfg) =
    Badge { cfg | id = Just id }


{-| Anchor the badge to the interactive control with the given `id` (the m3e
`for` attribute). m3e attaches the badge to that element and positions it
(element default `above-after`). Unset (`for` defaults to null), the badge
renders inline wherever you place it.
-}
withFor : String -> Badge msg -> Badge msg
withFor forId (Badge cfg) =
    Badge { cfg | for = Just forId }


{-| Set where the badge sits relative to its anchor — the `position`
attribute (default `AboveAfter`, the top-trailing corner). Only meaningful
when the badge is attached to an element via [`withFor`](#withFor).
-}
withPosition : Position -> Badge msg -> Badge msg
withPosition position (Badge cfg) =
    Badge { cfg | position = position }


toM3ePosition : Position -> M3e.Badge.Position
toM3ePosition position =
    case position of
        Above ->
            M3e.Badge.Above

        AboveAfter ->
            M3e.Badge.AboveAfter

        AboveBefore ->
            M3e.Badge.AboveBefore

        After ->
            M3e.Badge.After

        Before ->
            M3e.Badge.Before

        Below ->
            M3e.Badge.Below

        BelowAfter ->
            M3e.Badge.BelowAfter

        BelowBefore ->
            M3e.Badge.BelowBefore


{-| Render the badge to `Html` — a `<m3e-badge>` carrying its content (for
`count` / `label`) in the default slot.
-}
view : Badge msg -> Html msg
view (Badge cfg) =
    M3e.Badge.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (M3e.Badge.size cfg.size)
                , Just (M3e.Badge.position (toM3ePosition cfg.position))
                , Maybe.map M3e.Badge.for cfg.for
                ]
        )
        [ Html.Extra.viewMaybe identity cfg.content ]
