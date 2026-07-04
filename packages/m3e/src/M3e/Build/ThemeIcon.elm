module M3e.Build.ThemeIcon exposing
    ( Builder, AttrCaps, SlotCaps, themeIcon, color, scheme
    , variant, build
    )

{-|
The ⑤ Build shape for `<m3e-theme-icon>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ThemeIcon as ThemeIcon`.

@docs Builder, AttrCaps, SlotCaps, themeIcon, color, scheme
@docs variant, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.ThemeIcon
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-theme-icon>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { color : M3e.Build.Internal.Available
    , scheme : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { color : Maybe String
    , scheme :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , dark : M3e.Value.Supported
        , light : M3e.Value.Supported
        })
    , variant :
        Maybe (M3e.Value.Value { content : M3e.Value.Supported
        , expressive : M3e.Value.Supported
        , fidelity : M3e.Value.Supported
        , fruitSalad : M3e.Value.Supported
        , monochrome : M3e.Value.Supported
        , neutral : M3e.Value.Supported
        , rainbow : M3e.Value.Supported
        , tonalSpot : M3e.Value.Supported
        , vibrant : M3e.Value.Supported
        })
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-theme-icon>`. -}
themeIcon : Builder AttrCaps SlotCaps msg
themeIcon =
    Builder
        { color = Nothing
        , scheme = Nothing
        , variant = Nothing
        , phantomMsg_ = Nothing
        }


{-| The hex color of the theme to preview (default: `"#6750A4"`) -}
color :
    String
    -> Builder { a | color : M3e.Build.Internal.Available } s msg
    -> Builder { a | color : M3e.Build.Internal.Used } s msg
color v_ (Builder f_) =
    Builder { f_ | color = Just v_ }


{-| The color scheme of the theme. (default: `"auto"`) -}
scheme :
    M3e.Value.Value { auto : M3e.Value.Supported
    , dark : M3e.Value.Supported
    , light : M3e.Value.Supported
    }
    -> Builder { a | scheme : M3e.Build.Internal.Available } s msg
    -> Builder { a | scheme : M3e.Build.Internal.Used } s msg
scheme v_ (Builder f_) =
    Builder { f_ | scheme = Just v_ }


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
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }


{-| Build the `<m3e-theme-icon>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | themeIcon : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ThemeIcon.themeIcon
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.ThemeIcon.color v_) ]
                         )
                         f_.color
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.ThemeIcon.scheme v_)
                            ]
                         )
                         f_.scheme
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.ThemeIcon.variant v_)
                            ]
                         )
                         f_.variant
                      )
                  ]
             )
             (List.concat [])
        )