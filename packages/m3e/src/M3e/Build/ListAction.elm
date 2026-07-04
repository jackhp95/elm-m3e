module M3e.Build.ListAction exposing ( Builder, AttrCaps, SlotCaps, listAction )

{-|
The ⑤ Build shape for `<m3e-list-action>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ListAction as ListAction`.

@docs Builder, AttrCaps, SlotCaps, listAction
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-list-action>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { disabled : Maybe Bool
    , download : Maybe String
    , href : Maybe String
    , rel : Maybe String
    , target : Maybe String
    , onClick : Maybe (Json.Decode.Decoder msg)
    , default :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , dialogTrigger : M3e.Value.Supported
        , dialogAction : M3e.Value.Supported
        , menuTrigger : M3e.Value.Supported
        , fabMenuTrigger : M3e.Value.Supported
        , bottomSheetTrigger : M3e.Value.Supported
        , bottomSheetAction : M3e.Value.Supported
        , stepperPrevious : M3e.Value.Supported
        , stepperReset : M3e.Value.Supported
        , richTooltipAction : M3e.Value.Supported
        , drawerToggle : M3e.Value.Supported
        , datepickerToggle : M3e.Value.Supported
        , navRailToggle : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , leading :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported
        , avatar : M3e.Value.Supported
        , text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , overline :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , supportingText :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , trailing :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported
        , avatar : M3e.Value.Supported
        , text : M3e.Value.Supported
        , html : M3e.Value.Supported
        , switch : M3e.Value.Supported
        , radio : M3e.Value.Supported
        , checkbox : M3e.Value.Supported
        } msg)
    }


{-| Seed a `Builder` for `<m3e-list-action>`. -}
listAction : Builder AttrCaps SlotCaps msg
listAction =
    Builder
        { disabled = Nothing
        , download = Nothing
        , href = Nothing
        , rel = Nothing
        , target = Nothing
        , onClick = Nothing
        , default = Nothing
        , leading = Nothing
        , overline = Nothing
        , supportingText = Nothing
        , trailing = Nothing
        }