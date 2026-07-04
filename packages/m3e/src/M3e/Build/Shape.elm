module M3e.Build.Shape exposing
    ( Builder, AttrCaps, SlotCaps, shape, name, default
    )

{-|
The ⑤ Build shape for `<m3e-shape>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Shape as Shape`.

@docs Builder, AttrCaps, SlotCaps, shape, name, default
-}


import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-shape>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { name : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


type alias Fields msg =
    { name :
        Maybe (M3e.Value.Value { value12SidedCookie : M3e.Value.Supported
        , value4LeafClover : M3e.Value.Supported
        , value4SidedCookie : M3e.Value.Supported
        , value6SidedCookie : M3e.Value.Supported
        , value7SidedCookie : M3e.Value.Supported
        , value8LeafClover : M3e.Value.Supported
        , value9SidedCookie : M3e.Value.Supported
        , arch : M3e.Value.Supported
        , arrow : M3e.Value.Supported
        , boom : M3e.Value.Supported
        , bun : M3e.Value.Supported
        , burst : M3e.Value.Supported
        , circle : M3e.Value.Supported
        , diamond : M3e.Value.Supported
        , fan : M3e.Value.Supported
        , flower : M3e.Value.Supported
        , gem : M3e.Value.Supported
        , ghostIsh : M3e.Value.Supported
        , heart : M3e.Value.Supported
        , hexagon : M3e.Value.Supported
        , oval : M3e.Value.Supported
        , pentagon : M3e.Value.Supported
        , pill : M3e.Value.Supported
        , pixelCircle : M3e.Value.Supported
        , pixelTriangle : M3e.Value.Supported
        , puffy : M3e.Value.Supported
        , puffyDiamond : M3e.Value.Supported
        , semicircle : M3e.Value.Supported
        , slanted : M3e.Value.Supported
        , softBoom : M3e.Value.Supported
        , softBurst : M3e.Value.Supported
        , square : M3e.Value.Supported
        , sunny : M3e.Value.Supported
        , triangle : M3e.Value.Supported
        , verySunny : M3e.Value.Supported
        })
    , default : Maybe (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-shape>`. -}
shape : Builder AttrCaps SlotCaps msg
shape =
    Builder { name = Nothing, default = Nothing, phantomMsg_ = Nothing }


{-| The name of the shape. (default: `null`) -}
name :
    M3e.Value.Value { value12SidedCookie : M3e.Value.Supported
    , value4LeafClover : M3e.Value.Supported
    , value4SidedCookie : M3e.Value.Supported
    , value6SidedCookie : M3e.Value.Supported
    , value7SidedCookie : M3e.Value.Supported
    , value8LeafClover : M3e.Value.Supported
    , value9SidedCookie : M3e.Value.Supported
    , arch : M3e.Value.Supported
    , arrow : M3e.Value.Supported
    , boom : M3e.Value.Supported
    , bun : M3e.Value.Supported
    , burst : M3e.Value.Supported
    , circle : M3e.Value.Supported
    , diamond : M3e.Value.Supported
    , fan : M3e.Value.Supported
    , flower : M3e.Value.Supported
    , gem : M3e.Value.Supported
    , ghostIsh : M3e.Value.Supported
    , heart : M3e.Value.Supported
    , hexagon : M3e.Value.Supported
    , oval : M3e.Value.Supported
    , pentagon : M3e.Value.Supported
    , pill : M3e.Value.Supported
    , pixelCircle : M3e.Value.Supported
    , pixelTriangle : M3e.Value.Supported
    , puffy : M3e.Value.Supported
    , puffyDiamond : M3e.Value.Supported
    , semicircle : M3e.Value.Supported
    , slanted : M3e.Value.Supported
    , softBoom : M3e.Value.Supported
    , softBurst : M3e.Value.Supported
    , square : M3e.Value.Supported
    , sunny : M3e.Value.Supported
    , triangle : M3e.Value.Supported
    , verySunny : M3e.Value.Supported
    }
    -> Builder { a | name : M3e.Build.Internal.Available } s msg
    -> Builder { a | name : M3e.Build.Internal.Used } s msg
name v_ (Builder f_) =
    Builder { f_ | name = Just v_ }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element {} msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }