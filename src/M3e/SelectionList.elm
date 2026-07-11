module M3e.SelectionList exposing
    ( view, hideSelectionIndicator, multi, variant, name, disabled
    , onChange, onBeforeinput, onInput
    )

{-| A list of selectable options.

**Component Info:**

  - **Extends:** `M3eListElement` from `/src/list/ListElement`

**Events:**

  - `change`: Dispatched when the selected state of an option changes.
  - `beforeinput`: Dispatched before the selected state of an option changes.
  - `input`: Dispatched when the selected state of an option changes.

@docs view, hideSelectionIndicator, multi, variant, name, disabled
@docs onChange, onBeforeinput, onInput

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.SelectionList
import M3e.Node
import M3e.Token


{-| Build the `<m3e-selection-list>` element (lazy IR).
-}
view :
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
    ->
        List
            (M3e.Element.Element
                { listOption : M3e.Token.Supported
                , expandableListItem : M3e.Token.Supported
                , divider : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | selectionList : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.SelectionList.selectionList
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


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
    M3e.Html.SelectionList.hideSelectionIndicator


{-| Whether multiple items can be selected. (default: `false`)
-}
multi : Bool -> M3e.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
multi =
    M3e.Html.SelectionList.multi


{-| The appearance variant of the list. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { segmented : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.SelectionList.variant


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> M3e.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.SelectionList.name


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.SelectionList.disabled


{-| Listen for `change` events.
-}
onChange : msg -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.SelectionList.onChange


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> M3e.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.SelectionList.onBeforeinput


{-| Listen for `input` events.
-}
onInput : msg -> M3e.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.SelectionList.onInput
