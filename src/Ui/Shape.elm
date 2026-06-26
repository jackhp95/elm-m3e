module Ui.Shape exposing
    ( Shape, new
    , Name
    , withAttributes
    , withId, withName, withClass, withContent
    , view
    )

{-| Typed builder for `<m3e-shape>`. Wraps `M3e.Shape`.

The element clips its slotted (default-slot) content to a named Material 3
shape — drawn from the Material Shape library (`circle`, `pill`,
`heart`, `7-sided-cookie`, …), with built-in morphing between them. Use
it for emphasis and decorative flair: shaped avatars, badges, image
masks. Pick the shape with [`withName`](#withName) (the element's own
`name` attribute, default none — unset leaves content unclipped), and
size it the way you size any element — Material spacing tokens or a
layout class of your own.

    Ui.Shape.new
        |> Ui.Shape.withId "avatar-clip"
        |> Ui.Shape.withName M3e.Shape.Circle
        |> Ui.Shape.withContent
            [ Html.img [ Html.Attributes.src "/avatar.jpg" ] [] ]
        |> Ui.Shape.view

`withClass` remains available for project layout/sizing classes, but the
shape itself comes from `withName`, not from a proprietary `ds-*` class.


# Construction

@docs Shape, new


# Shape name

@docs Name


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withName, withClass, withContent


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import M3e.Shape


{-| The shape opaque type. Build via `new`.
-}
type Shape msg
    = Shape (Config msg)


{-| The set of Material 3 shape names, re-exported from `M3e.Shape`.
Construct values with the `M3e.Shape` constructors (e.g.
`M3e.Shape.Circle`).
-}
type alias Name =
    M3e.Shape.Name


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , name : Maybe Name
    , classes : List String
    , content : List (Html msg)
    }


{-| Construct a fresh shape with no name and no content. With no name set,
the `name` attribute stays unset (default) and the content renders unclipped.
-}
new : Shape msg
new =
    Shape { id = Nothing, attributes = [], name = Nothing, classes = [], content = [] }


{-| Append attributes to the underlying `<m3e-…>` host element — the escape
hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Shape msg -> Shape msg
withAttributes attributes (Shape cfg) =
    Shape { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> Shape msg -> Shape msg
withId id (Shape cfg) =
    Shape { cfg | id = Just id }


{-| Set the Material 3 shape the element clips its content to — the
element's `name` attribute (default none). The value is one of the
Material Shape library names re-exported as [`Name`](#Name).

    Ui.Shape.new
        |> Ui.Shape.withName M3e.Shape.Circle

-}
withName : Name -> Shape msg -> Shape msg
withName name (Shape cfg) =
    Shape { cfg | name = Just name }


{-| Append a CSS class (e.g. for project layout/sizing).
-}
withClass : String -> Shape msg -> Shape msg
withClass cls (Shape cfg) =
    Shape { cfg | classes = cls :: cfg.classes }


{-| Set the content rendered into the element's default slot and clipped to
the shape (an image, an avatar, any markup).
-}
withContent : List (Html msg) -> Shape msg -> Shape msg
withContent content (Shape cfg) =
    Shape { cfg | content = content }


{-| Render the shape.
-}
view : Shape msg -> Html msg
view (Shape cfg) =
    M3e.Shape.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Maybe.map M3e.Shape.name cfg.name
                ]
            ++ List.map Attr.class cfg.classes
        )
        cfg.content
