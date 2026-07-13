module M3e.Tab exposing
    ( view, disabled, for, selected, onBeforeinput, onInput
    , onChange, onClick, icon
    )

{-| An interactive element that, when activated, presents an associated tab panel.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforeinput`: Dispatched before the selected state changes.
  - `input`: Dispatched when the selected state changes.
  - `change`: Dispatched when the selected state changes.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the tab's label.

@docs view, disabled, for, selected, onBeforeinput, onInput
@docs onChange, onClick, icon

-}

import M3e.Html.Tab
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-tab>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | tab : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Tab.tab
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Tab.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.Tab.for


{-| Whether the element is selected. (default: `false`)
-}
selected : Bool -> Markup.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
selected =
    M3e.Html.Tab.selected


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.Tab.onBeforeinput


{-| Listen for `input` events.
-}
onInput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.Tab.onInput


{-| Listen for `change` events.
-}
onChange :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.Tab.onChange


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.Tab.onClick


{-| Place content in the `icon` slot.
-}
icon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
icon el =
    Markup.Element.Internal.placeSlot "icon" el
