module M3e.PseudoCheckbox exposing (view, checked, disabled, indeterminate)

{-| An element which looks like a checkbox.

**Component Info:**

  - **Extends:** `LitElement`

@docs view, checked, disabled, indeterminate

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.PseudoCheckbox
import M3e.Node
import M3e.Token


{-| Build the `<m3e-pseudo-checkbox>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { checked : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , indeterminate : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | pseudoCheckbox : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.PseudoCheckbox.pseudoCheckbox
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| A value indicating whether the element is checked. (default: `false`)
-}
checked : Bool -> M3e.Html.Attr.Attr { c | checked : M3e.Token.Supported } msg
checked =
    M3e.Html.PseudoCheckbox.checked


{-| A value indicating whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.PseudoCheckbox.disabled


{-| A value indicating whether the element's checked state is indeterminate. (default: `false`)
-}
indeterminate : Bool -> M3e.Html.Attr.Attr { c | indeterminate : M3e.Token.Supported } msg
indeterminate =
    M3e.Html.PseudoCheckbox.indeterminate
