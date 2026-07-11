module M3e.Html.PseudoCheckbox exposing (pseudoCheckbox, checked, disabled, indeterminate)

{-| Middle layer for `<m3e-pseudo-checkbox>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.PseudoCheckbox` module for everyday use.

@docs pseudoCheckbox, checked, disabled, indeterminate

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.PseudoCheckbox
import M3e.Token


{-| An element which looks like a checkbox.

**Component Info:**

  - **Extends:** `LitElement`

-}
pseudoCheckbox :
    List
        (M3e.Html.Attr.Attr
            { checked : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , indeterminate : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
pseudoCheckbox attributes children =
    M3e.Raw.PseudoCheckbox.pseudoCheckbox
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| A value indicating whether the element is checked. (default: `false`)
-}
checked : Bool -> M3e.Html.Attr.Attr { c | checked : M3e.Token.Supported } msg
checked =
    M3e.Html.Attr.Internal.attribute M3e.Raw.PseudoCheckbox.checked


{-| A value indicating whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.PseudoCheckbox.disabled


{-| A value indicating whether the element's checked state is indeterminate. (default: `false`)
-}
indeterminate : Bool -> M3e.Html.Attr.Attr { c | indeterminate : M3e.Token.Supported } msg
indeterminate =
    M3e.Html.Attr.Internal.attribute M3e.Raw.PseudoCheckbox.indeterminate
