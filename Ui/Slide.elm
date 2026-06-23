module Ui.Slide exposing
    ( Slide, new
    , withId, withVertical, withDisabled
    , withSlides
    , view
    )

{-| Typed builder for an M3 slide group. Wraps `M3e.SlideGroup` and
`M3e.Slide`. Each slide is plain `Html msg` content — no separate
slide type needed.

A single slide is degenerate but valid (renders one `M3e.Slide` inside
an `M3e.SlideGroup`).


# Construction

@docs Slide, new


# Modifiers

@docs withId, withVertical, withDisabled


# Slides

@docs withSlides


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import M3e.Slide
import M3e.SlideGroup


type Slide msg
    = Slide (Config msg)


type alias Config msg =
    { id : Maybe String
    , slides : List (List (Html msg))
    , vertical : Bool
    , disabled : Bool
    }


new : Slide msg
new =
    Slide { id = Nothing, slides = [], vertical = False, disabled = False }


withId : String -> Slide msg -> Slide msg
withId id (Slide cfg) =
    Slide { cfg | id = Just id }


withVertical : Bool -> Slide msg -> Slide msg
withVertical flag (Slide cfg) =
    Slide { cfg | vertical = flag }


withDisabled : Bool -> Slide msg -> Slide msg
withDisabled flag (Slide cfg) =
    Slide { cfg | disabled = flag }


{-| Set the slides. Each entry is a list of Html children for one slide.
-}
withSlides : List (List (Html msg)) -> Slide msg -> Slide msg
withSlides ss (Slide cfg) =
    Slide { cfg | slides = ss }


view : Slide msg -> Html msg
view (Slide cfg) =
    M3e.SlideGroup.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Just (M3e.SlideGroup.vertical cfg.vertical)
            , Just (M3e.SlideGroup.disabled cfg.disabled)
            ]
        )
        (List.map viewSlide cfg.slides)


viewSlide : List (Html msg) -> Html msg
viewSlide content =
    M3e.Slide.component [] content
