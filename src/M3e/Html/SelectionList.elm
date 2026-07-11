module M3e.Html.SelectionList exposing
    ( selectionList, hideSelectionIndicator, multi, variant, name, disabled
    , onChange, onBeforeinput, onInput
    )

{-| Middle layer for `<m3e-selection-list>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.SelectionList` module for everyday use.

@docs selectionList, hideSelectionIndicator, multi, variant, name, disabled
@docs onChange, onBeforeinput, onInput

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.SelectionList
import M3e.Token


{-| A list of selectable options.

**Component Info:**

  - **Extends:** `M3eListElement` from `/src/list/ListElement`

**Events:**

  - `change`: Dispatched when the selected state of an option changes.
  - `beforeinput`: Dispatched before the selected state of an option changes.
  - `input`: Dispatched when the selected state of an option changes.

-}
selectionList :
    List
        (M3e.Html.Attr.Attr
            { hideSelectionIndicator : M3e.Token.Supported
            , multi : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , name : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
selectionList attributes children =
    M3e.Raw.SelectionList.selectionList
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether to hide the selection indicator. (default: `false`)
-}
hideSelectionIndicator :
    Bool
    ->
        M3e.Html.Attr.Attr
            { c
                | hideSelectionIndicator : M3e.Token.Supported
            }
            msg
hideSelectionIndicator =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.SelectionList.hideSelectionIndicator


{-| Whether multiple items can be selected. (default: `false`)
-}
multi : Bool -> M3e.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
multi =
    M3e.Html.Attr.Internal.attribute M3e.Raw.SelectionList.multi


{-| The appearance variant of the list. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { segmented : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.SelectionList.variant
        (M3e.Token.toString v_)


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> M3e.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.Attr.Internal.attribute M3e.Raw.SelectionList.name


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.SelectionList.disabled


{-| Listen for `change` events.
-}
onChange : msg -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.SelectionList.onChange
        (Json.Decode.succeed f_)


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> M3e.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.SelectionList.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events.
-}
onInput : msg -> M3e.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.SelectionList.onInput
        (Json.Decode.succeed f_)
