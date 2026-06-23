module Ui.Shape exposing
    ( Shape, new
    , withId, withClass, withContent
    , view
    )

{-| Typed builder for M3 shapes. Wraps `M3e.Shape`. Shape sizing comes
from utility classes (height/width); pass them via `withClass`.

    Ui.Shape.new
        |> Ui.Shape.withId "circle"
        |> Ui.Shape.withClass "ds-w-16"
        |> Ui.Shape.withClass "ds-h-16"
        |> Ui.Shape.view


# Construction

@docs Shape, new


# Modifiers

@docs withId, withClass, withContent


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import M3e.Shape


type Shape msg
    = Shape (Config msg)


type alias Config msg =
    { id : Maybe String
    , classes : List String
    , content : List (Html msg)
    }


new : Shape msg
new =
    Shape { id = Nothing, classes = [], content = [] }


withId : String -> Shape msg -> Shape msg
withId id (Shape cfg) =
    Shape { cfg | id = Just id }


withClass : String -> Shape msg -> Shape msg
withClass cls (Shape cfg) =
    Shape { cfg | classes = cls :: cfg.classes }


withContent : List (Html msg) -> Shape msg -> Shape msg
withContent content (Shape cfg) =
    Shape { cfg | content = content }


view : Shape msg -> Html msg
view (Shape cfg) =
    M3e.Shape.component
        (List.filterMap identity [ Maybe.map Attr.id cfg.id ]
            ++ List.map Attr.class cfg.classes
        )
        cfg.content
