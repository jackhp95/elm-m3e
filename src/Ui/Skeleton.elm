module Ui.Skeleton exposing
    ( Skeleton, new
    , withAttributes
    , withId, withClass
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


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , classes : List String
    }


{-| Construct a fresh skeleton placeholder.
-}
new : Skeleton msg
new =
    Skeleton { id = Nothing, attributes = [], classes = [] }


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


{-| Render the skeleton.
-}
view : Skeleton msg -> Html msg
view (Skeleton cfg) =
    M3e.Skeleton.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id ]
            ++ List.map Attr.class cfg.classes
        )
        []
