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


{-| Opaque builder for `<m3e-loading-indicator>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { variant : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { variant :
        Maybe (M3e.Value.Value { contained : M3e.Value.Supported
        , uncontained : M3e.Value.Supported
        })
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-loading-indicator>`. -}
loadingIndicator : Builder AttrCaps SlotCaps msg
loadingIndicator =
    Builder { variant = Nothing, phantomMsg_ = Nothing }


{-| The appearance variant of the indicator. (default: `"uncontained"`) -}
variant :
    M3e.Value.Value { contained : M3e.Value.Supported
    , uncontained : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }


{-| Build the `<m3e-loading-indicator>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | loadingIndicator : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.LoadingIndicator.loadingIndicator
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.LoadingIndicator.variant v_)
                            ]
                         )
                         f_.variant
                      )
                  ]
             )
             (List.concat [])
        )