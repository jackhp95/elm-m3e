module M3e.Build.ListItem exposing
    ( Builder, AttrCaps, SlotCaps, listItem, build
    )

{-|
The ⑤ Build shape for `<m3e-list-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ListItem as ListItem`.

@docs Builder, AttrCaps, SlotCaps, listItem, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.ListItem
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-list-item>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | listItem : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , leading : M3e.Build.Internal.Available
    , overline : M3e.Build.Internal.Available
    , supportingText : M3e.Build.Internal.Available
    , trailing : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-list-item>`. -}
listItem : Builder AttrCaps SlotCaps msg kind
listItem =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ListItem.listItem
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Build the `<m3e-list-item>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { listItem : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)