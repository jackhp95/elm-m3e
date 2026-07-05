module M3e.Build.FabMenu exposing
    ( Builder, AttrCaps, SlotCaps, fabMenu, variant, onBeforetoggle
    , onToggle, build
    )

{-|
The ⑤ Build shape for `<m3e-fab-menu>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FabMenu as FabMenu`.

@docs Builder, AttrCaps, SlotCaps, fabMenu, variant, onBeforetoggle
@docs onToggle, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.FabMenu
import M3e.Cem.Html.FabMenu
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-fab-menu>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | fabMenu : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { variant : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-fab-menu>`. -}
fabMenu : Builder AttrCaps SlotCaps msg kind
fabMenu =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.FabMenu.fabMenu
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The appearance variant of the menu. (default: `"primary"`) -}
variant :
    M3e.Value.Value { primary : M3e.Value.Supported
    , secondary : M3e.Value.Supported
    , tertiary : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.FabMenu.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the toggle state changes. -}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Used } s msg kind
onBeforetoggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.FabMenu.onBeforetoggle
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched after the toggle state has changed. -}
onToggle :
    Json.Decode.Decoder msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg kind
onToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.FabMenu.onToggle
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-fab-menu>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { fabMenu : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)