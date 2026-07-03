module M3e.PseudoCheckbox exposing ( view, checked, disabled, indeterminate )

{-|
An element which looks like a checkbox.

**Component Info:**
- **Extends:** `LitElement`

@docs view, checked, disabled, indeterminate
-}


import M3e.Cem.Attr
import M3e.Cem.PseudoCheckbox
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-pseudo-checkbox>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , indeterminate : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | pseudoCheckbox : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.PseudoCheckbox.pseudoCheckbox
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| A value indicating whether the element is checked. (default: `false`) -}
checked : Bool -> M3e.Cem.Attr.Attr { c | checked : M3e.Value.Supported } msg
checked =
    M3e.Cem.PseudoCheckbox.checked


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.PseudoCheckbox.disabled


{-| A value indicating whether the element's checked state is indeterminate. (default: `false`) -}
indeterminate :
    Bool -> M3e.Cem.Attr.Attr { c | indeterminate : M3e.Value.Supported } msg
indeterminate =
    M3e.Cem.PseudoCheckbox.indeterminate