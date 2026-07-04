module M3e.Build.StateLayer exposing
    ( Builder, AttrCaps, SlotCaps, stateLayer, disabled, disableHover
    , for, build
    )

{-|
The ⑤ Build shape for `<m3e-state-layer>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.StateLayer as StateLayer`.

@docs Builder, AttrCaps, SlotCaps, stateLayer, disabled, disableHover
@docs for, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.StateLayer
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-state-layer>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , disableHover : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { disabled : Maybe Bool
    , disableHover : Maybe Bool
    , for : Maybe String
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-state-layer>`. -}
stateLayer : Builder AttrCaps SlotCaps msg
stateLayer =
    Builder
        { disabled = Nothing
        , disableHover = Nothing
        , for = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether hover and focus events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Whether hover events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disableHover :
    Bool
    -> Builder { a | disableHover : M3e.Build.Internal.Available } s msg
    -> Builder { a | disableHover : M3e.Build.Internal.Used } s msg
disableHover v_ (Builder f_) =
    Builder { f_ | disableHover = Just v_ }


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg
    -> Builder { a | for : M3e.Build.Internal.Used } s msg
for v_ (Builder f_) =
    Builder { f_ | for = Just v_ }


{-| Build the `<m3e-state-layer>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | stateLayer : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.StateLayer.stateLayer
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.StateLayer.disabled v_)
                            ]
                         )
                         f_.disabled
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.StateLayer.disableHover v_)
                            ]
                         )
                         f_.disableHover
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.StateLayer.for v_) ]
                         )
                         f_.for
                      )
                  ]
             )
             (List.concat [])
        )