module M3e.Cem.AppBar exposing ( appBar, centered, for, size )

{-|
Middle layer for `<m3e-app-bar>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.AppBar` module for everyday use.

@docs appBar, centered, for, size
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.AppBar
import M3e.Value


{-| A bar, placed a the top of a screen, used to help users navigate through an application.

**Component Info:**
- **Extends:** `LitElement`

**Slots:**
- `leading`: Renders content positioned at the start of the bar.
- `subtitle`: Renders the subtitle of the bar.
- `title`: Renders the title of the bar.
- `trailing`: Renders one or more action buttons aligned to the end of the bar.
- `leading-icon`: Deprecated: use the `leading` slot.
- `trailing-icon`: Deprecated: use the `trailing` slot.
-}
appBar :
    List (M3e.Cem.Attr.Attr { centered : M3e.Value.Supported
    , for : M3e.Value.Supported
    , size : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
appBar attributes children =
    M3e.Cem.Html.AppBar.appBar
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the title and subtitle are centered. (default: `false`) -}
centered : Bool -> M3e.Cem.Attr.Attr { c | centered : M3e.Value.Supported } msg
centered =
    M3e.Cem.Attr.attribute M3e.Cem.Html.AppBar.centered


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.attribute M3e.Cem.Html.AppBar.for


{-| The size of the bar. (default: `"small"`) -}
size :
    M3e.Value.Value { large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.AppBar.size (M3e.Value.toString v_)