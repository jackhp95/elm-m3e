module M3e.Build.ListItemButton exposing
    ( Builder, AttrCaps, SlotCaps, listItemButton, href, target
    , rel, download, disabled, onClick, default, leading, overline
    , supportingText, trailing, build
    )

{-|
The ⑤ Build shape for `<m3e-list-item-button>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ListItemButton as ListItemButton`.

@docs Builder, AttrCaps, SlotCaps, listItemButton, href, target
@docs rel, download, disabled, onClick, default, leading
@docs overline, supportingText, trailing, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.ListItemButton
import M3e.Cem.ListItemButton
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-list-item-button>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { href : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , leading : M3e.Build.Internal.Available
    , overline : M3e.Build.Internal.Available
    , supportingText : M3e.Build.Internal.Available
    , trailing : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { href : Maybe String
    , target : Maybe String
    , rel : Maybe String
    , download : Maybe String
    , disabled : Maybe Bool
    , onClick : Maybe (Json.Decode.Decoder msg)
    , default :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , leading :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported
        , avatar : M3e.Value.Supported
        , text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , overline :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , supportingText :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , trailing :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported
        , avatar : M3e.Value.Supported
        , text : M3e.Value.Supported
        , html : M3e.Value.Supported
        , switch : M3e.Value.Supported
        , radio : M3e.Value.Supported
        , checkbox : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-list-item-button>`. -}
listItemButton : Builder AttrCaps SlotCaps msg
listItemButton =
    Builder
        { href = Nothing
        , target = Nothing
        , rel = Nothing
        , download = Nothing
        , disabled = Nothing
        , onClick = Nothing
        , default = Nothing
        , leading = Nothing
        , overline = Nothing
        , supportingText = Nothing
        , trailing = Nothing
        , phantomMsg_ = Nothing
        }


{-| The URL to which the link button points. (default: `""`) -}
href :
    String
    -> Builder { a | href : M3e.Build.Internal.Available } s msg
    -> Builder { a | href : M3e.Build.Internal.Used } s msg
href v_ (Builder f_) =
    Builder { f_ | href = Just v_ }


{-| The target of the link button. (default: `""`) -}
target :
    String
    -> Builder { a | target : M3e.Build.Internal.Available } s msg
    -> Builder { a | target : M3e.Build.Internal.Used } s msg
target v_ (Builder f_) =
    Builder { f_ | target = Just v_ }


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel :
    String
    -> Builder { a | rel : M3e.Build.Internal.Available } s msg
    -> Builder { a | rel : M3e.Build.Internal.Used } s msg
rel v_ (Builder f_) =
    Builder { f_ | rel = Just v_ }


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download :
    String
    -> Builder { a | download : M3e.Build.Internal.Available } s msg
    -> Builder { a | download : M3e.Build.Internal.Used } s msg
download v_ (Builder f_) =
    Builder { f_ | download = Just v_ }


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


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }


{-| Set the `leading` slot. Consumes the `leading` slot capability. -}
leading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | leading : M3e.Build.Internal.Available } msg
    -> Builder a { s | leading : M3e.Build.Internal.Used } msg
leading v_ (Builder f_) =
    Builder { f_ | leading = Just v_ }


{-| Set the `overline` slot. Consumes the `overline` slot capability. -}
overline :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | overline : M3e.Build.Internal.Available } msg
    -> Builder a { s | overline : M3e.Build.Internal.Used } msg
overline v_ (Builder f_) =
    Builder { f_ | overline = Just v_ }


{-| Set the `supporting-text` slot. Consumes the `supportingText` slot capability. -}
supportingText :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | supportingText : M3e.Build.Internal.Available } msg
    -> Builder a { s | supportingText : M3e.Build.Internal.Used } msg
supportingText v_ (Builder f_) =
    Builder { f_ | supportingText = Just v_ }


{-| Set the `trailing` slot. Consumes the `trailing` slot capability. -}
trailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    , switch : M3e.Value.Supported
    , radio : M3e.Value.Supported
    , checkbox : M3e.Value.Supported
    } msg
    -> Builder a { s | trailing : M3e.Build.Internal.Available } msg
    -> Builder a { s | trailing : M3e.Build.Internal.Used } msg
trailing v_ (Builder f_) =
    Builder { f_ | trailing = Just v_ }


{-| Build the `<m3e-list-item-button>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | listItemButton : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ListItemButton.listItemButton
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.ListItemButton.href v_)
                            ]
                         )
                         f_.href
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.ListItemButton.target v_)
                            ]
                         )
                         f_.target
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.ListItemButton.rel v_)
                            ]
                         )
                         f_.rel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.ListItemButton.download v_)
                            ]
                         )
                         f_.download
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.ListItemButton.disabled v_)
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
                                   M3e.Cem.Html.ListItemButton.onClick
                                   v_
                                )
                            ]
                         )
                         f_.onClick
                      )
                  ]
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map (\v_ -> [ M3e.Element.toNode v_ ]) f_.default)
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "leading" v_)
                            ]
                         )
                         f_.leading
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "overline" v_)
                            ]
                         )
                         f_.overline
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "supporting-text" v_)
                            ]
                         )
                         f_.supportingText
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "trailing" v_)
                            ]
                         )
                         f_.trailing
                      )
                  ]
             )
        )