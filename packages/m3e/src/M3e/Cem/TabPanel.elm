module M3e.Cem.TabPanel exposing ( tabPanel )

{-|
Middle layer for `<m3e-tab-panel>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.TabPanel` module for everyday use.

@docs tabPanel
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.TabPanel
import M3e.Value


{-| A panel presented for a tab. -}
tabPanel :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
tabPanel attributes children =
    M3e.Cem.Html.TabPanel.tabPanel
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children