module M3e.Build.LoadingIndicator exposing
    ( Builder, AttrCaps, SlotCaps, loadingIndicator, variant, build
    )

{-|
The ⑤ Build shape for `<m3e-loading-indicator>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.LoadingIndicator as LoadingIndicator`.

@docs Builder, AttrCaps, SlotCaps, loadingIndicator, variant, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.LoadingIndicator
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-loading-indicator>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | loadingIndicator : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { variant : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-loading-indicator>`. -}
loadingIndicator : Builder AttrCaps SlotCaps msg kind
loadingIndicator =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.LoadingIndicator.loadingIndicator
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The appearance variant of the indicator. (default: `"uncontained"`) -}
variant :
    M3e.Value.Value { contained : M3e.Value.Supported
    , uncontained : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.LoadingIndicator.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-loading-indicator>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { loadingIndicator : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)