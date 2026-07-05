module M3e.Build.SplitPane exposing ( Builder, AttrCaps, SlotCaps, splitPane )

{-|
The ⑤ Build shape for `<m3e-split-pane>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SplitPane as SplitPane`.

@docs Builder, AttrCaps, SlotCaps, splitPane
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-split-pane>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | splitPane : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { label : M3e.Build.Internal.Available
    , max : M3e.Build.Internal.Available
    , min : M3e.Build.Internal.Available
    , orientation : M3e.Build.Internal.Available
    , overshootLimit : M3e.Build.Internal.Available
    , step : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , wrapDetents : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { start : M3e.Build.Internal.Available, end : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-split-pane>`. -}
splitPane : Builder AttrCaps SlotCaps msg kind
splitPane =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")