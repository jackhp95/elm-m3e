module M3e.Html.FocusTrap exposing (focusTrap, disabled)

{-| Middle layer for `<m3e-focus-trap>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.FocusTrap` module for everyday use.

@docs focusTrap, disabled

-}

import Html
import M3e.Raw.FocusTrap
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A non-visual element used to trap focus within nested content.

**Component Info:**

  - **Extends:** `LitElement`

-}
focusTrap :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
focusTrap attributes children =
    M3e.Raw.FocusTrap.focusTrap
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Disables the focus trap. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.FocusTrap.disabled
