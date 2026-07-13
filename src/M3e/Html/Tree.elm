module M3e.Html.Tree exposing (tree, multi, cascade, onChange)

{-| Middle layer for `<m3e-tree>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Tree` module for everyday use.

@docs tree, multi, cascade, onChange

-}

import Html
import Json.Decode
import M3e.Raw.Tree
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| Presents hierarchical data in a tree structure.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `change`: Dispatched when the selected state changes.

-}
tree :
    List
        (Markup.Html.Attr.Attr
            { multi : M3e.Token.Supported
            , cascade : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
tree attributes children =
    M3e.Raw.Tree.tree
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether multiple items can be selected. (default: `false`)
-}
multi : Bool -> Markup.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
multi =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Tree.multi


{-| Whether multiple item selection cascades to child items. (default: `false`)
-}
cascade : Bool -> Markup.Html.Attr.Attr { c | cascade : M3e.Token.Supported } msg
cascade =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Tree.cascade


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Tree.onChange
        (Json.Decode.succeed f_)
