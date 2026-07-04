module M3e.Build.Fab exposing ( Builder, AttrCaps, SlotCaps, fab )

{-|
The ⑤ Build shape for `<m3e-fab>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Fab as Fab`.

@docs Builder, AttrCaps, SlotCaps, fab
-}


import M3e.Action
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-fab>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


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
        }