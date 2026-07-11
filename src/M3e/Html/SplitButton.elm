module M3e.Html.SplitButton exposing (splitButton, variant, size)

{-| Middle layer for `<m3e-split-button>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.SplitButton` module for everyday use.

@docs splitButton, variant, size

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.SplitButton
import M3e.Token


{-| A button used to show an action with a menu of related actions.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `leading-button`: The leading button used to perform the primary action.
  - `trailing-button`: The trailing icon button used to open a menu of related actions.

-}
splitButton :
    List
        (M3e.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , size : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
splitButton attributes children =
    M3e.Raw.SplitButton.splitButton
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| The appearance variant of the button. (default: `"filled"`)
-}
variant :
    M3e.Token.Value
        { elevated : M3e.Token.Supported
        , filled : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        , tonal : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.SplitButton.variant
        (M3e.Token.toString v_)


{-| The size of the button. (default: `"small"`)
-}
size :
    M3e.Token.Value
        { extraLarge : M3e.Token.Supported
        , extraSmall : M3e.Token.Supported
        , large : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , small : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
size v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.SplitButton.size
        (M3e.Token.toString v_)
