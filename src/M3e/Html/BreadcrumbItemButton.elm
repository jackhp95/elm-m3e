module M3e.Html.BreadcrumbItemButton exposing
    ( breadcrumbItemButton, current, href, target, rel, download
    , disabled, onClick
    )

{-| Middle layer for `<m3e-breadcrumb-item-button>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.BreadcrumbItemButton` module for everyday use.

@docs breadcrumbItemButton, current, href, target, rel, download
@docs disabled, onClick

-}

import Html
import Json.Decode
import M3e.Raw.BreadcrumbItemButton
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| Create a m3e-breadcrumb-item-button element

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `click`: No description

-}
breadcrumbItemButton :
    List
        (Markup.Html.Attr.Attr
            { current : M3e.Token.Supported
            , href : M3e.Token.Supported
            , target : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , download : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
breadcrumbItemButton attributes children =
    M3e.Raw.BreadcrumbItemButton.breadcrumbItemButton
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Indicates the current item in the breadcrumb path.
-}
current :
    M3e.Token.Value
        { date : M3e.Token.Supported
        , location : M3e.Token.Supported
        , page : M3e.Token.Supported
        , step : M3e.Token.Supported
        , time : M3e.Token.Supported
        , true : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
current v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.BreadcrumbItemButton.current
        (M3e.Token.toString v_)


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Markup.Html.Attr.Attr { c | href : M3e.Token.Supported } msg
href =
    Markup.Html.Attr.Internal.attribute M3e.Raw.BreadcrumbItemButton.href


{-| The target of the link button. (default: `""`)
-}
target : String -> Markup.Html.Attr.Attr { c | target : M3e.Token.Supported } msg
target =
    Markup.Html.Attr.Internal.attribute M3e.Raw.BreadcrumbItemButton.target


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Markup.Html.Attr.Attr { c | rel : M3e.Token.Supported } msg
rel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.BreadcrumbItemButton.rel


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Markup.Html.Attr.Attr { c | download : M3e.Token.Supported } msg
download =
    Markup.Html.Attr.Internal.attribute M3e.Raw.BreadcrumbItemButton.download


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.BreadcrumbItemButton.disabled


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.BreadcrumbItemButton.onClick
        (Json.Decode.succeed f_)
