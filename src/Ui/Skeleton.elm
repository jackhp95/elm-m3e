module Ui.Skeleton exposing
    ( Skeleton, new
    , withAttributes
    , withId, withClass
    , Shape(..), Animation(..)
    , withLoaded, withShape, withAnimation
    , view
    )

{-| Typed builder for M3 skeleton placeholders. Wraps `M3e.Skeleton`.

Sizes for skeletons typically come from Tailwind utility classes
(width + height), not a `size` attribute — so this exposes `withClass`
to pass through utility classes.


# Construction

@docs Skeleton, new


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withClass


# Appearance and state

@docs Shape, Animation
@docs withLoaded, withShape, withAnimation


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import M3e.Skeleton


{-| The skeleton opaque type. Build via `new`.
-}
type Skeleton msg
    = Skeleton (Config msg)


{-| The skeleton shape. Mirrors the element's `shape` attribute (default
`Auto`).
-}
type Shape
    = Auto
    | Circular
    | Rounded
    | Square


{-| The skeleton's shimmer animation. Mirrors the element's `animation`
attribute (default `Wave`).
-}
type Animation
    = None
    | Pulse
    | Wave


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , classes : List String
    , loaded : Bool
    , shape : Maybe Shape
    , animation : Maybe Animation
    }


{-| Construct a fresh skeleton placeholder.
-}
new : Skeleton msg
new =
    Skeleton
        { id = Nothing
        , attributes = []
        , classes = []
        , loaded = False
        , shape = Nothing
        , animation = Nothing
        }


{-| Append attributes to the underlying `<m3e-…>` host element — the escape
hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Skeleton msg -> Skeleton msg
withAttributes attributes (Skeleton cfg) =
    Skeleton { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> Skeleton msg -> Skeleton msg
withId id (Skeleton cfg) =
    Skeleton { cfg | id = Just id }


{-| Append a CSS class (typically a Tailwind size utility).
-}
withClass : String -> Skeleton msg -> Skeleton msg
withClass cls (Skeleton cfg) =
    Skeleton { cfg | classes = cls :: cfg.classes }


{-| Mark the skeleton's content as loaded. When `True`, the element reveals
its projected content instead of the placeholder shimmer.
-}
withLoaded : Bool -> Skeleton msg -> Skeleton msg
withLoaded flag (Skeleton cfg) =
    Skeleton { cfg | loaded = flag }


{-| Set the placeholder shape (`shape` attribute).
-}
withShape : Shape -> Skeleton msg -> Skeleton msg
withShape shape (Skeleton cfg) =
    Skeleton { cfg | shape = Just shape }


{-| Set the shimmer animation (`animation` attribute).
-}
withAnimation : Animation -> Skeleton msg -> Skeleton msg
withAnimation animation (Skeleton cfg) =
    Skeleton { cfg | animation = Just animation }


{-| Render the skeleton.
-}
view : Skeleton msg -> Html msg
view (Skeleton cfg) =
    M3e.Skeleton.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , if cfg.loaded then
                    Just (M3e.Skeleton.loaded True)

                  else
                    Nothing
                , Maybe.map (M3e.Skeleton.shape << shapeToM3e) cfg.shape
                , Maybe.map (M3e.Skeleton.animation << animationToM3e) cfg.animation
                ]
            ++ List.map Attr.class cfg.classes
        )
        []


shapeToM3e : Shape -> M3e.Skeleton.Shape
shapeToM3e shape =
    case shape of
        Auto ->
            M3e.Skeleton.Auto

        Circular ->
            M3e.Skeleton.Circular

        Rounded ->
            M3e.Skeleton.Rounded

        Square ->
            M3e.Skeleton.Square


animationToM3e : Animation -> M3e.Skeleton.Animation
animationToM3e animation =
    case animation of
        None ->
            M3e.Skeleton.None

        Pulse ->
            M3e.Skeleton.Pulse

        Wave ->
            M3e.Skeleton.Wave
