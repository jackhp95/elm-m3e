module M3e.ButtonSegment exposing
    ( view, checked, disabled, value, onBeforeinput, onInput
    , onChange, onClick, icon
    )

{-| A option that can be selected within a segmented button.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforeinput`: Dispatched before the checked state changes.
  - `input`: Dispatched when the checked state changes.
  - `change`: Dispatched when the checked state changes.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the option's label.

@docs view, checked, disabled, value, onBeforeinput, onInput
@docs onChange, onClick, icon

-}

import M3e.Html.ButtonSegment
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-button-segment>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { checked : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , value : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { sharedText : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | buttonSegment : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.ButtonSegment.buttonSegment
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the element is checked. (default: `false`)
-}
checked : Bool -> Markup.Html.Attr.Attr { c | checked : M3e.Token.Supported } msg
checked =
    M3e.Html.ButtonSegment.checked


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.ButtonSegment.disabled


{-| A string representing the value of the segment. (default: `"on"`)
-}
value : String -> Markup.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    M3e.Html.ButtonSegment.value


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.ButtonSegment.onBeforeinput


{-| Listen for `input` events.
-}
onInput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.ButtonSegment.onInput


{-| Listen for `change` events.
-}
onChange :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.ButtonSegment.onChange


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.ButtonSegment.onClick


{-| Place content in the `icon` slot.
-}
icon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
icon el =
    Markup.Element.Internal.placeSlot "icon" el
