module M3e.Build.NavItem exposing
    ( Builder, AttrCaps, SlotCaps, navItem, disabled, disabledInteractive
    , download, href, orientation, rel, selected, target, onBeforeinput
    , onInput, onChange, onClick, default, icon, selectedIcon, build
    )

{-|
The ⑤ Build shape for `<m3e-nav-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavItem as NavItem`.

@docs Builder, AttrCaps, SlotCaps, navItem, disabled, disabledInteractive
@docs download, href, orientation, rel, selected, target
@docs onBeforeinput, onInput, onChange, onClick, default, icon
@docs selectedIcon, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.NavItem
import M3e.Cem.NavItem
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-nav-item>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , disabledInteractive : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , href : M3e.Build.Internal.Available
    , orientation : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , icon : M3e.Build.Internal.Available
    , selectedIcon : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { disabled : Maybe Bool
    , disabledInteractive : Maybe Bool
    , download : Maybe String
    , href : Maybe String
    , orientation :
        Maybe (M3e.Value.Value { horizontal : M3e.Value.Supported
        , vertical : M3e.Value.Supported
        })
    , rel : Maybe String
    , selected : Maybe Bool
    , target : Maybe String
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onClick : Maybe (Json.Decode.Decoder msg)
    , default : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , selectedIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-nav-item>`. -}
navItem : Builder AttrCaps SlotCaps msg
navItem =
    Builder
        { disabled = Nothing
        , disabledInteractive = Nothing
        , download = Nothing
        , href = Nothing
        , orientation = Nothing
        , rel = Nothing
        , selected = Nothing
        , target = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , onClick = Nothing
        , default = Nothing
        , icon = Nothing
        , selectedIcon = Nothing
        , phantomMsg_ = Nothing
        }


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| A value indicating whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> Builder { a | disabledInteractive : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabledInteractive : M3e.Build.Internal.Used } s msg
disabledInteractive v_ (Builder f_) =
    Builder { f_ | disabledInteractive = Just v_ }


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download :
    String
    -> Builder { a | download : M3e.Build.Internal.Available } s msg
    -> Builder { a | download : M3e.Build.Internal.Used } s msg
download v_ (Builder f_) =
    Builder { f_ | download = Just v_ }


{-| The URL to which the link button points. (default: `""`) -}
href :
    String
    -> Builder { a | href : M3e.Build.Internal.Available } s msg
    -> Builder { a | href : M3e.Build.Internal.Used } s msg
href v_ (Builder f_) =
    Builder { f_ | href = Just v_ }


{-| The layout orientation of the item. (default: `"vertical"`) -}
orientation :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> Builder { a | orientation : M3e.Build.Internal.Available } s msg
    -> Builder { a | orientation : M3e.Build.Internal.Used } s msg
orientation v_ (Builder f_) =
    Builder { f_ | orientation = Just v_ }


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel :
    String
    -> Builder { a | rel : M3e.Build.Internal.Available } s msg
    -> Builder { a | rel : M3e.Build.Internal.Used } s msg
rel v_ (Builder f_) =
    Builder { f_ | rel = Just v_ }


{-| A value indicating whether the element is selected. (default: `false`) -}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg
    -> Builder { a | selected : M3e.Build.Internal.Used } s msg
selected v_ (Builder f_) =
    Builder { f_ | selected = Just v_ }


{-| The target of the link button. (default: `""`) -}
target :
    String
    -> Builder { a | target : M3e.Build.Internal.Available } s msg
    -> Builder { a | target : M3e.Build.Internal.Used } s msg
target v_ (Builder f_) =
    Builder { f_ | target = Just v_ }


{-| Dispatched before the selected state changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg
onBeforeinput v_ (Builder f_) =
    Builder { f_ | onBeforeinput = Just v_ }


{-| Dispatched when the selected state changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg
onInput v_ (Builder f_) =
    Builder { f_ | onInput = Just v_ }


{-| Dispatched when the selected state changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }


{-| Dispatched when the element is clicked. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg
onClick v_ (Builder f_) =
    Builder { f_ | onClick = Just v_ }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }


{-| Set the `icon` slot. Consumes the `icon` slot capability. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg
icon v_ (Builder f_) =
    Builder { f_ | icon = Just v_ }


{-| Set the `selected-icon` slot. Consumes the `selectedIcon` slot capability. -}
selectedIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | selectedIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | selectedIcon : M3e.Build.Internal.Used } msg
selectedIcon v_ (Builder f_) =
    Builder { f_ | selectedIcon = Just v_ }


{-| Build the `<m3e-nav-item>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | navItem : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.NavItem.navItem
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.NavItem.disabled v_)
                            ]
                         )
                         f_.disabled
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.NavItem.disabledInteractive v_)
                            ]
                         )
                         f_.disabledInteractive
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.NavItem.download v_)
                            ]
                         )
                         f_.download
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.NavItem.href v_) ]
                         )
                         f_.href
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.NavItem.orientation v_)
                            ]
                         )
                         f_.orientation
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.NavItem.rel v_) ]
                         )
                         f_.rel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.NavItem.selected v_)
                            ]
                         )
                         f_.selected
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.NavItem.target v_) ]
                         )
                         f_.target
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.NavItem.onBeforeinput
                                   v_
                                )
                            ]
                         )
                         f_.onBeforeinput
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.NavItem.onInput
                                   v_
                                )
                            ]
                         )
                         f_.onInput
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.NavItem.onChange
                                   v_
                                )
                            ]
                         )
                         f_.onChange
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.NavItem.onClick
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
                                (M3e.Element.withSlot "icon" v_)
                            ]
                         )
                         f_.icon
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "selected-icon" v_)
                            ]
                         )
                         f_.selectedIcon
                      )
                  ]
             )
        )