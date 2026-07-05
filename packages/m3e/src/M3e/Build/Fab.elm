module M3e.Build.Fab exposing
    ( Builder, AttrCaps, SlotCaps, fab, disabled, disabledInteractive
    , extended, lowered, name, size, type_, value, variant
    )

{-|
The ⑤ Build shape for `<m3e-fab>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Fab as Fab`.

@docs Builder, AttrCaps, SlotCaps, fab, disabled, disabledInteractive
@docs extended, lowered, name, size, type_, value
@docs variant
-}


import M3e.Action
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Fab
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-fab>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | fab : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , disabledInteractive : M3e.Build.Internal.Available
    , extended : M3e.Build.Internal.Available
    , lowered : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    , type_ : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { label : M3e.Build.Internal.Available
    , closeIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-fab>` with the required fields. -}
fab :
    { content : M3e.Element.Element { icon : M3e.Value.Supported } msg
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
fab req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Fab.fab (List.map M3e.Cem.Attr.forget erased_) ch_
             )
             (List.append
                  (List.map M3e.Cem.Attr.forget (M3e.Action.toAttrs req_.action)
                  )
                  (List.map M3e.Cem.Attr.forget [])
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
    -> Builder { disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Fab.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> Builder { a
        | disabledInteractive : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { disabledInteractive : M3e.Build.Internal.Used } s msg kind
disabledInteractive v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Fab.disabledInteractive v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the button is extended to show the label. (default: `false`) -}
extended :
    Bool
    -> Builder { a | extended : M3e.Build.Internal.Available } s msg kind
    -> Builder { extended : M3e.Build.Internal.Used } s msg kind
extended v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Fab.extended v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to present a lowered elevation. (default: `false`) -}
lowered :
    Bool
    -> Builder { a | lowered : M3e.Build.Internal.Available } s msg kind
    -> Builder { lowered : M3e.Build.Internal.Used } s msg kind
lowered v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Fab.lowered v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg kind
    -> Builder { name : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Fab.name v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The size of the button. (default: `"medium"`) -}
size :
    M3e.Value.Value { large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg kind
    -> Builder { size : M3e.Build.Internal.Used } s msg kind
size v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Fab.size v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The type of the element. (default: `"button"`) -}
type_ :
    M3e.Value.Value { button : M3e.Value.Supported
    , reset : M3e.Value.Supported
    , submit : M3e.Value.Supported
    }
    -> Builder { a | type_ : M3e.Build.Internal.Available } s msg kind
    -> Builder { type_ : M3e.Build.Internal.Used } s msg kind
type_ v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Fab.type_ v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The value associated with the element's name when it's submitted with form data. -}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Fab.value v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the button. (default: `"primary-container"`) -}
variant :
    M3e.Value.Value { primary : M3e.Value.Supported
    , primaryContainer : M3e.Value.Supported
    , secondary : M3e.Value.Supported
    , secondaryContainer : M3e.Value.Supported
    , surface : M3e.Value.Supported
    , tertiary : M3e.Value.Supported
    , tertiaryContainer : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Fab.variant v_))
             (M3e.Build.Internal.node_ b_)
        )