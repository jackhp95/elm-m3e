module M3e.Record.FilterChip exposing
    ( view, disabled, disabledInteractive, selected, value, variant
    , onBeforeinput, onInput, onChange, onClick, icon, trailingIcon
    )

{-| A chip users interact with to select/deselect options.

**Component Info:**

  - **Extends:** `M3eChipElement` from `/src/chips/ChipElement`

**Events:**

  - `beforeinput`: Dispatched before the selected state changes.
  - `input`: Dispatched when the selected state changes.
  - `change`: Dispatched when the selected state changes.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the chip's label.
  - `trailing-icon`: Renders an icon after the chip's label.

@docs view, disabled, disabledInteractive, selected, value, variant
@docs onBeforeinput, onInput, onChange, onClick, icon, trailingIcon

-}

import M3e.Html.FilterChip
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-filter-chip>` element (lazy IR).
-}
view :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    ->
        List
            (Markup.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , disabledInteractive : M3e.Token.Supported
                , selected : M3e.Token.Supported
                , value : M3e.Token.Supported
                , variant : M3e.Token.Supported
                , onBeforeinput : M3e.Token.Supported
                , onInput : M3e.Token.Supported
                , onChange : M3e.Token.Supported
                , onClick : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | filterChip : M3e.Kind.Brand } msg
view req_ attributes content_ =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.FilterChip.filterChip
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.append
                [ Markup.Element.toNode req_.content ]
                (List.map Markup.Element.toNode content_)
            )
        )


{-| A value indicating whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.FilterChip.disabled


{-| A value indicating whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | disabledInteractive : M3e.Token.Supported
            }
            msg
disabledInteractive =
    M3e.Html.FilterChip.disabledInteractive


{-| A value indicating whether the element is selected. (default: `false`)
-}
selected : Bool -> Markup.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
selected =
    M3e.Html.FilterChip.selected


{-| A string representing the value of the chip.
-}
value : String -> Markup.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    M3e.Html.FilterChip.value


{-| The appearance variant of the chip. (default: `"outlined"`)
-}
variant :
    M3e.Token.Value
        { elevated : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.FilterChip.variant


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.FilterChip.onBeforeinput


{-| Listen for `input` events.
-}
onInput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.FilterChip.onInput


{-| Listen for `change` events.
-}
onChange :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.FilterChip.onChange


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.FilterChip.onClick


{-| Place content in the `icon` slot.
-}
icon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
icon el =
    Markup.Element.Internal.placeSlot "icon" el


{-| Place content in the `trailing-icon` slot.
-}
trailingIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
trailingIcon el =
    Markup.Element.Internal.placeSlot "trailing-icon" el
