module M3e.ListAction exposing
    ( view, disabled, download, href, rel, target
    , onClick, leading, overline, supportingText, trailing
    )

{-| An item in a list that performs an action.

**Component Info:**

  - **Extends:** `M3eListItemElement` from `/src/list/ListItemElement`

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `leading`: Renders the leading content of the list item.
  - `overline`: Renders the overline of the list item.
  - `supporting-text`: Renders the supporting text of the list item.
  - `trailing`: Renders the trailing content of the list item.

@docs view, disabled, download, href, rel, target
@docs onClick, leading, overline, supportingText, trailing

-}

import M3e.Html.ListAction
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-list-action>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , download : M3e.Token.Supported
            , href : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , target : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { text : Markup.Kind.Shared
                , dialogTrigger : M3e.Kind.Brand
                , dialogAction : M3e.Kind.Brand
                , menuTrigger : M3e.Kind.Brand
                , fabMenuTrigger : M3e.Kind.Brand
                , bottomSheetTrigger : M3e.Kind.Brand
                , bottomSheetAction : M3e.Kind.Brand
                , stepperPrevious : M3e.Kind.Brand
                , stepperReset : M3e.Kind.Brand
                , richTooltipAction : M3e.Kind.Brand
                , drawerToggle : M3e.Kind.Brand
                , datepickerToggle : M3e.Kind.Brand
                , navRailToggle : M3e.Kind.Brand
                , html : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | listAction : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.ListAction.listAction
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
    M3e.Html.ListAction.disabled


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Markup.Html.Attr.Attr { c | download : M3e.Token.Supported } msg
download =
    M3e.Html.ListAction.download


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Markup.Html.Attr.Attr { c | href : M3e.Token.Supported } msg
href =
    M3e.Html.ListAction.href


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Markup.Html.Attr.Attr { c | rel : M3e.Token.Supported } msg
rel =
    M3e.Html.ListAction.rel


{-| The target of the link button. (default: `""`)
-}
target : String -> Markup.Html.Attr.Attr { c | target : M3e.Token.Supported } msg
target =
    M3e.Html.ListAction.target


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.ListAction.onClick


{-| Place content in the `leading` slot.
-}
leading :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
leading el =
    Markup.Element.Internal.placeSlot "leading" el


{-| Place content in the `overline` slot.
-}
overline :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
overline el =
    Markup.Element.Internal.placeSlot "overline" el


{-| Place content in the `supporting-text` slot.
-}
supportingText :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
supportingText el =
    Markup.Element.Internal.placeSlot "supporting-text" el


{-| Place content in the `trailing` slot.
-}
trailing :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        , switch : M3e.Kind.Brand
        , radio : M3e.Kind.Brand
        , checkbox : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
trailing el =
    Markup.Element.Internal.placeSlot "trailing" el
