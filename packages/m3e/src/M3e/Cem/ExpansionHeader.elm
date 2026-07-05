module M3e.Cem.ExpansionHeader exposing
    ( expansionHeader, hideToggle, toggleDirection, togglePosition, disabled, onClick
    )

{-|
Middle layer for `<m3e-expansion-header>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ExpansionHeader` module for everyday use.

@docs expansionHeader, hideToggle, toggleDirection, togglePosition, disabled, onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.ExpansionHeader
import M3e.Value


{-| A button used to toggle the expanded state of an expansion panel.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `toggle-icon`: Renders the icon of the expansion toggle.
-}
expansionHeader :
    List (M3e.Cem.Attr.Attr { hideToggle : M3e.Value.Supported
    , toggleDirection : M3e.Value.Supported
    , togglePosition : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
expansionHeader attributes children =
    M3e.Cem.Html.ExpansionHeader.expansionHeader
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle :
    Bool -> M3e.Cem.Attr.Attr { c | hideToggle : M3e.Value.Supported } msg
hideToggle =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.ExpansionHeader.hideToggle


{-| The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirection :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | toggleDirection : M3e.Value.Supported } msg
toggleDirection v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.ExpansionHeader.toggleDirection
        (M3e.Value.toString v_)


{-| The position of the expansion toggle. (default: `"after"`) -}
togglePosition :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | togglePosition : M3e.Value.Supported } msg
togglePosition v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.ExpansionHeader.togglePosition
        (M3e.Value.toString v_)


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.ExpansionHeader.disabled


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.ExpansionHeader.onClick
        (Json.Decode.succeed f_)