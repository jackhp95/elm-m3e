module Ui.Skeleton exposing
    ( Skeleton, new
    , withAttributes
    , withId, withClass
    , Shape(..), Animation(..)
    , withLoaded, withShape, withAnimation
    , view
    )

{-| Typed builder for `<m3e-skeleton>` — a placeholder surface that mimics
content layout while it loads, preserving layout stability and fading out
when content arrives. Wraps `M3e.Skeleton`.

Reach for a skeleton when a whole region is loading and you want to hold its
shape; for an expressive short-wait spinner use `Ui.LoadingIndicator`, and
for a tracked task use `Ui.Progress`.

Sizes for skeletons typically come from Tailwind utility classes
(width + height), not a `size` attribute — so this exposes `withClass`
to pass through utility classes.

    Ui.Skeleton.new
        |> Ui.Skeleton.withShape Ui.Skeleton.Circular
        |> Ui.Skeleton.withClass "size-12"
        |> Ui.Skeleton.view


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


{-| The skeleton shape, mirroring the element's `shape` attribute (default
`Auto`, which adapts the shape to the content it mimics). `Circular`,
`Rounded`, and `Square` force a fixed shape.
-}
type Shape
    = Auto
    | Circular
    | Rounded
    | Square


{-| The skeleton's loading animation, mirroring the element's `animation`
attribute (default `Wave`). `Pulse` fades in and out, `Wave` sweeps a
shimmer across the surface, and `None` disables motion.
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


{-| Mark the skeleton's content as loaded (`loaded` attribute, default
`False`). When `True`, the element fades out the placeholder and reveals its
projected content.
-}
withLoaded : Bool -> Skeleton msg -> Skeleton msg
withLoaded flag (Skeleton cfg) =
    Skeleton { cfg | loaded = flag }


{-| Set the placeholder shape (`shape` attribute). The element defaults to
`Auto`, which adapts to the mimicked content.
-}
withShape : Shape -> Skeleton msg -> Skeleton msg
withShape shape (Skeleton cfg) =
    Skeleton { cfg | shape = Just shape }


{-| Set the loading animation (`animation` attribute). The element defaults to
`Wave`.
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
