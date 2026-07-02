module M3e.Cem.FocusRing exposing ( focusRing, disabled, inward, for )

{-|
Middle layer for `<m3e-focus-ring>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.FocusRing` module for everyday use.

@docs focusRing, disabled, inward, for
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.FocusRing
import M3e.Value


{-| A focus ring used to depict a strong focus indicator. -}
focusRing :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , inward : M3e.Value.Supported
    , for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
focusRing attributes children =
    M3e.Cem.Html.FocusRing.focusRing
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the focus events will not trigger the focus ring.
Focus rings can be still controlled manually by using the `show` and `hide` methods. (default: `false`)
-}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.FocusRing.disabled


{-| Whether the focus ring animates inward instead of outward. (default: `false`) -}
inward : Bool -> M3e.Cem.Attr.Attr { c | inward : M3e.Value.Supported } msg
inward =
    M3e.Cem.Attr.attribute M3e.Cem.Html.FocusRing.inward


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.attribute M3e.Cem.Html.FocusRing.for