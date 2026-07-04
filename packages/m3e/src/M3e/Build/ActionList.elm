module M3e.Build.ActionList exposing
    ( Builder, AttrCaps, SlotCaps, actionList, variant
    )

{-|
The ⑤ Build shape for `<m3e-action-list>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ActionList as ActionList`.

@docs Builder, AttrCaps, SlotCaps, actionList, variant
-}


import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-action-list>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { variant : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { variant :
        Maybe (M3e.Value.Value { segmented : M3e.Value.Supported
        , standard : M3e.Value.Supported
        })
    , default :
        List (M3e.Element.Element { listAction : M3e.Value.Supported
        , expandableListItem : M3e.Value.Supported
        , divider : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-action-list>`. -}
actionList : Builder AttrCaps SlotCaps msg
actionList =
    Builder { variant = Nothing, default = [], phantomMsg_ = Nothing }


{-| The appearance variant of the list. (default: `"standard"`) -}
variant :
    M3e.Value.Value { segmented : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }