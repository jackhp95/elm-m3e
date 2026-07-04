module M3e.Build.MenuItemElementBase exposing
    ( Builder, AttrCaps, SlotCaps, menuItemElementBase, disabled, onClick
    , build
    )

{-|
The ⑤ Build shape for `<MenuItemElementBase>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MenuItemElementBase as MenuItemElementBase`.

@docs Builder, AttrCaps, SlotCaps, menuItemElementBase, disabled, onClick
@docs build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.MenuItemElementBase
import M3e.Cem.MenuItemElementBase
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<MenuItemElementBase>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { disabled : Maybe Bool
    , onClick : Maybe (Json.Decode.Decoder msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<MenuItemElementBase>`. -}
menuItemElementBase : Builder AttrCaps SlotCaps msg
menuItemElementBase =
    Builder { disabled = Nothing, onClick = Nothing, phantomMsg_ = Nothing }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| onClick event handler. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg
onClick v_ (Builder f_) =
    Builder { f_ | onClick = Just v_ }


{-| Build the `<MenuItemElementBase>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind
        | menuItemElementBase : M3e.Value.Supported
    } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.MenuItemElementBase.menuItemElementBase
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.MenuItemElementBase.disabled v_)
                            ]
                         )
                         f_.disabled
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.MenuItemElementBase.onClick
                                   v_
                                )
                            ]
                         )
                         f_.onClick
                      )
                  ]
             )
             (List.concat [])
        )