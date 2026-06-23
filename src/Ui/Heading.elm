module Ui.Heading exposing
    ( Heading, new
    , withId, withContent
    , Variant(..), withVariant, withSize, withLevel
    , view
    )

{-| Typed builder for M3 headings. Wraps `M3e.Heading`.


# Construction

@docs Heading, new


# Identity and content

@docs withId, withContent


# Variants

@docs Variant, withVariant, withSize, withLevel


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Extra
import M3e.Heading
import Ui.Size exposing (Size)


type Heading msg
    = Heading (Config msg)


type Variant
    = Display
    | Headline
    | Title
    | Label


type alias Config msg =
    { id : Maybe String
    , content : Maybe (Html msg)
    , variant : Variant
    , size : Maybe Size
    , level : Maybe Int
    }


new : Heading msg
new =
    Heading
        { id = Nothing
        , content = Nothing
        , variant = Headline
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


withLevel : Int -> Heading msg -> Heading msg
withLevel level (Heading cfg) =
    Heading { cfg | level = Just level }


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


toM3eHeadingSize : Ui.Size.Size -> M3e.Heading.Size
toM3eHeadingSize s =
    case s of
        Ui.Size.Small ->
            M3e.Heading.Small

        Ui.Size.Medium ->
            M3e.Heading.Medium

        Ui.Size.Large ->
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
