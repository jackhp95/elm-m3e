module M3e.Build.PseudoRadio exposing
    ( Builder, AttrCaps, SlotCaps, pseudoRadio, checked, disabled
    , build
    )

{-|
The ⑤ Build shape for `<m3e-pseudo-radio>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.PseudoRadio as PseudoRadio`.

@docs Builder, AttrCaps, SlotCaps, pseudoRadio, checked, disabled
@docs build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.PseudoRadio
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-pseudo-radio>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { checked : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { checked : Maybe Bool, disabled : Maybe Bool, phantomMsg_ : Maybe msg }


{-| Seed a `Builder` for `<m3e-pseudo-radio>`. -}
pseudoRadio : Builder AttrCaps SlotCaps msg
pseudoRadio =
    Builder { checked = Nothing, disabled = Nothing, phantomMsg_ = Nothing }


{-| A value indicating whether the element is checked. (default: `false`) -}
checked :
    Bool
    -> Builder { a | checked : M3e.Build.Internal.Available } s msg
    -> Builder { a | checked : M3e.Build.Internal.Used } s msg
checked v_ (Builder f_) =
    Builder { f_ | checked = Just v_ }


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Build the `<m3e-pseudo-radio>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | pseudoRadio : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.PseudoRadio.pseudoRadio
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.PseudoRadio.checked v_)
                            ]
                         )
                         f_.checked
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.PseudoRadio.disabled v_)
                            ]
                         )
                         f_.disabled
                      )
                  ]
             )
             (List.concat [])
        )