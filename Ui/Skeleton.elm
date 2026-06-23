module Ui.Skeleton exposing
    ( Skeleton, new
    , withId, withClass
    , view
    )

{-| Typed builder for M3 skeleton placeholders. Wraps `M3e.Skeleton`.

Sizes for skeletons typically come from Tailwind utility classes
(width + height), not a `size` attribute — so this exposes `withClass`
to pass through utility classes.


# Construction

@docs Skeleton, new


# Modifiers

@docs withId, withClass


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import M3e.Skeleton


type Skeleton msg
    = Skeleton Config


type alias Config =
    { id : Maybe String
    , classes : List String
    }


new : Skeleton msg
new =
    Skeleton { id = Nothing, classes = [] }


withId : String -> Skeleton msg -> Skeleton msg
withId id (Skeleton cfg) =
    Skeleton { cfg | id = Just id }


withClass : String -> Skeleton msg -> Skeleton msg
withClass cls (Skeleton cfg) =
    Skeleton { cfg | classes = cls :: cfg.classes }


view : Skeleton msg -> Html msg
view (Skeleton cfg) =
    M3e.Skeleton.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id ]
            ++ List.map Attr.class cfg.classes
        )
        []
