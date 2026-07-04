module M3e.Build.StepPanel exposing
    ( Builder, AttrCaps, SlotCaps, stepPanel, default, actions
    , build
    )

{-|
The ⑤ Build shape for `<m3e-step-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.StepPanel as StepPanel`.

@docs Builder, AttrCaps, SlotCaps, stepPanel, default, actions
@docs build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.StepPanel
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-step-panel>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , actions : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { default : Maybe (M3e.Element.Element {} msg)
    , actions : Maybe (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-step-panel>`. -}
stepPanel : Builder AttrCaps SlotCaps msg
stepPanel =
    Builder { default = Nothing, actions = Nothing, phantomMsg_ = Nothing }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element {} msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }


{-| Set the `actions` slot. Consumes the `actions` slot capability. -}
actions :
    M3e.Element.Element {} msg
    -> Builder a { s | actions : M3e.Build.Internal.Available } msg
    -> Builder a { s | actions : M3e.Build.Internal.Used } msg
actions v_ (Builder f_) =
    Builder { f_ | actions = Just v_ }


{-| Build the `<m3e-step-panel>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | stepPanel : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.StepPanel.stepPanel
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat [])
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map (\v_ -> [ M3e.Element.toNode v_ ]) f_.default)
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "actions" v_)
                            ]
                         )
                         f_.actions
                      )
                  ]
             )
        )