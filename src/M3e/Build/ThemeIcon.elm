module M3e.Build.ThemeIcon exposing
    ( Builder, AttrCaps, SlotCaps, themeIcon, attr, color
    , scheme, variant, build
    )

{-| The Build form for `<m3e-theme-icon>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ThemeIcon as ThemeIcon`.

@docs Builder, AttrCaps, SlotCaps, themeIcon, attr, color
@docs scheme, variant, build

-}

import M3e.Build.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr.Internal
import M3e.Html.ThemeIcon
import M3e.Node
import M3e.Token


{-| Phantom-typed opaque builder for `<m3e-theme-icon>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | themeIcon : M3e.Token.Supported
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { color : M3e.Build.Internal.Available
    , scheme : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-theme-icon>`.
-}
themeIcon : Builder AttrCaps SlotCaps msg kind
themeIcon =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.ThemeIcon.themeIcon
                    (List.map M3e.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    M3e.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| The hex color of the theme to preview (default: `"#6750A4"`)
-}
color :
    String
    -> Builder { a | color : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | color : M3e.Build.Internal.Used } s msg kind
color v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.ThemeIcon.color v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The color scheme of the theme. (default: `"auto"`)
-}
scheme :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , dark : M3e.Token.Supported
        , light : M3e.Token.Supported
        }
    -> Builder { a | scheme : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | scheme : M3e.Build.Internal.Used } s msg kind
scheme v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.ThemeIcon.scheme v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The color variant of the theme. (default: `"neutral"`)
-}
variant :
    M3e.Token.Value
        { content : M3e.Token.Supported
        , expressive : M3e.Token.Supported
        , fidelity : M3e.Token.Supported
        , fruitSalad : M3e.Token.Supported
        , monochrome : M3e.Token.Supported
        , neutral : M3e.Token.Supported
        , rainbow : M3e.Token.Supported
        , tonalSpot : M3e.Token.Supported
        , vibrant : M3e.Token.Supported
        }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.ThemeIcon.variant v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-theme-icon>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> M3e.Element.Element { themeIcon : M3e.Token.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
