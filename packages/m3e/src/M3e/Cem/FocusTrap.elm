module M3e.Cem.FocusTrap exposing (disabled, focusTrap)

{-| 
@docs focusTrap, disabled
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.FocusTrap
import M3e.Value


{-| A non-visual element used to trap focus within nested content. -}
focusTrap :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
focusTrap attributes children =
    M3e.Cem.Html.FocusTrap.focusTrap
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Disables the focus trap. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.FocusTrap.disabled