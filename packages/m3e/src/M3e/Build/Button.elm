module M3e.Build.Button exposing ( Builder, AttrCaps, SlotCaps, button )

{-|
The ⑤ Build shape for `<m3e-button>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Button as Button`.

@docs Builder, AttrCaps, SlotCaps, button
-}


import Json.Decode
import M3e.Action
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-button>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
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
    , disabled : Maybe Bool
    , disabledInteractive : Maybe Bool
    , name : Maybe String
    , selected : Maybe Bool
    , shape :
        Maybe (M3e.Value.Value { rounded : M3e.Value.Supported
        , square : M3e.Value.Supported
        })
    , size :
        Maybe (M3e.Value.Value { extraLarge : M3e.Value.Supported
        , extraSmall : M3e.Value.Supported
        , large : M3e.Value.Supported
        , medium : M3e.Value.Supported
        , small : M3e.Value.Supported
        })
    , toggle : Maybe Bool
    , type_ :
        Maybe (M3e.Value.Value { button : M3e.Value.Supported
        , reset : M3e.Value.Supported
        , submit : M3e.Value.Supported
        })
    , value : Maybe String
    , variant :
        Maybe (M3e.Value.Value { elevated : M3e.Value.Supported
        , filled : M3e.Value.Supported
        , outlined : M3e.Value.Supported
        , text : M3e.Value.Supported
        , tonal : M3e.Value.Supported
        })
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , icon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported
        , loadingIndicator : M3e.Value.Supported
        } msg)
    , selectedSlot :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , icon : M3e.Value.Supported
        } msg)
    , selectedIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , trailingIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
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
    -> Builder AttrCaps SlotCaps msg
button req_ =
    Builder
        { content = req_.content
        , action = req_.action
        , disabled = Nothing
        , disabledInteractive = Nothing
        , name = Nothing
        , selected = Nothing
        , shape = Nothing
        , size = Nothing
        , toggle = Nothing
        , type_ = Nothing
        , value = Nothing
        , variant = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , icon = Nothing
        , selectedSlot = Nothing
        , selectedIcon = Nothing
        , trailingIcon = Nothing
        }