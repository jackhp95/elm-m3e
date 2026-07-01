module M3e.Cem.PseudoRadio exposing (checked, disabled, pseudoRadio)

{-| 
@docs pseudoRadio, checked, disabled
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.PseudoRadio
import M3e.Value


{-| An element which looks like a radio button. -}
pseudoRadio :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
pseudoRadio attributes children =
    M3e.Cem.Html.PseudoRadio.pseudoRadio
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| A value indicating whether the element is checked. (default: `false`) -}
checked : Bool -> M3e.Cem.Attr.Attr { c | checked : M3e.Value.Supported } msg
checked =
    M3e.Cem.Attr.attribute M3e.Cem.Html.PseudoRadio.checked


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.PseudoRadio.disabled