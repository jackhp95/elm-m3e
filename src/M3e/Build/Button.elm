module M3e.Build.Button exposing
    ( Builder, AttrCaps, SlotCaps, button, attr, disabled
    , disabledInteractive, name, selected, shape, size, toggle
    , type_, value, variant, onBeforeinput, onInput, onChange
    , icon, selectedSlot, selectedIcon, trailingIcon, build
    )

{-| The Build form for `<m3e-button>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Button as Button`.

@docs Builder, AttrCaps, SlotCaps, button, attr, disabled
@docs disabledInteractive, name, selected, shape, size, toggle
@docs type_, value, variant, onBeforeinput, onInput, onChange
@docs icon, selectedSlot, selectedIcon, trailingIcon, build

-}

import M3e.Action
import M3e.Build.Internal
import M3e.Html.Button
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-button>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | button : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , disabledInteractive : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , shape : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    , toggle : M3e.Build.Internal.Available
    , type_ : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , selectedIcon : M3e.Build.Internal.Available
    , trailingIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-button>` with the required fields.
-}
button :
    { content :
        Markup.Element.Element
            { sharedText : Markup.Kind.Shared
            , sharedIcon : Markup.Kind.Shared
            , menuTrigger : M3e.Kind.Brand
            , dialogTrigger : M3e.Kind.Brand
            , fabMenuTrigger : M3e.Kind.Brand
            , bottomSheetTrigger : M3e.Kind.Brand
            , navRailToggle : M3e.Kind.Brand
            , drawerToggle : M3e.Kind.Brand
            , datepickerToggle : M3e.Kind.Brand
            , dialogAction : M3e.Kind.Brand
            , bottomSheetAction : M3e.Kind.Brand
            , richTooltipAction : M3e.Kind.Brand
            , stepperReset : M3e.Kind.Brand
            , stepperPrevious : M3e.Kind.Brand
            , stepperNext : M3e.Kind.Brand
            }
            msg
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
            , stepperNext : M3e.Token.Supported
            }
            msg
    }
    -> Builder AttrCaps SlotCaps msg kind
button req_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Button.button
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            (List.map
                Markup.Html.Attr.Internal.forget
                (M3e.Action.toAttrs req_.action)
            )
            [ M3e.Action.wrapContent
                req_.action
                (Markup.Element.toNode req_.content)
            ]
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    Markup.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Button.disabled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive :
    Bool
    ->
        Builder
            { a
                | disabledInteractive : M3e.Build.Internal.Available
            }
            s
            msg
            kind
    -> Builder { a | disabledInteractive : M3e.Build.Internal.Used } s msg kind
disabledInteractive v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Button.disabledInteractive v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form.
-}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | name : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Button.name v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the toggle button is selected. (default: `false`)
-}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | selected : M3e.Build.Internal.Used } s msg kind
selected v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Button.selected v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The shape of the button. (default: `"rounded"`)
-}
shape :
    M3e.Token.Value
        { rounded : M3e.Token.Supported
        , square : M3e.Token.Supported
        }
    -> Builder { a | shape : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | shape : M3e.Build.Internal.Used } s msg kind
shape v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Button.shape v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The size of the button. (default: `"small"`)
-}
size :
    M3e.Token.Value
        { extraLarge : M3e.Token.Supported
        , extraSmall : M3e.Token.Supported
        , large : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , small : M3e.Token.Supported
        }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | size : M3e.Build.Internal.Used } s msg kind
size v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Button.size v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the button will toggle between selected and unselected states. (default: `false`)
-}
toggle :
    Bool
    -> Builder { a | toggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | toggle : M3e.Build.Internal.Used } s msg kind
toggle v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Button.toggle v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The type of the element. (default: `"button"`)
-}
type_ :
    M3e.Token.Value
        { button : M3e.Token.Supported
        , reset : M3e.Token.Supported
        , submit : M3e.Token.Supported
        }
    -> Builder { a | type_ : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | type_ : M3e.Build.Internal.Used } s msg kind
type_ v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Button.type_ v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The value associated with the element's name when it's submitted with form data.
-}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Button.value v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the button. (default: `"text"`)
-}
variant :
    M3e.Token.Value
        { elevated : M3e.Token.Supported
        , filled : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        , text : M3e.Token.Supported
        , tonal : M3e.Token.Supported
        }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Button.variant v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before a toggle button's selected state changes.
-}
onBeforeinput :
    (Bool -> msg)
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Button.onBeforeinput v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when a toggle button's selected state changes.
-}
onInput :
    (Bool -> msg)
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Button.onInput v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when a toggle button's selected state changes.
-}
onChange :
    (Bool -> msg)
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Button.onChange v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `icon` slot.
-}
icon :
    Markup.Element.Element
        { sharedIcon : Markup.Kind.Shared
        , loadingIndicator : M3e.Kind.Brand
        }
        msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg kind
icon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `selected` slot.
-}
selectedSlot :
    Markup.Element.Element
        { sharedText : Markup.Kind.Shared
        , sharedIcon : Markup.Kind.Shared
        }
        msg
    -> Builder a { s | selected : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | selected : M3e.Build.Internal.Used } msg kind
selectedSlot el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "selected" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `selected-icon` slot.
-}
selectedIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Builder a { s | selectedIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | selectedIcon : M3e.Build.Internal.Used } msg kind
selectedIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode
                (Markup.Element.withSlot "selected-icon" el_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `trailing-icon` slot.
-}
trailingIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Builder a { s | trailingIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | trailingIcon : M3e.Build.Internal.Used } msg kind
trailingIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode
                (Markup.Element.withSlot "trailing-icon" el_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-button>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { button : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
