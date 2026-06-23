module Ui.Carousel exposing
    ( Carousel
    , new
    , withId, withVertical
    , view
    )

{-| Typed builder for `<m3e-slide-group>` — a scrolling collection of
items (Material 3 [Carousel][m3]).

[m3]: https://m3.material.io/components/carousel/overview


# Type

@docs Carousel


# Constructor

@docs new


# Modifiers

@docs withId, withVertical


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import M3e.Slide
import M3e.SlideGroup


{-| A carousel.
-}
type Carousel msg
    = Carousel (Config msg)


type alias Config msg =
    { id : Maybe String
    , vertical : Bool
    , slides : List (Html msg)
    }


{-| Construct a carousel from a list of slide bodies (each rendered in
its own `<m3e-slide>`).
-}
new : List (Html msg) -> Carousel msg
new slides =
    Carousel
        { id = Nothing
        , vertical = False
        , slides = slides
        }


{-| Set the `id` attribute on the underlying `<m3e-slide-group>`.
-}
withId : String -> Carousel msg -> Carousel msg
withId id (Carousel cfg) =
    Carousel { cfg | id = Just id }


{-| Render slides vertically rather than horizontally.
-}
withVertical : Bool -> Carousel msg -> Carousel msg
withVertical b (Carousel cfg) =
    Carousel { cfg | vertical = b }


{-| Render the carousel.
-}
view : Carousel msg -> Html msg
view (Carousel cfg) =
    M3e.SlideGroup.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Just (M3e.SlideGroup.vertical cfg.vertical)
            ]
        )
        (List.map slideWrap cfg.slides)


slideWrap : Html msg -> Html msg
slideWrap body =
    M3e.Slide.component [] [ body ]
