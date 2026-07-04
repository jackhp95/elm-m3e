module M3e.Build.Fab exposing
    ( Builder, AttrCaps, SlotCaps, fab, disabled, disabledInteractive
    , extended, lowered, name, size, type_, value, variant
    , label, closeIcon
    )

{-|
The ⑤ Build shape for `<m3e-fab>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Fab as Fab`.

@docs Builder, AttrCaps, SlotCaps, fab, disabled, disabledInteractive
@docs extended, lowered, name, size, type_, value
@docs variant, label, closeIcon
-}


import M3e.Action
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-fab>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


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


type alias Fields msg =
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
    , disabled : Maybe Bool
    , disabledInteractive : Maybe Bool
    , extended : Maybe Bool
    , lowered : Maybe Bool
    , name : Maybe String
    , size :
        Maybe (M3e.Value.Value { large : M3e.Value.Supported
        , medium : M3e.Value.Supported
        , small : M3e.Value.Supported
        })
    , type_ :
        Maybe (M3e.Value.Value { button : M3e.Value.Supported
        , reset : M3e.Value.Supported
        , submit : M3e.Value.Supported
        })
    , value : Maybe String
    , variant :
        Maybe (M3e.Value.Value { primary : M3e.Value.Supported
        , primaryContainer : M3e.Value.Supported
        , secondary : M3e.Value.Supported
        , secondaryContainer : M3e.Value.Supported
        , surface : M3e.Value.Supported
        , tertiary : M3e.Value.Supported
        , tertiaryContainer : M3e.Value.Supported
        })
    , label : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , closeIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
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
    -> Builder AttrCaps SlotCaps msg
fab req_ =
    Builder
        { content = req_.content
        , action = req_.action
        , disabled = Nothing
        , disabledInteractive = Nothing
        , extended = Nothing
        , lowered = Nothing
        , name = Nothing
        , size = Nothing
        , type_ = Nothing
        , value = Nothing
        , variant = Nothing
        , label = Nothing
        , closeIcon = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> Builder { a | disabledInteractive : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabledInteractive : M3e.Build.Internal.Used } s msg
disabledInteractive v_ (Builder f_) =
    Builder { f_ | disabledInteractive = Just v_ }


{-| Whether the button is extended to show the label. (default: `false`) -}
extended :
    Bool
    -> Builder { a | extended : M3e.Build.Internal.Available } s msg
    -> Builder { a | extended : M3e.Build.Internal.Used } s msg
extended v_ (Builder f_) =
    Builder { f_ | extended = Just v_ }


{-| Whether to present a lowered elevation. (default: `false`) -}
lowered :
    Bool
    -> Builder { a | lowered : M3e.Build.Internal.Available } s msg
    -> Builder { a | lowered : M3e.Build.Internal.Used } s msg
lowered v_ (Builder f_) =
    Builder { f_ | lowered = Just v_ }


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg
    -> Builder { a | name : M3e.Build.Internal.Used } s msg
name v_ (Builder f_) =
    Builder { f_ | name = Just v_ }


{-| The size of the button. (default: `"medium"`) -}
size :
    M3e.Value.Value { large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg
    -> Builder { a | size : M3e.Build.Internal.Used } s msg
size v_ (Builder f_) =
    Builder { f_ | size = Just v_ }


{-| The type of the element. (default: `"button"`) -}
type_ :
    M3e.Value.Value { button : M3e.Value.Supported
    , reset : M3e.Value.Supported
    , submit : M3e.Value.Supported
    }
    -> Builder { a | type_ : M3e.Build.Internal.Available } s msg
    -> Builder { a | type_ : M3e.Build.Internal.Used } s msg
type_ v_ (Builder f_) =
    Builder { f_ | type_ = Just v_ }


{-| The value associated with the element's name when it's submitted with form data. -}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg
    -> Builder { a | value : M3e.Build.Internal.Used } s msg
value v_ (Builder f_) =
    Builder { f_ | value = Just v_ }


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
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }


{-| Set the `label` slot. Consumes the `label` slot capability. -}
label :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> Builder a { s | label : M3e.Build.Internal.Available } msg
    -> Builder a { s | label : M3e.Build.Internal.Used } msg
label v_ (Builder f_) =
    Builder { f_ | label = Just v_ }


{-| Set the `close-icon` slot. Consumes the `closeIcon` slot capability. -}
closeIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | closeIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | closeIcon : M3e.Build.Internal.Used } msg
closeIcon v_ (Builder f_) =
    Builder { f_ | closeIcon = Just v_ }