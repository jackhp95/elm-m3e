module M3e.Cem.SplitButton exposing ( splitButton, variant, size )

{-|
Middle layer for `<m3e-split-button>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.SplitButton` module for everyday use.

@docs splitButton, variant, size
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.SplitButton
import M3e.Value


{-| A button used to show an action with a menu of related actions.

**Component Info:**
- **Extends:** `LitElement`

**Slots:**
- `leading-button`: The leading button used to perform the primary action.
- `trailing-button`: The trailing icon button used to open a menu of related actions.
-}
splitButton :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , size : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
splitButton attributes children =
    M3e.Cem.Html.SplitButton.splitButton
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The appearance variant of the button. (default: `"filled"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    , tonal : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.SplitButton.variant
        (M3e.Value.toString v_)


{-| The size of the button. (default: `"small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SplitButton.size (M3e.Value.toString v_)