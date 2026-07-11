module M3e.Html.FabMenu exposing (fabMenu, variant, onBeforetoggle, onToggle)

{-| Middle layer for `<m3e-fab-menu>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.FabMenu` module for everyday use.

@docs fabMenu, variant, onBeforetoggle, onToggle

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.FabMenu
import M3e.Token


{-| A menu, opened from a floating action button (FAB), used to display multiple related actions.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

-}
fabMenu :
    List
        (M3e.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
fabMenu attributes children =
    M3e.Raw.FabMenu.fabMenu
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| The appearance variant of the menu. (default: `"primary"`)
-}
variant :
    M3e.Token.Value
        { primary : M3e.Token.Supported
        , secondary : M3e.Token.Supported
        , tertiary : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.FabMenu.variant
        (M3e.Token.toString v_)


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle : msg -> M3e.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.FabMenu.onBeforetoggle
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events.
-}
onToggle : msg -> M3e.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.FabMenu.onToggle
        (Json.Decode.succeed f_)
