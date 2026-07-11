module M3e.Html.FocusTrap exposing (focusTrap, disabled)

{-| Middle layer for `<m3e-focus-trap>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.FocusTrap` module for everyday use.

@docs focusTrap, disabled

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.FocusTrap
import M3e.Token


{-| A non-visual element used to trap focus within nested content.

**Component Info:**

  - **Extends:** `LitElement`

-}
focusTrap :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
focusTrap attributes children =
    M3e.Raw.FocusTrap.focusTrap
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Disables the focus trap. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.FocusTrap.disabled
