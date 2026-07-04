module M3e.Build.ChipSet exposing
    ( Builder, AttrCaps, SlotCaps, chipSet, vertical, default
    , build
    )

{-|
The ⑤ Build shape for `<m3e-chip-set>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ChipSet as ChipSet`.

@docs Builder, AttrCaps, SlotCaps, chipSet, vertical, default
@docs build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.ChipSet
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-chip-set>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { vertical : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { vertical : Maybe Bool
    , default :
        List (M3e.Element.Element { assistChip : M3e.Value.Supported
        , chip : M3e.Value.Supported
        , filterChip : M3e.Value.Supported
        , inputChip : M3e.Value.Supported
        , suggestionChip : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-chip-set>`. -}
chipSet : Builder AttrCaps SlotCaps msg
chipSet =
    Builder { vertical = Nothing, default = [], phantomMsg_ = Nothing }


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical :
    Bool
    -> Builder { a | vertical : M3e.Build.Internal.Available } s msg
    -> Builder { a | vertical : M3e.Build.Internal.Used } s msg
vertical v_ (Builder f_) =
    Builder { f_ | vertical = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default :
    M3e.Element.Element { assistChip : M3e.Value.Supported
    , chip : M3e.Value.Supported
    , filterChip : M3e.Value.Supported
    , inputChip : M3e.Value.Supported
    , suggestionChip : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Build the `<m3e-chip-set>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | chipSet : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ChipSet.chipSet
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.ChipSet.vertical v_)
                            ]
                         )
                         f_.vertical
                      )
                  ]
             )
             (List.concat
                  [ List.map (\el_ -> M3e.Element.toNode el_) f_.default ]
             )
        )