module M3e.Build.Button exposing
    ( Builder, AttrCaps, SlotCaps, button, disabled, disabledInteractive
    , name, selected, shape, size, toggle, type_, value
    , variant, onBeforeinput, onInput, onChange, icon, selectedSlot, selectedIcon
    , trailingIcon, build
    )

{-|
The ⑤ Build shape for `<m3e-button>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Button as Button`.

@docs Builder, AttrCaps, SlotCaps, button, disabled, disabledInteractive
@docs name, selected, shape, size, toggle, type_
@docs value, variant, onBeforeinput, onInput, onChange, icon
@docs selectedSlot, selectedIcon, trailingIcon, build
-}


import M3e.Action
import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Button
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-button>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | button : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
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


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , selectedIcon : M3e.Build.Internal.Available
    , trailingIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-button>` with the required fields. -}
button :
    { content :
        M3e.Element.Element { text : M3e.Value.Supported
        , icon : M3e.Value.Supported
        } msg
    , action :
        M3e.Action.Action { click : M3e.Value.Supported
        , link : M3e.Value.Supported
        , menuTrigger : M3e.Value.Supported
        , dialogTrigger : M3e.Value.Supported
        , fabMenuTrigger : M3e.Value.Supported
        , bottomSheetTrigger : M3e.Value.Supported
        , navRailToggle : M3e.Value.Supported
        , drawerToggle : M3e.Value.Supported
        , datepickerToggle : M3e.Value.Supported
        , dialogAction : M3e.Value.Supported
        , bottomSheetAction : M3e.Value.Supported
        , richTooltipAction : M3e.Value.Supported
        , stepperReset : M3e.Value.Supported
        , stepperPrevious : M3e.Value.Supported
        } msg
    }
    -> Builder AttrCaps SlotCaps msg kind
button req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Button.button
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             (List.map
                  M3e.Cem.Attr.Internal.forget
                  (M3e.Action.toAttrs req_.action)
             )
             [ M3e.Action.wrapContent
                 req_.action
                 (M3e.Element.toNode req_.content)
             ]
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Button.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> Builder { a
        | disabledInteractive : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { a | disabledInteractive : M3e.Build.Internal.Used } s msg kind
disabledInteractive v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Button.disabledInteractive v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | name : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Button.name v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the toggle button is selected. (default: `false`) -}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | selected : M3e.Build.Internal.Used } s msg kind
selected v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Button.selected v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The shape of the button. (default: `"rounded"`) -}
shape :
    M3e.Value.Value { rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> Builder { a | shape : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | shape : M3e.Build.Internal.Used } s msg kind
shape v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Button.shape v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The size of the button. (default: `"small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | size : M3e.Build.Internal.Used } s msg kind
size v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Button.size v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the button will toggle between selected and unselected states. (default: `false`) -}
toggle :
    Bool
    -> Builder { a | toggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | toggle : M3e.Build.Internal.Used } s msg kind
toggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Button.toggle v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The type of the element. (default: `"button"`) -}
type_ :
    M3e.Value.Value { button : M3e.Value.Supported
    , reset : M3e.Value.Supported
    , submit : M3e.Value.Supported
    }
    -> Builder { a | type_ : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | type_ : M3e.Build.Internal.Used } s msg kind
type_ v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Button.type_ v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The value associated with the element's name when it's submitted with form data. -}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Button.value v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the button. (default: `"text"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    , text : M3e.Value.Supported
    , tonal : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Button.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before a toggle button's selected state changes. -}
onBeforeinput :
    (Bool -> msg)
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Button.onBeforeinput v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when a toggle button's selected state changes. -}
onInput :
    (Bool -> msg)
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Button.onInput v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when a toggle button's selected state changes. -}
onChange :
    (Bool -> msg)
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Button.onChange v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported
    , loadingIndicator : M3e.Value.Supported
    } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg kind
icon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "icon" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `selected` slot. -}
selectedSlot :
    M3e.Element.Element { text : M3e.Value.Supported
    , icon : M3e.Value.Supported
    } msg
    -> Builder a { s | selected : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | selected : M3e.Build.Internal.Used } msg kind
selectedSlot el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "selected" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `selected-icon` slot. -}
selectedIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | selectedIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | selectedIcon : M3e.Build.Internal.Used } msg kind
selectedIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "selected-icon" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `trailing-icon` slot. -}
trailingIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | trailingIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | trailingIcon : M3e.Build.Internal.Used } msg kind
trailingIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "trailing-icon" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-button>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { button : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)