module M3e.Html.Toolbar exposing (toolbar, elevated, shape, variant, vertical)

{-| Middle layer for `<m3e-toolbar>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Toolbar` module for everyday use.

@docs toolbar, elevated, shape, variant, vertical

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.Toolbar
import M3e.Token


{-| Presents frequently used actions relevant to the current page.

**Component Info:**

  - **Extends:** `LitElement`

-}
toolbar :
    List
        (M3e.Html.Attr.Attr
            { elevated : M3e.Token.Supported
            , shape : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , vertical : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
toolbar attributes children =
    M3e.Raw.Toolbar.toolbar
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether the toolbar is elevated. (default: `false`)
-}
elevated : Bool -> M3e.Html.Attr.Attr { c | elevated : M3e.Token.Supported } msg
elevated =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Toolbar.elevated


{-| The shape of the toolbar. (default: `"square"`)
-}
shape :
    M3e.Token.Value
        { rounded : M3e.Token.Supported
        , square : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | shape : M3e.Token.Supported } msg
shape v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Toolbar.shape
        (M3e.Token.toString v_)


{-| The appearance variant of the toolbar. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { standard : M3e.Token.Supported
        , vibrant : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Toolbar.variant
        (M3e.Token.toString v_)


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical : Bool -> M3e.Html.Attr.Attr { c | vertical : M3e.Token.Supported } msg
vertical =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Toolbar.vertical
