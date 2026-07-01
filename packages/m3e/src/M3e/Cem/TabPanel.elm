module M3e.Cem.TabPanel exposing (tabPanel)

{-| 
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