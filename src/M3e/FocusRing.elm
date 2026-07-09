module M3e.FocusRing exposing ( view, disabled, inward, for )

{-|
A focus ring used to depict a strong focus indicator.

**Component Info:**
- **Extends:** `LitElement`

@docs view, disabled, inward, for
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.FocusRing
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-focus-ring>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , inward : M3e.Value.Supported
    , for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | focusRing : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.FocusRing.focusRing
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether the focus events will not trigger the focus ring.
Focus rings can be still controlled manually by using the `show` and `hide` methods. (default: `false`)
-}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.FocusRing.disabled


{-| Whether the focus ring animates inward instead of outward. (default: `false`) -}
inward : Bool -> M3e.Cem.Attr.Attr { c | inward : M3e.Value.Supported } msg
inward =
    M3e.Cem.FocusRing.inward


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.FocusRing.for