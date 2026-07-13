module M3e.PseudoCheckbox exposing (view, checked, disabled, indeterminate)

{-| An element which looks like a checkbox.

**Component Info:**

  - **Extends:** `LitElement`

@docs view, checked, disabled, indeterminate

-}

import M3e.Html.PseudoCheckbox
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-pseudo-checkbox>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { checked : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , indeterminate : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | pseudoCheckbox : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.PseudoCheckbox.pseudoCheckbox
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| A value indicating whether the element is checked. (default: `false`)
-}
checked : Bool -> Markup.Html.Attr.Attr { c | checked : M3e.Token.Supported } msg
checked =
    M3e.Html.PseudoCheckbox.checked


{-| A value indicating whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.PseudoCheckbox.disabled


{-| A value indicating whether the element's checked state is indeterminate. (default: `false`)
-}
indeterminate :
    Bool
    -> Markup.Html.Attr.Attr { c | indeterminate : M3e.Token.Supported } msg
indeterminate =
    M3e.Html.PseudoCheckbox.indeterminate
