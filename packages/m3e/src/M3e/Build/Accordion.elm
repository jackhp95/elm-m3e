module M3e.Build.Accordion exposing
    ( Builder, AttrCaps, SlotCaps, accordion, multi, default
    , build
    )

{-|
The ⑤ Build shape for `<m3e-accordion>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Accordion as Accordion`.

@docs Builder, AttrCaps, SlotCaps, accordion, multi, default
@docs build
-}


import M3e.Build.Internal
import M3e.Cem.Accordion
import M3e.Cem.Attr
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-accordion>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { multi : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { multi : Maybe Bool
    , default :
        List (M3e.Element.Element { expansionPanel : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-accordion>`. -}
accordion : Builder AttrCaps SlotCaps msg
accordion =
    Builder { multi = Nothing, default = [], phantomMsg_ = Nothing }


{-| Whether multiple expansion panels can be open at the same time. (default: `false`) -}
multi :
    Bool
    -> Builder { a | multi : M3e.Build.Internal.Available } s msg
    -> Builder { a | multi : M3e.Build.Internal.Used } s msg
multi v_ (Builder f_) =
    Builder { f_ | multi = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default :
    M3e.Element.Element { expansionPanel : M3e.Value.Supported } msg
    -> Builder a s msg
    -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Build the `<m3e-accordion>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | accordion : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Accordion.accordion
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Accordion.multi v_) ]
                         )
                         f_.multi
                      )
                  ]
             )
             (List.concat
                  [ List.map (\el_ -> M3e.Element.toNode el_) f_.default ]
             )
        )