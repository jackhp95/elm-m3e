module Ui.Slide exposing
    ( Slide, new
    , withAttributes
    , withId, withVertical, withDisabled
    , withSlides
    , view
    )

{-| Typed builder for an M3 slide group — directional pagination controls
for scrolling through overflowing content. The previous/next buttons surface
only when the content overflows. Wraps `M3e.SlideGroup` and `M3e.Slide`;
each slide is plain `Html msg` content — no separate slide type needed.

Reach for a slide group for directional content paging. To switch between
peer views use tabs; to page through data use a paginator; for an ordered
multi-step flow use `Ui.Stepper`.

A single slide is degenerate but valid (renders one `M3e.Slide` inside
an `M3e.SlideGroup`).


# Construction

@docs Slide, new


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withVertical, withDisabled


# Slides

@docs withSlides


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import M3e.Slide
import M3e.SlideGroup


{-| The slide group opaque type. Build via `new`.
-}
type Slide msg
    = Slide (Config msg)


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , slides : List (List (Html msg))
    , vertical : Bool
    , disabled : Bool
    }


{-| Construct a fresh slide group with no slides.
-}
new : Slide msg
new =
    Slide { id = Nothing, attributes = [], slides = [], vertical = False, disabled = False }


{-| Append attributes to the underlying `<m3e-slide-group>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Slide msg -> Slide msg
withAttributes attributes (Slide cfg) =
    Slide { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> Slide msg -> Slide msg
withId id (Slide cfg) =
    Slide { cfg | id = Just id }


{-| Set vertical orientation (`vertical` on `<m3e-slide-group>`, default
false): content flows and pages top-to-bottom instead of left-to-right.
-}
withVertical : Bool -> Slide msg -> Slide msg
withVertical flag (Slide cfg) =
    Slide { cfg | vertical = flag }


{-| Disable the pagination buttons (`disabled` on `<m3e-slide-group>`,
default false). Content still renders; only the scroll controls go inert.
-}
withDisabled : Bool -> Slide msg -> Slide msg
withDisabled flag (Slide cfg) =
    Slide { cfg | disabled = flag }


{-| Set the slides. Each entry is a list of Html children for one slide.
-}
withSlides : List (List (Html msg)) -> Slide msg -> Slide msg
withSlides ss (Slide cfg) =
    Slide { cfg | slides = ss }


{-| Render the slide group.
-}
view : Slide msg -> Html msg
view (Slide cfg) =
    M3e.SlideGroup.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (M3e.SlideGroup.vertical cfg.vertical)
                , Just (M3e.SlideGroup.disabled cfg.disabled)
                ]
        )
        (List.map viewSlide cfg.slides)


viewSlide : List (Html msg) -> Html msg
viewSlide content =
    M3e.Slide.component [] content
