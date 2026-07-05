module M3e.Build.ThemeIcon exposing
    ( Builder, AttrCaps, SlotCaps, themeIcon, color, scheme
    , variant
    )

{-|
The ⑤ Build shape for `<m3e-theme-icon>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ThemeIcon as ThemeIcon`.

@docs Builder, AttrCaps, SlotCaps, themeIcon, color, scheme
@docs variant
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.ThemeIcon
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-theme-icon>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | themeIcon : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { color : M3e.Build.Internal.Available
    , scheme : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-theme-icon>`. -}
themeIcon : Builder AttrCaps SlotCaps msg kind
themeIcon =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ThemeIcon.themeIcon
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The hex color of the theme to preview (default: `"#6750A4"`) -}
color :
    String
    -> Builder { a | color : M3e.Build.Internal.Available } s msg kind
    -> Builder { color : M3e.Build.Internal.Used } s msg kind
color v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.ThemeIcon.color v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The color scheme of the theme. (default: `"auto"`) -}
scheme :
    M3e.Value.Value { auto : M3e.Value.Supported
    , dark : M3e.Value.Supported
    , light : M3e.Value.Supported
    }
    -> Builder { a | scheme : M3e.Build.Internal.Available } s msg kind
    -> Builder { scheme : M3e.Build.Internal.Used } s msg kind
scheme v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.ThemeIcon.scheme v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The color variant of the theme. (default: `"neutral"`) -}
variant :
    M3e.Value.Value { content : M3e.Value.Supported
    , expressive : M3e.Value.Supported
    , fidelity : M3e.Value.Supported
    , fruitSalad : M3e.Value.Supported
    , monochrome : M3e.Value.Supported
    , neutral : M3e.Value.Supported
    , rainbow : M3e.Value.Supported
    , tonalSpot : M3e.Value.Supported
    , vibrant : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.ThemeIcon.variant v_))
             (M3e.Build.Internal.node_ b_)
        )