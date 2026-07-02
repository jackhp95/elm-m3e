module M3e.Cem.ContentPane exposing ( contentPane )

{-|
Middle layer for `<m3e-content-pane>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ContentPane` module for everyday use.

@docs contentPane
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.ContentPane
import M3e.Value


{-| A shaped surface for vertically scrollable content. -}
contentPane :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
contentPane attributes children =
    M3e.Cem.Html.ContentPane.contentPane
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children