module M3e.Html.Badge exposing (badge, size, position, for)

{-| Middle layer for `<m3e-badge>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Badge` module for everyday use.

@docs badge, size, position, for

-}

import Html
import M3e.Raw.Badge
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A visual indicator used to label content.

**Component Info:**

  - **Extends:** `LitElement`

-}
badge :
    List
        (Markup.Html.Attr.Attr
            { size : M3e.Token.Supported
            , position : M3e.Token.Supported
            , for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
badge attributes children =
    M3e.Raw.Badge.badge
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| The size of the badge. (default: `"medium"`)
-}
size :
    M3e.Token.Value
        { large : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , small : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
size v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Badge.size
        (M3e.Token.toString v_)


{-| The position of the badge, when attached to another element. (default: `"above-after"`)
-}
position :
    M3e.Token.Value
        { above : M3e.Token.Supported
        , aboveAfter : M3e.Token.Supported
        , aboveBefore : M3e.Token.Supported
        , after : M3e.Token.Supported
        , before : M3e.Token.Supported
        , below : M3e.Token.Supported
        , belowAfter : M3e.Token.Supported
        , belowBefore : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
position v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Badge.position
        (M3e.Token.toString v_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Badge.for
