module M3e.Build.ActionList exposing
    ( Builder, AttrCaps, SlotCaps, actionList, variant, default
    , build
    )

{-|
The ⑤ Build shape for `<m3e-action-list>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ActionList as ActionList`.

@docs Builder, AttrCaps, SlotCaps, actionList, variant, default
@docs build
-}


import M3e.Build.Internal
import M3e.Cem.ActionList
import M3e.Cem.Attr
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-action-list>`; see `.build` for the terminal. -}
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
        Maybe (M3e.Value.Value { segmented : M3e.Value.Supported
        , standard : M3e.Value.Supported
        })
    , default :
        List (M3e.Element.Element { listAction : M3e.Value.Supported
        , expandableListItem : M3e.Value.Supported
        , divider : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-action-list>`. -}
actionList : Builder AttrCaps SlotCaps msg
actionList =
    Builder { variant = Nothing, default = [], phantomMsg_ = Nothing }


{-| The appearance variant of the list. (default: `"standard"`) -}
variant :
    M3e.Value.Value { segmented : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default :
    M3e.Element.Element { listAction : M3e.Value.Supported
    , expandableListItem : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Build the `<m3e-action-list>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | actionList : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ActionList.actionList
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.ActionList.variant v_)
                            ]
                         )
                         f_.variant
                      )
                  ]
             )
             (List.concat
                  [ List.map (\el_ -> M3e.Element.toNode el_) f_.default ]
             )
        )