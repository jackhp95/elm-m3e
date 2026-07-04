module M3e.Build.FabMenu exposing
    ( Builder, AttrCaps, SlotCaps, fabMenu, variant, onBeforetoggle
    , onToggle, default, build
    )

{-|
The ⑤ Build shape for `<m3e-fab-menu>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FabMenu as FabMenu`.

@docs Builder, AttrCaps, SlotCaps, fabMenu, variant, onBeforetoggle
@docs onToggle, default, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.FabMenu
import M3e.Cem.Html.FabMenu
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-fab-menu>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { variant : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { variant :
        Maybe (M3e.Value.Value { primary : M3e.Value.Supported
        , secondary : M3e.Value.Supported
        , tertiary : M3e.Value.Supported
        })
    , onBeforetoggle : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    , default :
        List (M3e.Element.Element { fabMenuItem : M3e.Value.Supported
        , menuItem : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-fab-menu>`. -}
fabMenu : Builder AttrCaps SlotCaps msg
fabMenu =
    Builder
        { variant = Nothing
        , onBeforetoggle = Nothing
        , onToggle = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| The appearance variant of the menu. (default: `"primary"`) -}
variant :
    M3e.Value.Value { primary : M3e.Value.Supported
    , secondary : M3e.Value.Supported
    , tertiary : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }


{-| Dispatched before the toggle state changes. -}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Available } s msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Used } s msg
onBeforetoggle v_ (Builder f_) =
    Builder { f_ | onBeforetoggle = Just v_ }


{-| Dispatched after the toggle state has changed. -}
onToggle :
    Json.Decode.Decoder msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg
onToggle v_ (Builder f_) =
    Builder { f_ | onToggle = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default :
    M3e.Element.Element { fabMenuItem : M3e.Value.Supported
    , menuItem : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Build the `<m3e-fab-menu>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | fabMenu : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.FabMenu.fabMenu
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.FabMenu.variant v_) ]
                         )
                         f_.variant
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.FabMenu.onBeforetoggle
                                   v_
                                )
                            ]
                         )
                         f_.onBeforetoggle
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.FabMenu.onToggle
                                   v_
                                )
                            ]
                         )
                         f_.onToggle
                      )
                  ]
             )
             (List.concat
                  [ List.map (\el_ -> M3e.Element.toNode el_) f_.default ]
             )
        )