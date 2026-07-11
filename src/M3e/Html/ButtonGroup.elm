module M3e.Html.ButtonGroup exposing (buttonGroup, multi, size, variant)

{-| Middle layer for `<m3e-button-group>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ButtonGroup` module for everyday use.

@docs buttonGroup, multi, size, variant

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.ButtonGroup
import M3e.Token


{-| Organizes buttons and adds interactions between them.

**Component Info:**

  - **Extends:** `LitElement`

-}
buttonGroup :
    List
        (M3e.Html.Attr.Attr
            { multi : M3e.Token.Supported
            , size : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
buttonGroup attributes children =
    M3e.Raw.ButtonGroup.buttonGroup
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether multiple toggle buttons can be selected. (default: `false`)
-}
multi : Bool -> M3e.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
multi =
    M3e.Html.Attr.Internal.attribute M3e.Raw.ButtonGroup.multi


{-| The size of the group. (default: `"small"`)
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
        M3e.Raw.ButtonGroup.size
        (M3e.Token.toString v_)


{-| The appearance variant of the group. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { connected : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.ButtonGroup.variant
        (M3e.Token.toString v_)
