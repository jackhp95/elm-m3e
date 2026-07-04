module M3e.Build.Tree exposing
    ( Builder, AttrCaps, SlotCaps, tree, multi, cascade
    , onChange, default, build
    )

{-|
The ⑤ Build shape for `<m3e-tree>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Tree as Tree`.

@docs Builder, AttrCaps, SlotCaps, tree, multi, cascade
@docs onChange, default, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.Tree
import M3e.Cem.Tree
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-tree>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { multi : M3e.Build.Internal.Available
    , cascade : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { multi : Maybe Bool
    , cascade : Maybe Bool
    , onChange : Maybe (Json.Decode.Decoder msg)
    , default :
        List (M3e.Element.Element { treeItem : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-tree>`. -}
tree : Builder AttrCaps SlotCaps msg
tree =
    Builder
        { multi = Nothing
        , cascade = Nothing
        , onChange = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| Whether multiple items can be selected. (default: `false`) -}
multi :
    Bool
    -> Builder { a | multi : M3e.Build.Internal.Available } s msg
    -> Builder { a | multi : M3e.Build.Internal.Used } s msg
multi v_ (Builder f_) =
    Builder { f_ | multi = Just v_ }


{-| Whether multiple item selection cascades to child items. (default: `false`) -}
cascade :
    Bool
    -> Builder { a | cascade : M3e.Build.Internal.Available } s msg
    -> Builder { a | cascade : M3e.Build.Internal.Used } s msg
cascade v_ (Builder f_) =
    Builder { f_ | cascade = Just v_ }


{-| Dispatched when the selected state changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default :
    M3e.Element.Element { treeItem : M3e.Value.Supported } msg
    -> Builder a s msg
    -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Build the `<m3e-tree>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | tree : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Tree.tree (List.map M3e.Cem.Attr.forget erased_) ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ -> [ M3e.Cem.Attr.forget (M3e.Cem.Tree.multi v_) ]
                         )
                         f_.multi
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Tree.cascade v_) ]
                         )
                         f_.cascade
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.Tree.onChange
                                   v_
                                )
                            ]
                         )
                         f_.onChange
                      )
                  ]
             )
             (List.concat
                  [ List.map (\el_ -> M3e.Element.toNode el_) f_.default ]
             )
        )