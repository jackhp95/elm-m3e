module M3e.Html.Tooltip exposing
    ( tooltip, disabled, for, hideDelay, position, showDelay
    , touchGestures
    )

{-| Middle layer for `<m3e-tooltip>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Tooltip` module for everyday use.

@docs tooltip, disabled, for, hideDelay, position, showDelay
@docs touchGestures

-}

import Html
import M3e.Raw.Tooltip
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| Adds additional context to a button or other UI element.

**Component Info:**

  - **Extends:** `TooltipElementBase` from `/src/tooltip/TooltipElementBase`

-}
tooltip :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , hideDelay : M3e.Token.Supported
            , position : M3e.Token.Supported
            , showDelay : M3e.Token.Supported
            , touchGestures : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
tooltip attributes children =
    M3e.Raw.Tooltip.tooltip
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Tooltip.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Tooltip.for


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`)
-}
hideDelay : Float -> Markup.Html.Attr.Attr { c | hideDelay : M3e.Token.Supported } msg
hideDelay =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Tooltip.hideDelay


{-| The position of the tooltip. (default: `"below"`)
-}
position :
    M3e.Token.Value
        { above : M3e.Token.Supported
        , after : M3e.Token.Supported
        , before : M3e.Token.Supported
        , below : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
position v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Tooltip.position
        (M3e.Token.toString v_)


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`)
-}
showDelay : Float -> Markup.Html.Attr.Attr { c | showDelay : M3e.Token.Supported } msg
showDelay =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Tooltip.showDelay


{-| The mode in which to handle touch gestures. (default: `"auto"`)
-}
touchGestures :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , off : M3e.Token.Supported
        , on : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | touchGestures : M3e.Token.Supported } msg
touchGestures v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Tooltip.touchGestures
        (M3e.Token.toString v_)
