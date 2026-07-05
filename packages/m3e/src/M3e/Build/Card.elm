module M3e.Build.Card exposing ( Builder, AttrCaps, SlotCaps, card )

{-|
The ⑤ Build shape for `<m3e-card>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Card as Card`.

@docs Builder, AttrCaps, SlotCaps, card
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-card>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | card : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { actionable : M3e.Build.Internal.Available
    , inline : M3e.Build.Internal.Available
    , orientation : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , href : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , type_ : M3e.Build.Internal.Available
    , disabledInteractive : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , header : M3e.Build.Internal.Available
    , content : M3e.Build.Internal.Available
    , actions : M3e.Build.Internal.Available
    , footer : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-card>`. -}
card : Builder AttrCaps SlotCaps msg kind
card =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")