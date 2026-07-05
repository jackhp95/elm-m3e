module M3e.Cem.BreadcrumbItemButton exposing
    ( breadcrumbItemButton, current, href, target, rel, download
    , disabled, onClick
    )

{-|
Middle layer for `<m3e-breadcrumb-item-button>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.BreadcrumbItemButton` module for everyday use.

@docs breadcrumbItemButton, current, href, target, rel, download
@docs disabled, onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.BreadcrumbItemButton
import M3e.Value


{-| Create a m3e-breadcrumb-item-button element

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `click`: No description
-}
breadcrumbItemButton :
    List (M3e.Cem.Attr.Attr { current : M3e.Value.Supported
    , href : M3e.Value.Supported
    , target : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , download : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
breadcrumbItemButton attributes children =
    M3e.Cem.Html.BreadcrumbItemButton.breadcrumbItemButton
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Indicates the current item in the breadcrumb path. -}
current :
    M3e.Value.Value { date : M3e.Value.Supported
    , location : M3e.Value.Supported
    , page : M3e.Value.Supported
    , step : M3e.Value.Supported
    , time : M3e.Value.Supported
    , true : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | current : M3e.Value.Supported } msg
current v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.BreadcrumbItemButton.current
        (M3e.Value.toString v_)


{-| The URL to which the link button points. (default: `""`) -}
href : String -> M3e.Cem.Attr.Attr { c | href : M3e.Value.Supported } msg
href =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.BreadcrumbItemButton.href


{-| The target of the link button. (default: `""`) -}
target : String -> M3e.Cem.Attr.Attr { c | target : M3e.Value.Supported } msg
target =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.BreadcrumbItemButton.target


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> M3e.Cem.Attr.Attr { c | rel : M3e.Value.Supported } msg
rel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.BreadcrumbItemButton.rel


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download :
    String -> M3e.Cem.Attr.Attr { c | download : M3e.Value.Supported } msg
download =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.BreadcrumbItemButton.download


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.BreadcrumbItemButton.disabled


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.BreadcrumbItemButton.onClick
        (Json.Decode.succeed f_)