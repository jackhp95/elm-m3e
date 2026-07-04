module M3e.Build.AssistChip exposing ( Builder, AttrCaps, SlotCaps, assistChip )

{-|
The ⑤ Build shape for `<m3e-assist-chip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.AssistChip as AssistChip`.

@docs Builder, AttrCaps, SlotCaps, assistChip
-}


import M3e.Action
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-assist-chip>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
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
    , name : Maybe String
    , type_ :
        Maybe (M3e.Value.Value { button : M3e.Value.Supported
        , reset : M3e.Value.Supported
        , submit : M3e.Value.Supported
        })
    , value : Maybe String
    , variant :
        Maybe (M3e.Value.Value { elevated : M3e.Value.Supported
        , outlined : M3e.Value.Supported
        })
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    }


{-| Seed a `Builder` for `<m3e-assist-chip>` with the required fields. -}
assistChip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
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
assistChip req_ =
    Builder
        { content = req_.content
        , action = req_.action
        , disabled = Nothing
        , disabledInteractive = Nothing
        , name = Nothing
        , type_ = Nothing
        , value = Nothing
        , variant = Nothing
        , icon = Nothing
        }