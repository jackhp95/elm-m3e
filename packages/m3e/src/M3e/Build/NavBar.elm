module M3e.Build.NavBar exposing
    ( Builder, AttrCaps, SlotCaps, navBar, mode, onChange
    , onBeforeinput, onInput, build
    )

{-|
The ⑤ Build shape for `<m3e-nav-bar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavBar as NavBar`.

@docs Builder, AttrCaps, SlotCaps, navBar, mode, onChange
@docs onBeforeinput, onInput, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.NavBar
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-nav-bar>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | navBar : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { mode : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-nav-bar>`. -}
navBar : Builder AttrCaps SlotCaps msg kind
navBar =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.NavBar.navBar
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The mode in which items in the bar are presented. (default: `"compact"`) -}
mode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , compact : M3e.Value.Supported
    , expanded : M3e.Value.Supported
    }
    -> Builder { a | mode : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | mode : M3e.Build.Internal.Used } s msg kind
mode v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.NavBar.mode v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state of an item changes. -}
onChange :
    msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.NavBar.onChange v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the selected state of an item changes. -}
onBeforeinput :
    msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.NavBar.onBeforeinput v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state of an item changes. -}
onInput :
    msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.NavBar.onInput v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-nav-bar>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { navBar : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)