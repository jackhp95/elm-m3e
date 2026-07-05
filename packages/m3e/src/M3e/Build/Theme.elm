module M3e.Build.Theme exposing
    ( Builder, AttrCaps, SlotCaps, theme, color, contrast
    , density, scheme, strongFocus, variant, motion, onChange, build
    )

{-|
The ⑤ Build shape for `<m3e-theme>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Theme as Theme`.

@docs Builder, AttrCaps, SlotCaps, theme, color, contrast
@docs density, scheme, strongFocus, variant, motion, onChange
@docs build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.Theme
import M3e.Cem.Theme
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-theme>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | theme : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { color : M3e.Build.Internal.Available
    , contrast : M3e.Build.Internal.Available
    , density : M3e.Build.Internal.Available
    , scheme : M3e.Build.Internal.Available
    , strongFocus : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , motion : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-theme>`. -}
theme : Builder AttrCaps SlotCaps msg kind
theme =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Theme.theme
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The hex color from which to derive dynamic color palettes. (default: `"#6750A4"`) -}
color :
    String
    -> Builder { a | color : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | color : M3e.Build.Internal.Used } s msg kind
color v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Theme.color v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The contrast level of the theme. (default: `"standard"`) -}
contrast :
    M3e.Value.Value { high : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> Builder { a | contrast : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | contrast : M3e.Build.Internal.Used } s msg kind
contrast v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Theme.contrast v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The density scale (0, -1, -2). (default: `0`) -}
density :
    Float
    -> Builder { a | density : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | density : M3e.Build.Internal.Used } s msg kind
density v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Theme.density v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The color scheme of the theme. (default: `"auto"`) -}
scheme :
    M3e.Value.Value { auto : M3e.Value.Supported
    , dark : M3e.Value.Supported
    , light : M3e.Value.Supported
    }
    -> Builder { a | scheme : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | scheme : M3e.Build.Internal.Used } s msg kind
scheme v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Theme.scheme v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to enable strong focus indicators. (default: `false`) -}
strongFocus :
    Bool
    -> Builder { a | strongFocus : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | strongFocus : M3e.Build.Internal.Used } s msg kind
strongFocus v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Theme.strongFocus v_))
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
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Theme.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The motion scheme. (default: `"standard"`) -}
motion :
    M3e.Value.Value { expressive : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> Builder { a | motion : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | motion : M3e.Build.Internal.Used } s msg kind
motion v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Theme.motion v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the theme changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.Theme.onChange
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-theme>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { theme : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)