module M3e.Build.BreadcrumbItemButton exposing
    ( Builder, AttrCaps, SlotCaps, breadcrumbItemButton, current, href
    , target, rel, download, disabled, onClick, icon, default
    , build
    )

{-|
The ⑤ Build shape for `<m3e-breadcrumb-item-button>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BreadcrumbItemButton as BreadcrumbItemButton`.

@docs Builder, AttrCaps, SlotCaps, breadcrumbItemButton, current, href
@docs target, rel, download, disabled, onClick, icon
@docs default, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.BreadcrumbItemButton
import M3e.Cem.Html.BreadcrumbItemButton
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-breadcrumb-item-button>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { current : M3e.Build.Internal.Available
    , href : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available
    , default : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { current :
        Maybe (M3e.Value.Value { date : M3e.Value.Supported
        , location : M3e.Value.Supported
        , page : M3e.Value.Supported
        , step : M3e.Value.Supported
        , time : M3e.Value.Supported
        , true : M3e.Value.Supported
        })
    , href : Maybe String
    , target : Maybe String
    , rel : Maybe String
    , download : Maybe String
    , disabled : Maybe Bool
    , onClick : Maybe (Json.Decode.Decoder msg)
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , default :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , icon : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-breadcrumb-item-button>`. -}
breadcrumbItemButton : Builder AttrCaps SlotCaps msg
breadcrumbItemButton =
    Builder
        { current = Nothing
        , href = Nothing
        , target = Nothing
        , rel = Nothing
        , download = Nothing
        , disabled = Nothing
        , onClick = Nothing
        , icon = Nothing
        , default = Nothing
        , phantomMsg_ = Nothing
        }


{-| Indicates the current item in the breadcrumb path. -}
current :
    M3e.Value.Value { date : M3e.Value.Supported
    , location : M3e.Value.Supported
    , page : M3e.Value.Supported
    , step : M3e.Value.Supported
    , time : M3e.Value.Supported
    , true : M3e.Value.Supported
    }
    -> Builder { a | current : M3e.Build.Internal.Available } s msg
    -> Builder { a | current : M3e.Build.Internal.Used } s msg
current v_ (Builder f_) =
    Builder { f_ | current = Just v_ }


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


{-| Set the `icon` slot. Consumes the `icon` slot capability. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg
icon v_ (Builder f_) =
    Builder { f_ | icon = Just v_ }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element { text : M3e.Value.Supported
    , icon : M3e.Value.Supported
    } msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }


{-| Build the `<m3e-breadcrumb-item-button>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind
        | breadcrumbItemButton : M3e.Value.Supported
    } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.BreadcrumbItemButton.breadcrumbItemButton
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.BreadcrumbItemButton.current v_)
                            ]
                         )
                         f_.current
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.BreadcrumbItemButton.href v_)
                            ]
                         )
                         f_.href
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.BreadcrumbItemButton.target v_)
                            ]
                         )
                         f_.target
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.BreadcrumbItemButton.rel v_)
                            ]
                         )
                         f_.rel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.BreadcrumbItemButton.download v_)
                            ]
                         )
                         f_.download
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.BreadcrumbItemButton.disabled v_)
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
                                   M3e.Cem.Html.BreadcrumbItemButton.onClick
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
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "icon" v_)
                            ]
                         )
                         f_.icon
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map (\v_ -> [ M3e.Element.toNode v_ ]) f_.default)
                  ]
             )
        )