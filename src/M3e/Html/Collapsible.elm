module M3e.Html.Collapsible exposing
    ( collapsible, open, orientation, noAnimate, onOpening, onOpened
    , onClosing, onClosed
    )

{-| Middle layer for `<m3e-collapsible>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Collapsible` module for everyday use.

@docs collapsible, open, orientation, noAnimate, onOpening, onOpened
@docs onClosing, onClosed

-}

import Html
import Json.Decode
import M3e.Raw.Collapsible
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A container used to expand and collapse content.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `opening`: Dispatched when the collapsible begins to open.
  - `opened`: Dispatched when the collapsible has opened.
  - `closing`: Dispatched when the collapsible begins to close.
  - `closed`: Dispatched when the collapsible has closed.

-}
collapsible :
    List
        (Markup.Html.Attr.Attr
            { open : M3e.Token.Supported
            , orientation : M3e.Token.Supported
            , noAnimate : M3e.Token.Supported
            , onOpening : M3e.Token.Supported
            , onOpened : M3e.Token.Supported
            , onClosing : M3e.Token.Supported
            , onClosed : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
collapsible attributes children =
    M3e.Raw.Collapsible.collapsible
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether content is visible. (default: `false`)
-}
open : Bool -> Markup.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Collapsible.open


{-| Orientation of collapsible content. (default: `"vertical"`)
-}
orientation :
    M3e.Token.Value
        { horizontal : M3e.Token.Supported
        , vertical : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | orientation : M3e.Token.Supported } msg
orientation v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Collapsible.orientation
        (M3e.Token.toString v_)


{-| Whether to disable animation. (default: `false`)
-}
noAnimate : Bool -> Markup.Html.Attr.Attr { c | noAnimate : M3e.Token.Supported } msg
noAnimate =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Collapsible.noAnimate


{-| Listen for `opening` events.
-}
onOpening : msg -> Markup.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Collapsible.onOpening
        (Json.Decode.succeed f_)


{-| Listen for `opened` events.
-}
onOpened : msg -> Markup.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Collapsible.onOpened
        (Json.Decode.succeed f_)


{-| Listen for `closing` events.
-}
onClosing : msg -> Markup.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Collapsible.onClosing
        (Json.Decode.succeed f_)


{-| Listen for `closed` events.
-}
onClosed : msg -> Markup.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Collapsible.onClosed
        (Json.Decode.succeed f_)
