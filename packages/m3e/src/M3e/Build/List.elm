module M3e.Build.List exposing ( Builder, AttrCaps, SlotCaps, list )

{-|
The ⑤ Build shape for `<m3e-list>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.List as List`.

@docs Builder, AttrCaps, SlotCaps, list
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-list>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { variant :
        Maybe (M3e.Value.Value { segmented : M3e.Value.Supported
        , standard : M3e.Value.Supported
        })
    , default :
        List (M3e.Element.Element { listItem : M3e.Value.Supported
        , listAction : M3e.Value.Supported
        , expandableListItem : M3e.Value.Supported
        , listOption : M3e.Value.Supported
        , divider : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-list>`. -}
list : Builder AttrCaps SlotCaps msg
list =
    Builder { variant = Nothing, default = [], phantomMsg_ = Nothing }