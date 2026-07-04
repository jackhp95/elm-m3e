module M3e.Build.StepperPrevious exposing
    ( Builder, AttrCaps, SlotCaps, stepperPrevious, default, build
    )

{-|
The ⑤ Build shape for `<m3e-stepper-previous>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.StepperPrevious as StepperPrevious`.

@docs Builder, AttrCaps, SlotCaps, stepperPrevious, default, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.StepperPrevious
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-stepper-previous>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


type alias Fields msg =
    { default : Maybe (M3e.Element.Element {} msg), phantomMsg_ : Maybe msg }


{-| Seed a `Builder` for `<m3e-stepper-previous>`. -}
stepperPrevious : Builder AttrCaps SlotCaps msg
stepperPrevious =
    Builder { default = Nothing, phantomMsg_ = Nothing }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element {} msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }


{-| Build the `<m3e-stepper-previous>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | stepperPrevious : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.StepperPrevious.stepperPrevious
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat [])
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map (\v_ -> [ M3e.Element.toNode v_ ]) f_.default)
                  ]
             )
        )