module M3e.Html.FocusRing exposing (focusRing, disabled, inward, for)

{-| Middle layer for `<m3e-focus-ring>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.FocusRing` module for everyday use.

@docs focusRing, disabled, inward, for

-}

import Html
import M3e.Raw.FocusRing
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A focus ring used to depict a strong focus indicator.

**Component Info:**

  - **Extends:** `LitElement`

-}
focusRing :
    List
        (Markup.Html.Attr.Attr
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
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the focus events will not trigger the focus ring.
Focus rings can be still controlled manually by using the `show` and `hide` methods. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.FocusRing.disabled


{-| Whether the focus ring animates inward instead of outward. (default: `false`)
-}
inward : Bool -> Markup.Html.Attr.Attr { c | inward : M3e.Token.Supported } msg
inward =
    Markup.Html.Attr.Internal.attribute M3e.Raw.FocusRing.inward


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    Markup.Html.Attr.Internal.attribute M3e.Raw.FocusRing.for
