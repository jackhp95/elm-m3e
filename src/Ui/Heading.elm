module Ui.Heading exposing
    ( Heading, new
    , withAttributes
    , display, headline, title, label
    , withId, withContent
    , Variant(..), withVariant
    , Size(..), withSize
    , withLevel, clampLevel
    , view
    )

{-| Typed builder for M3 headings. Wraps `M3e.Heading`.


# Construction

@docs Heading, new


# Host attributes

@docs withAttributes


# Text presets

Terse constructors for the common "styled text" case — each sets the matching
variant and wraps a plain `String` as the content, so a call site stays a
one-liner (`Ui.Heading.title "Featured"`) while the M3 typescale still comes
from the `m3e-heading` element (no baked classes). Refine further with the
`with*` modifiers (`withSize`, `withLevel`, …) as needed.

@docs display, headline, title, label


# Identity and content

@docs withId, withContent


# Variants

@docs Variant, withVariant


# Size

`Ui.Heading` owns its own three-step size scale (matching the `m3e-heading`
`size` enum `small | medium | large`). Material defines sizes per component, so
there is no shared cross-component size type.

@docs Size, withSize


# Level

@docs withLevel, clampLevel


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Extra
import M3e.Heading


{-| The heading opaque type. Build via `new` or a text preset (`display`,
`headline`, `title`, `label`).
-}
type Heading msg
    = Heading (Config msg)


{-| The appearance variant of the heading, mirroring the `m3e-heading`
`variant` enum.
-}
type Variant
    = Display
    | Headline
    | Title
    | Label


{-| The heading's three-step size scale, mirroring the `m3e-heading` `size`
enum (`small | medium | large`). The element's own default is `medium`, applied
when no size is set.
-}
type Size
    = Small
    | Medium
    | Large


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , content : Maybe (Html msg)
    , variant : Variant
    , size : Maybe Size
    , level : Maybe Int
    }


{-| A new heading. The default variant is `Display`, matching the CEM
`m3e-heading` default.
-}
new : Heading msg
new =
    Heading
        { id = Nothing
        , attributes = []
        , content = Nothing
        , variant = Display
        , size = Nothing
        , level = Nothing
        }


{-| A `Display` heading from a plain string (the largest typescale).
-}
display : String -> Heading msg
display text =
    new |> withVariant Display |> withContent (Html.text text)


{-| A `Headline` heading from a plain string.
-}
headline : String -> Heading msg
headline text =
    new |> withVariant Headline |> withContent (Html.text text)


{-| A `Title` heading from a plain string — the common card/section title.
-}
title : String -> Heading msg
title text =
    new |> withVariant Title |> withContent (Html.text text)


{-| A `Label` heading from a plain string — small UI label / secondary text.
-}
label : String -> Heading msg
label text =
    new |> withVariant Label |> withContent (Html.text text)


{-| Append attributes to the underlying `<m3e-heading>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Heading msg -> Heading msg
withAttributes attributes (Heading cfg) =
    Heading { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> Heading msg -> Heading msg
withId id (Heading cfg) =
    Heading { cfg | id = Just id }


{-| Set the heading's content (arbitrary `Html`).
-}
withContent : Html msg -> Heading msg -> Heading msg
withContent content (Heading cfg) =
    Heading { cfg | content = Just content }


{-| Set the heading variant (`Display`, `Headline`, `Title`, `Label`).
-}
withVariant : Variant -> Heading msg -> Heading msg
withVariant variant (Heading cfg) =
    Heading { cfg | variant = variant }


{-| Set the heading size (`Small`, `Medium`, `Large`).
-}
withSize : Size -> Heading msg -> Heading msg
withSize size (Heading cfg) =
    Heading { cfg | size = Just size }


{-| Set the heading's accessibility level. The CEM constrains `m3e-heading`'s
`level` to `1..6`, so the value is clamped into that range.
-}
withLevel : Int -> Heading msg -> Heading msg
withLevel level (Heading cfg) =
    Heading { cfg | level = Just (clampLevel level) }


{-| Clamp a heading level into the CEM-permitted `1..6` range.
-}
clampLevel : Int -> Int
clampLevel level =
    clamp 1 6 level


toM3eHeadingVariant : Variant -> M3e.Heading.Variant
toM3eHeadingVariant variant =
    case variant of
        Display ->
            M3e.Heading.Display

        Headline ->
            M3e.Heading.Headline

        Title ->
            M3e.Heading.Title

        Label ->
            M3e.Heading.Label


toM3eHeadingSize : Size -> M3e.Heading.Size
toM3eHeadingSize s =
    case s of
        Small ->
            M3e.Heading.Small

        Medium ->
            M3e.Heading.Medium

        Large ->
            M3e.Heading.Large


{-| Render the heading.
-}
view : Heading msg -> Html msg
view (Heading cfg) =
    M3e.Heading.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (M3e.Heading.variant (toM3eHeadingVariant cfg.variant))
                , Maybe.map (toM3eHeadingSize >> M3e.Heading.size) cfg.size
                , Maybe.map (String.fromInt >> M3e.Heading.level) cfg.level
                ]
        )
        [ Html.Extra.viewMaybe identity cfg.content ]
