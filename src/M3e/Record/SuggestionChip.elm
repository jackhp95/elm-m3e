module M3e.Record.SuggestionChip exposing
    ( view, disabled, disabledInteractive, name, type_, value
    , variant, icon
    )

{-| A chip used to help narrow a user's intent by presenting dynamically generated suggestions, such as
suggested responses or search filters.

**Component Info:**

  - **Extends:** `M3eChipElement` from `/src/chips/ChipElement`

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the chip's label.
  - `trailing-icon`: Renders an icon after the chip's label.

@docs view, disabled, disabledInteractive, name, type_, value
@docs variant, icon

-}

import M3e.Action
import M3e.Html.SuggestionChip
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-suggestion-chip>` element (lazy IR).
-}
view :
    { content : Markup.Element.Element { text : Markup.Kind.Shared } msg
    , action :
        M3e.Action.Action
            { click : M3e.Token.Supported
            , link : M3e.Token.Supported
            , menuTrigger : M3e.Token.Supported
            , dialogTrigger : M3e.Token.Supported
            , fabMenuTrigger : M3e.Token.Supported
            , bottomSheetTrigger : M3e.Token.Supported
            , navRailToggle : M3e.Token.Supported
            , drawerToggle : M3e.Token.Supported
            , datepickerToggle : M3e.Token.Supported
            , dialogAction : M3e.Token.Supported
            , bottomSheetAction : M3e.Token.Supported
            , richTooltipAction : M3e.Token.Supported
            , stepperReset : M3e.Token.Supported
            , stepperPrevious : M3e.Token.Supported
            }
            msg
    }
    ->
        List
            (Markup.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , disabledInteractive : M3e.Token.Supported
                , name : M3e.Token.Supported
                , type_ : M3e.Token.Supported
                , value : M3e.Token.Supported
                , variant : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | suggestionChip : M3e.Kind.Brand } msg
view req_ attributes content_ =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.SuggestionChip.suggestionChip
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.append
                (List.map
                    Markup.Html.Attr.Internal.forget
                    (M3e.Action.toAttrs req_.action)
                )
                (List.map Markup.Html.Attr.Internal.forget attributes)
            )
            (List.append
                [ M3e.Action.wrapContent
                    req_.action
                    (Markup.Element.toNode req_.content)
                ]
                (List.map Markup.Element.toNode content_)
            )
        )


{-| A value indicating whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.SuggestionChip.disabled


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
    M3e.Html.SuggestionChip.disabledInteractive


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.SuggestionChip.name


{-| The type of the element. (default: `"button"`)
-}
type_ :
    M3e.Token.Value
        { button : M3e.Token.Supported
        , reset : M3e.Token.Supported
        , submit : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | type_ : M3e.Token.Supported } msg
type_ =
    M3e.Html.SuggestionChip.type_


{-| A string representing the value of the chip.
-}
value : String -> Markup.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    M3e.Html.SuggestionChip.value


{-| The appearance variant of the chip. (default: `"outlined"`)
-}
variant :
    M3e.Token.Value
        { elevated : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.SuggestionChip.variant


{-| Place content in the `icon` slot.
-}
icon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
icon el =
    Markup.Element.Internal.placeSlot "icon" el
