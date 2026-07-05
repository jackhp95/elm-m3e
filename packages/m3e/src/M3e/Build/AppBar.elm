module M3e.Build.AppBar exposing
    ( Builder, AttrCaps, SlotCaps, appBar, centered, for
    , size, build
    )

{-|
The ⑤ Build shape for `<m3e-app-bar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.AppBar as AppBar`.

@docs Builder, AttrCaps, SlotCaps, appBar, centered, for
@docs size, build
-}


import M3e.Build.Internal
import M3e.Cem.AppBar
import M3e.Cem.Attr
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-app-bar>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | appBar : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { centered : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { leading : M3e.Build.Internal.Available
    , title : M3e.Build.Internal.Available
    , subtitle : M3e.Build.Internal.Available
    , leadingIcon : M3e.Build.Internal.Available
    , trailingIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-app-bar>`. -}
appBar : Builder AttrCaps SlotCaps msg kind
appBar =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.AppBar.appBar
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the title and subtitle are centered. (default: `false`) -}
centered :
    Bool
    -> Builder { a | centered : M3e.Build.Internal.Available } s msg kind
    -> Builder { centered : M3e.Build.Internal.Used } s msg kind
centered v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.AppBar.centered v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.AppBar.for v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The size of the bar. (default: `"small"`) -}
size :
    M3e.Value.Value { large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg kind
    -> Builder { size : M3e.Build.Internal.Used } s msg kind
size v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.AppBar.size v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-app-bar>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { appBar : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)