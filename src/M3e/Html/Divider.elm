module M3e.Html.Divider exposing (divider, inset, insetStart, insetEnd, vertical)

{-| Middle layer for `<m3e-divider>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Divider` module for everyday use.

@docs divider, inset, insetStart, insetEnd, vertical

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.Divider
import M3e.Token


{-| A thin line that separates content in lists or other containers.

**Component Info:**

  - **Extends:** `LitElement`

-}
divider :
    List
        (M3e.Html.Attr.Attr
            { inset : M3e.Token.Supported
            , insetStart : M3e.Token.Supported
            , insetEnd : M3e.Token.Supported
            , vertical : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
divider attributes children =
    M3e.Raw.Divider.divider
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether the divider is indented with equal padding on both sides. (default: `false`)
-}
inset : Bool -> M3e.Html.Attr.Attr { c | inset : M3e.Token.Supported } msg
inset =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Divider.inset


{-| Whether the divider is indented with padding on the leading side. (default: `false`)
-}
insetStart : Bool -> M3e.Html.Attr.Attr { c | insetStart : M3e.Token.Supported } msg
insetStart =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Divider.insetStart


{-| Whether the divider is indented with padding on the trailing side. (default: `false`)
-}
insetEnd : Bool -> M3e.Html.Attr.Attr { c | insetEnd : M3e.Token.Supported } msg
insetEnd =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Divider.insetEnd


{-| Whether the divider is vertically aligned with adjacent content. (default: `false`)
-}
vertical : Bool -> M3e.Html.Attr.Attr { c | vertical : M3e.Token.Supported } msg
vertical =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Divider.vertical
