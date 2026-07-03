module M3e.Cem.Badge exposing ( badge, size, position, for )

{-|
Middle layer for `<m3e-badge>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Badge` module for everyday use.

@docs badge, size, position, for
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Badge
import M3e.Value


{-| A visual indicator used to label content.

**Component Info:**
- **Extends:** `LitElement`
-}
badge :
    List (M3e.Cem.Attr.Attr { size : M3e.Value.Supported
    , position : M3e.Value.Supported
    , for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
badge attributes children =
    M3e.Cem.Html.Badge.badge
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The size of the badge. (default: `"medium"`) -}
size :
    M3e.Value.Value { large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Badge.size (M3e.Value.toString v_)


{-| The position of the badge, when attached to another element. (default: `"above-after"`) -}
position :
    M3e.Value.Value { above : M3e.Value.Supported
    , aboveAfter : M3e.Value.Supported
    , aboveBefore : M3e.Value.Supported
    , after : M3e.Value.Supported
    , before : M3e.Value.Supported
    , below : M3e.Value.Supported
    , belowAfter : M3e.Value.Supported
    , belowBefore : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | position : M3e.Value.Supported } msg
position v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Badge.position (M3e.Value.toString v_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Badge.for