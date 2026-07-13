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

import M3e.Html.SelectionList
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-selection-list>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
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
            (Markup.Element.Element
                { listOption : M3e.Kind.Brand
                , expandableListItem : M3e.Kind.Brand
                , divider : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | selectionList : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.SelectionList.selectionList
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether to hide the selection indicator. (default: `false`)
-}
hideSelectionIndicator :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | hideSelectionIndicator : M3e.Token.Supported
            }
            msg
hideSelectionIndicator =
    M3e.Html.SelectionList.hideSelectionIndicator


{-| Whether multiple items can be selected. (default: `false`)
-}
multi : Bool -> Markup.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
multi =
    M3e.Html.SelectionList.multi


{-| The appearance variant of the list. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { segmented : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.SelectionList.variant


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.SelectionList.name


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.SelectionList.disabled


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.SelectionList.onChange


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.SelectionList.onBeforeinput


{-| Listen for `input` events.
-}
onInput : msg -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.SelectionList.onInput
