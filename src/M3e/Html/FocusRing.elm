module M3e.Html.FocusRing exposing (focusRing, disabled, inward, for)

{-| Middle layer for `<m3e-focus-ring>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.FocusRing` module for everyday use.

@docs focusRing, disabled, inward, for

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.FocusRing
import M3e.Token


{-| A focus ring used to depict a strong focus indicator.

**Component Info:**

  - **Extends:** `LitElement`

-}
focusRing :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , inward : M3e.Token.Supported
            , for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
focusRing attributes children =
    M3e.Raw.FocusRing.focusRing
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether the focus events will not trigger the focus ring.
Focus rings can be still controlled manually by using the `show` and `hide` methods. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.FocusRing.disabled


{-| Whether the focus ring animates inward instead of outward. (default: `false`)
-}
inward : Bool -> M3e.Html.Attr.Attr { c | inward : M3e.Token.Supported } msg
inward =
    M3e.Html.Attr.Internal.attribute M3e.Raw.FocusRing.inward


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> M3e.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.Attr.Internal.attribute M3e.Raw.FocusRing.for
