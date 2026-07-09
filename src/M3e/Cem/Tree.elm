module M3e.Cem.Tree exposing ( tree, multi, cascade, onChange )

{-|
Middle layer for `<m3e-tree>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Tree` module for everyday use.

@docs tree, multi, cascade, onChange
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.Tree
import M3e.Value


{-| Presents hierarchical data in a tree structure.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `change`: Dispatched when the selected state changes.
-}
tree :
    List (M3e.Cem.Attr.Attr { multi : M3e.Value.Supported
    , cascade : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
tree attributes children =
    M3e.Cem.Html.Tree.tree
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether multiple items can be selected. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Tree.multi


{-| Whether multiple item selection cascades to child items. (default: `false`) -}
cascade : Bool -> M3e.Cem.Attr.Attr { c | cascade : M3e.Value.Supported } msg
cascade =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Tree.cascade


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Tree.onChange
        (Json.Decode.succeed f_)