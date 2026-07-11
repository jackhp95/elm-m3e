module M3e.ListOption exposing
    ( view, disabled, selected, value, onBeforeinput, onInput
    , onChange, onClick, leading, overline, supportingText, trailing
    )

{-| A selectable option in a list.

**Component Info:**

  - **Extends:** `M3eListItemElement` from `/src/list/ListItemElement`

**Events:**

  - `beforeinput`: Dispatched before the selected state changes.
  - `input`: Dispatched when the selected state changes.
  - `change`: Dispatched when the selected state changes.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `leading`: Renders the leading content of the list item.
  - `overline`: Renders the overline of the list item.
  - `supporting-text`: Renders the supporting text of the list item.
  - `trailing`: Renders the trailing content of the list item.

@docs view, disabled, selected, value, onBeforeinput, onInput
@docs onChange, onClick, leading, overline, supportingText, trailing

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.ListOption
import M3e.Node
import M3e.Token


{-| Build the `<m3e-list-option>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , value : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (M3e.Element.Element
                { text : M3e.Token.Supported
                , html : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | listOption : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.ListOption.listOption
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.ListOption.disabled


{-| Whether the element is selected. (default: `false`)
-}
selected : Bool -> M3e.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
selected =
    M3e.Html.ListOption.selected


{-| A string representing the value of the option.
-}
value : String -> M3e.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    M3e.Html.ListOption.value


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.ListOption.onBeforeinput


{-| Listen for `input` events.
-}
onInput :
    (Bool -> msg)
    -> M3e.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.ListOption.onInput


{-| Listen for `change` events.
-}
onChange :
    (Bool -> msg)
    -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.ListOption.onChange


{-| Listen for `click` events.
-}
onClick : msg -> M3e.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.ListOption.onClick


{-| Place content in the `leading` slot.
-}
leading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , avatar : M3e.Token.Supported
        , text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
leading el =
    M3e.Element.Internal.placeSlot "leading" el


{-| Place content in the `overline` slot.
-}
overline :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
overline el =
    M3e.Element.Internal.placeSlot "overline" el


{-| Place content in the `supporting-text` slot.
-}
supportingText :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
supportingText el =
    M3e.Element.Internal.placeSlot "supporting-text" el


{-| Place content in the `trailing` slot.
-}
trailing :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , avatar : M3e.Token.Supported
        , text : M3e.Token.Supported
        , html : M3e.Token.Supported
        , switch : M3e.Token.Supported
        , radio : M3e.Token.Supported
        , checkbox : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
trailing el =
    M3e.Element.Internal.placeSlot "trailing" el
