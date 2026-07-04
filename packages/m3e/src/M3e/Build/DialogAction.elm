module M3e.Build.DialogAction exposing
    ( Builder, AttrCaps, SlotCaps, dialogAction, returnValue, default
    , build
    )

{-|
The ⑤ Build shape for `<m3e-dialog-action>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.DialogAction as DialogAction`.

@docs Builder, AttrCaps, SlotCaps, dialogAction, returnValue, default
@docs build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.DialogAction
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-dialog-action>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { returnValue : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


type alias Fields msg =
    { returnValue : Maybe String
    , default : Maybe (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-dialog-action>`. -}
dialogAction : Builder AttrCaps SlotCaps msg
dialogAction =
    Builder { returnValue = Nothing, default = Nothing, phantomMsg_ = Nothing }


{-| The value to return from the dialog. (default: `""`) -}
returnValue :
    String
    -> Builder { a | returnValue : M3e.Build.Internal.Available } s msg
    -> Builder { a | returnValue : M3e.Build.Internal.Used } s msg
returnValue v_ (Builder f_) =
    Builder { f_ | returnValue = Just v_ }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element {} msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }


{-| Build the `<m3e-dialog-action>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | dialogAction : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.DialogAction.dialogAction
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.DialogAction.returnValue v_)
                            ]
                         )
                         f_.returnValue
                      )
                  ]
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map (\v_ -> [ M3e.Element.toNode v_ ]) f_.default)
                  ]
             )
        )