module M3e.Cem.Icon exposing (icon)

import Html exposing (Html)
import M3e.Cem.Attr as Attr exposing (Attr)
import M3e.Cem.Html.Icon as Bottom
import M3e.Value exposing (Supported)

icon : List (Attr { slot : Supported } msg) -> List (Html msg) -> Html msg
icon attrs children = Bottom.icon (List.map Attr.toAttribute attrs) children
