module M3e.Cem.ButtonGroup exposing ( buttonGroup, multi, size, variant )

{-|
Middle layer for `<m3e-button-group>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ButtonGroup` module for everyday use.

@docs buttonGroup, multi, size, variant
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.ButtonGroup
import M3e.Value


{-| Organizes buttons and adds interactions between them.

**Component Info:**
- **Extends:** `LitElement`
-}
buttonGroup :
    List (M3e.Cem.Attr.Attr { multi : M3e.Value.Supported
    , size : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
buttonGroup attributes children =
    M3e.Cem.Html.ButtonGroup.buttonGroup
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether multiple toggle buttons can be selected. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.ButtonGroup.multi


{-| The size of the group. (default: `"small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.ButtonGroup.size
        (M3e.Value.toString v_)


{-| The appearance variant of the group. (default: `"standard"`) -}
variant :
    M3e.Value.Value { connected : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.ButtonGroup.variant
        (M3e.Value.toString v_)