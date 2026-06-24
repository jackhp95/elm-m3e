module Ui.Heading exposing
    ( Heading, new
    , withId, withContent
    , Variant(..), withVariant
    , Size(..), withSize
    , withLevel, clampLevel
    , view
    )

{-| Typed builder for M3 headings. Wraps `M3e.Heading`.


# Construction

@docs Heading, new


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

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Extra
import M3e.Heading


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
        , content = Nothing
        , variant = Display
        , size = Nothing
        , level = Nothing
        }


withId : String -> Heading msg -> Heading msg
withId id (Heading cfg) =
    Heading { cfg | id = Just id }


withContent : Html msg -> Heading msg -> Heading msg
withContent content (Heading cfg) =
    Heading { cfg | content = Just content }


withVariant : Variant -> Heading msg -> Heading msg
withVariant variant (Heading cfg) =
    Heading { cfg | variant = variant }


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


view : Heading msg -> Html msg
view (Heading cfg) =
    M3e.Heading.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Just (M3e.Heading.variant (toM3eHeadingVariant cfg.variant))
            , Maybe.map (toM3eHeadingSize >> M3e.Heading.size) cfg.size
            , Maybe.map (String.fromInt >> M3e.Heading.level) cfg.level
            ]
        )
        [ Html.Extra.viewMaybe identity cfg.content ]
