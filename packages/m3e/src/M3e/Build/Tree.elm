module M3e.Build.Tree exposing ( Builder, AttrCaps, SlotCaps, tree )

{-|
The ⑤ Build shape for `<m3e-tree>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Tree as Tree`.

@docs Builder, AttrCaps, SlotCaps, tree
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-tree>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { multi : Maybe Bool
    , cascade : Maybe Bool
    , onChange : Maybe (Json.Decode.Decoder msg)
    , default :
        List (M3e.Element.Element { treeItem : M3e.Value.Supported } msg)
    }


{-| Seed a `Builder` for `<m3e-tree>`. -}
tree : Builder AttrCaps SlotCaps msg
tree =
    Builder
        { multi = Nothing, cascade = Nothing, onChange = Nothing, default = [] }