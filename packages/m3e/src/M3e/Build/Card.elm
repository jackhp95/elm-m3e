module M3e.Build.Card exposing
    ( Builder, AttrCaps, SlotCaps, card, actionable, inline
    , orientation, variant, href, target, rel, download, name
    , value, type_, disabledInteractive, disabled, onClick, default, header
    , content, actions, footer, build
    )

{-|
The ⑤ Build shape for `<m3e-card>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Card as Card`.

@docs Builder, AttrCaps, SlotCaps, card, actionable, inline
@docs orientation, variant, href, target, rel, download
@docs name, value, type_, disabledInteractive, disabled, onClick
@docs default, header, content, actions, footer, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Card
import M3e.Cem.Html.Card
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-card>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { actionable : M3e.Build.Internal.Available
    , inline : M3e.Build.Internal.Available
    , orientation : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , href : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , type_ : M3e.Build.Internal.Available
    , disabledInteractive : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , header : M3e.Build.Internal.Available
    , content : M3e.Build.Internal.Available
    , actions : M3e.Build.Internal.Available
    , footer : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { actionable : Maybe Bool
    , inline : Maybe Bool
    , orientation :
        Maybe (M3e.Value.Value { horizontal : M3e.Value.Supported
        , vertical : M3e.Value.Supported
        })
    , variant :
        Maybe (M3e.Value.Value { elevated : M3e.Value.Supported
        , filled : M3e.Value.Supported
        , outlined : M3e.Value.Supported
        })
    , href : Maybe String
    , target : Maybe String
    , rel : Maybe String
    , download : Maybe String
    , name : Maybe String
    , value : Maybe String
    , type_ :
        Maybe (M3e.Value.Value { button : M3e.Value.Supported
        , reset : M3e.Value.Supported
        , submit : M3e.Value.Supported
        })
    , disabledInteractive : Maybe Bool
    , disabled : Maybe Bool
    , onClick : Maybe (Json.Decode.Decoder msg)
    , default : Maybe (M3e.Element.Element {} msg)
    , header : Maybe (M3e.Element.Element {} msg)
    , content : Maybe (M3e.Element.Element {} msg)
    , actions : Maybe (M3e.Element.Element {} msg)
    , footer : Maybe (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-card>`. -}
card : Builder AttrCaps SlotCaps msg
card =
    Builder
        { actionable = Nothing
        , inline = Nothing
        , orientation = Nothing
        , variant = Nothing
        , href = Nothing
        , target = Nothing
        , rel = Nothing
        , download = Nothing
        , name = Nothing
        , value = Nothing
        , type_ = Nothing
        , disabledInteractive = Nothing
        , disabled = Nothing
        , onClick = Nothing
        , default = Nothing
        , header = Nothing
        , content = Nothing
        , actions = Nothing
        , footer = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`) -}
actionable :
    Bool
    -> Builder { a | actionable : M3e.Build.Internal.Available } s msg
    -> Builder { a | actionable : M3e.Build.Internal.Used } s msg
actionable v_ (Builder f_) =
    Builder { f_ | actionable = Just v_ }


{-| Whether to present the card inline with surrounding content. (default: `false`) -}
inline :
    Bool
    -> Builder { a | inline : M3e.Build.Internal.Available } s msg
    -> Builder { a | inline : M3e.Build.Internal.Used } s msg
inline v_ (Builder f_) =
    Builder { f_ | inline = Just v_ }


{-| The orientation of the card. (default: `"vertical"`) -}
orientation :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> Builder { a | orientation : M3e.Build.Internal.Available } s msg
    -> Builder { a | orientation : M3e.Build.Internal.Used } s msg
orientation v_ (Builder f_) =
    Builder { f_ | orientation = Just v_ }


{-| The appearance variant of the card. (default: `"filled"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }


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


{-| The name of the element, submitted as a pair with the element's `value`
as part of form data, when the element is used to submit a form.
-}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg
    -> Builder { a | name : M3e.Build.Internal.Used } s msg
name v_ (Builder f_) =
    Builder { f_ | name = Just v_ }


{-| The value associated with the element's name when it's submitted with form data. -}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg
    -> Builder { a | value : M3e.Build.Internal.Used } s msg
value v_ (Builder f_) =
    Builder { f_ | value = Just v_ }


{-| The type of the element. (default: `"button"`) -}
type_ :
    M3e.Value.Value { button : M3e.Value.Supported
    , reset : M3e.Value.Supported
    , submit : M3e.Value.Supported
    }
    -> Builder { a | type_ : M3e.Build.Internal.Available } s msg
    -> Builder { a | type_ : M3e.Build.Internal.Used } s msg
type_ v_ (Builder f_) =
    Builder { f_ | type_ = Just v_ }


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> Builder { a | disabledInteractive : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabledInteractive : M3e.Build.Internal.Used } s msg
disabledInteractive v_ (Builder f_) =
    Builder { f_ | disabledInteractive = Just v_ }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Dispatched when the element is clicked. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg
onClick v_ (Builder f_) =
    Builder { f_ | onClick = Just v_ }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element {} msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }


{-| Set the `header` slot. Consumes the `header` slot capability. -}
header :
    M3e.Element.Element {} msg
    -> Builder a { s | header : M3e.Build.Internal.Available } msg
    -> Builder a { s | header : M3e.Build.Internal.Used } msg
header v_ (Builder f_) =
    Builder { f_ | header = Just v_ }


{-| Set the `content` slot. Consumes the `content` slot capability. -}
content :
    M3e.Element.Element {} msg
    -> Builder a { s | content : M3e.Build.Internal.Available } msg
    -> Builder a { s | content : M3e.Build.Internal.Used } msg
content v_ (Builder f_) =
    Builder { f_ | content = Just v_ }


{-| Set the `actions` slot. Consumes the `actions` slot capability. -}
actions :
    M3e.Element.Element {} msg
    -> Builder a { s | actions : M3e.Build.Internal.Available } msg
    -> Builder a { s | actions : M3e.Build.Internal.Used } msg
actions v_ (Builder f_) =
    Builder { f_ | actions = Just v_ }


{-| Set the `footer` slot. Consumes the `footer` slot capability. -}
footer :
    M3e.Element.Element {} msg
    -> Builder a { s | footer : M3e.Build.Internal.Available } msg
    -> Builder a { s | footer : M3e.Build.Internal.Used } msg
footer v_ (Builder f_) =
    Builder { f_ | footer = Just v_ }


{-| Build the `<m3e-card>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | card : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Card.card (List.map M3e.Cem.Attr.forget erased_) ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Card.actionable v_) ]
                         )
                         f_.actionable
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Card.inline v_) ]
                         )
                         f_.inline
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Card.orientation v_)
                            ]
                         )
                         f_.orientation
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Card.variant v_) ]
                         )
                         f_.variant
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ -> [ M3e.Cem.Attr.forget (M3e.Cem.Card.href v_) ])
                         f_.href
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Card.target v_) ]
                         )
                         f_.target
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ -> [ M3e.Cem.Attr.forget (M3e.Cem.Card.rel v_) ])
                         f_.rel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Card.download v_) ]
                         )
                         f_.download
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ -> [ M3e.Cem.Attr.forget (M3e.Cem.Card.name v_) ])
                         f_.name
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ -> [ M3e.Cem.Attr.forget (M3e.Cem.Card.value v_) ]
                         )
                         f_.value
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ -> [ M3e.Cem.Attr.forget (M3e.Cem.Card.type_ v_) ]
                         )
                         f_.type_
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Card.disabledInteractive v_)
                            ]
                         )
                         f_.disabledInteractive
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Card.disabled v_) ]
                         )
                         f_.disabled
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.Card.onClick
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
                                (M3e.Element.withSlot "header" v_)
                            ]
                         )
                         f_.header
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "content" v_)
                            ]
                         )
                         f_.content
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "actions" v_)
                            ]
                         )
                         f_.actions
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "footer" v_)
                            ]
                         )
                         f_.footer
                      )
                  ]
             )
        )