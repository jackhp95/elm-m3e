module M3e.Collapsible exposing
    ( view, open, orientation, noAnimate, onOpening, onOpened
    , onClosing, onClosed
    )

{-| A container used to expand and collapse content.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `opening`: Dispatched when the collapsible begins to open.
  - `opened`: Dispatched when the collapsible has opened.
  - `closing`: Dispatched when the collapsible begins to close.
  - `closed`: Dispatched when the collapsible has closed.

@docs view, open, orientation, noAnimate, onOpening, onOpened
@docs onClosing, onClosed

-}

import M3e.Html.Collapsible
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-collapsible>` element (lazy IR).
-}
view :
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | collapsible : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Collapsible.collapsible
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether content is visible. (default: `false`)
-}
open : Bool -> Markup.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    M3e.Html.Collapsible.open


{-| Orientation of collapsible content. (default: `"vertical"`)
-}
orientation :
    M3e.Token.Value
        { horizontal : M3e.Token.Supported
        , vertical : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | orientation : M3e.Token.Supported } msg
orientation =
    M3e.Html.Collapsible.orientation


{-| Whether to disable animation. (default: `false`)
-}
noAnimate : Bool -> Markup.Html.Attr.Attr { c | noAnimate : M3e.Token.Supported } msg
noAnimate =
    M3e.Html.Collapsible.noAnimate


{-| Listen for `opening` events.
-}
onOpening : msg -> Markup.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening =
    M3e.Html.Collapsible.onOpening


{-| Listen for `opened` events.
-}
onOpened : msg -> Markup.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened =
    M3e.Html.Collapsible.onOpened


{-| Listen for `closing` events.
-}
onClosing : msg -> Markup.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing =
    M3e.Html.Collapsible.onClosing


{-| Listen for `closed` events.
-}
onClosed : msg -> Markup.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed =
    M3e.Html.Collapsible.onClosed
