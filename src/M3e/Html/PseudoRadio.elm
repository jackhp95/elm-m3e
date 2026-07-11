module M3e.Html.PseudoRadio exposing (pseudoRadio, checked, disabled)

{-| Middle layer for `<m3e-pseudo-radio>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.PseudoRadio` module for everyday use.

@docs pseudoRadio, checked, disabled

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.PseudoRadio
import M3e.Token


{-| An element which looks like a radio button.

**Component Info:**

  - **Extends:** `LitElement`

-}
pseudoRadio :
    List
        (M3e.Html.Attr.Attr
            { checked : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
pseudoRadio attributes children =
    M3e.Raw.PseudoRadio.pseudoRadio
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| A value indicating whether the element is checked. (default: `false`)
-}
checked : Bool -> M3e.Html.Attr.Attr { c | checked : M3e.Token.Supported } msg
checked =
    M3e.Html.Attr.Internal.attribute M3e.Raw.PseudoRadio.checked


{-| A value indicating whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.PseudoRadio.disabled
