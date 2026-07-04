module M3e.Build.Optgroup exposing
    ( Builder, AttrCaps, SlotCaps, optgroup, label, default
    , build
    )

{-|
The ⑤ Build shape for `<m3e-optgroup>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Optgroup as Optgroup`.

@docs Builder, AttrCaps, SlotCaps, optgroup, label, default
@docs build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Optgroup
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-optgroup>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { label : M3e.Build.Internal.Available }


type alias Fields msg =
    { label : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , default : List (M3e.Element.Element { option : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-optgroup>`. -}
optgroup : Builder AttrCaps SlotCaps msg
optgroup =
    Builder { label = Nothing, default = [], phantomMsg_ = Nothing }


{-| Set the `label` slot. Consumes the `label` slot capability. -}
label :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> Builder a { s | label : M3e.Build.Internal.Available } msg
    -> Builder a { s | label : M3e.Build.Internal.Used } msg
label v_ (Builder f_) =
    Builder { f_ | label = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default :
    M3e.Element.Element { option : M3e.Value.Supported } msg
    -> Builder a s msg
    -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Build the `<m3e-optgroup>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | optgroup : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Optgroup.optgroup
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat [])
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "label" v_)
                            ]
                         )
                         f_.label
                      )
                  , List.map (\el_ -> M3e.Element.toNode el_) f_.default
                  ]
             )
        )