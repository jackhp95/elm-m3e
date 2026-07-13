module M3e.ListItem exposing (view, leading, overline, supportingText, trailing)

{-| An item in a list.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `leading`: Renders the leading content of the list item.
  - `overline`: Renders the overline of the list item.
  - `supporting-text`: Renders the supporting text of the list item.
  - `trailing`: Renders the trailing content of the list item.

@docs view, leading, overline, supportingText, trailing

-}

import M3e.Html.ListItem
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-list-item>` element (lazy IR).
-}
view :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    ->
        List
            (Markup.Element.Element
                { sharedText : Markup.Kind.Shared
                , html : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | listItem : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.ListItem.listItem
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Place content in the `leading` slot.
-}
leading :
    Markup.Element.Element
        { sharedIcon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , sharedText : Markup.Kind.Shared
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
        { sharedText : Markup.Kind.Shared
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
        { sharedText : Markup.Kind.Shared
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
        { sharedIcon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , sharedText : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        , switch : M3e.Kind.Brand
        , radio : M3e.Kind.Brand
        , checkbox : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
trailing el =
    Markup.Element.Internal.placeSlot "trailing" el
