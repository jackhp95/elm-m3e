module M3e.FocusRing exposing (view, disabled, inward, for)

{-| A focus ring used to depict a strong focus indicator.

**Component Info:**

  - **Extends:** `LitElement`

@docs view, disabled, inward, for

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.FocusRing
import M3e.Node
import M3e.Token


{-| Build the `<m3e-focus-ring>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , inward : M3e.Token.Supported
            , for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | focusRing : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.FocusRing.focusRing
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| Whether the focus events will not trigger the focus ring.
Focus rings can be still controlled manually by using the `show` and `hide` methods. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.FocusRing.disabled


{-| Whether the focus ring animates inward instead of outward. (default: `false`)
-}
inward : Bool -> M3e.Html.Attr.Attr { c | inward : M3e.Token.Supported } msg
inward =
    M3e.Html.FocusRing.inward


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> M3e.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.FocusRing.for
