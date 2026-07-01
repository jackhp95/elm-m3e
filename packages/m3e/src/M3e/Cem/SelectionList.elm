module M3e.Cem.SelectionList exposing (disabled, hideSelectionIndicator, multi, name, onBeforeinput, onChange, onInput, selectionList, variant)

{-| 
@docs selectionList, hideSelectionIndicator, multi, variant, name, disabled, onChange, onBeforeinput, onInput
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.SelectionList
import M3e.Value


{-| A list of selectable options.

**Component Info:**
- **Extends:** `M3eListElement` from `/src/list/ListElement`

**Events:**
- `change`: Dispatched when the selected state of an option changes.
- `beforeinput`: Dispatched before the selected state of an option changes.
- `input`: Dispatched when the selected state of an option changes.
-}
selectionList :
    List (M3e.Cem.Attr.Attr { hideSelectionIndicator : M3e.Value.Supported
    , multi : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , name : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
selectionList attributes children =
    M3e.Cem.Html.SelectionList.selectionList
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> M3e.Cem.Attr.Attr { c
        | hideSelectionIndicator : M3e.Value.Supported
    } msg
hideSelectionIndicator =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SelectionList.hideSelectionIndicator


{-| Whether multiple items can be selected. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SelectionList.multi


{-| The appearance variant of the list. (default: `"standard"`) -}
variant :
    M3e.Value.Value { segmented : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.SelectionList.variant
        (M3e.Value.toString v_)


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SelectionList.name


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SelectionList.disabled


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.SelectionList.onChange
        (Json.Decode.succeed f_)


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.SelectionList.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.SelectionList.onInput
        (Json.Decode.succeed f_)