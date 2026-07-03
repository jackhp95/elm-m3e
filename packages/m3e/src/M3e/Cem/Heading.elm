module M3e.Cem.Heading exposing
    ( heading, emphasized, level, size, variant
    )

{-|
Middle layer for `<m3e-heading>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Heading` module for everyday use.

@docs heading, emphasized, level, size, variant
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Heading
import M3e.Value


{-| A heading to a page or section.

**Component Info:**
- **Extends:** `LitElement`
-}
heading :
    List (M3e.Cem.Attr.Attr { emphasized : M3e.Value.Supported
    , level : M3e.Value.Supported
    , size : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
heading attributes children =
    M3e.Cem.Html.Heading.heading
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the heading uses an emphasized typescale. (default: `false`) -}
emphasized :
    Bool -> M3e.Cem.Attr.Attr { c | emphasized : M3e.Value.Supported } msg
emphasized =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Heading.emphasized


{-| The accessibility level of the heading. -}
level : String -> M3e.Cem.Attr.Attr { c | level : M3e.Value.Supported } msg
level =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Heading.level


{-| The size of the heading. (default: `"medium"`) -}
size :
    M3e.Value.Value { large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Heading.size (M3e.Value.toString v_)


{-| The appearance variant of the heading. (default: `"display"`) -}
variant :
    M3e.Value.Value { display : M3e.Value.Supported
    , headline : M3e.Value.Supported
    , label : M3e.Value.Supported
    , title : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Heading.variant (M3e.Value.toString v_)