module M3e.Build.OptionPanel exposing
    ( Builder, AttrCaps, SlotCaps, optionPanel, state, scrollStrategy
    , fitAnchorWidth, anchorOffset, onBeforetoggle, onToggle, noData, default, loading
    , build
    )

{-|
The ⑤ Build shape for `<m3e-option-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.OptionPanel as OptionPanel`.

@docs Builder, AttrCaps, SlotCaps, optionPanel, state, scrollStrategy
@docs fitAnchorWidth, anchorOffset, onBeforetoggle, onToggle, noData, default
@docs loading, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.OptionPanel
import M3e.Cem.OptionPanel
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-option-panel>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { state : M3e.Build.Internal.Available
    , scrollStrategy : M3e.Build.Internal.Available
    , fitAnchorWidth : M3e.Build.Internal.Available
    , anchorOffset : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { noData : M3e.Build.Internal.Available }


type alias Fields msg =
    { state :
        Maybe (M3e.Value.Value { content : M3e.Value.Supported
        , loading : M3e.Value.Supported
        , noData : M3e.Value.Supported
        })
    , scrollStrategy :
        Maybe (M3e.Value.Value { hide : M3e.Value.Supported
        , reposition : M3e.Value.Supported
        })
    , fitAnchorWidth : Maybe Bool
    , anchorOffset : Maybe Float
    , onBeforetoggle : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    , noData : Maybe (M3e.Element.Element {} msg)
    , default :
        List (M3e.Element.Element { option : M3e.Value.Supported
        , optgroup : M3e.Value.Supported
        , divider : M3e.Value.Supported
        } msg)
    , loading :
        List (M3e.Element.Element { circularProgressIndicator :
            M3e.Value.Supported
        , loadingIndicator : M3e.Value.Supported
        , text : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-option-panel>`. -}
optionPanel : Builder AttrCaps SlotCaps msg
optionPanel =
    Builder
        { state = Nothing
        , scrollStrategy = Nothing
        , fitAnchorWidth = Nothing
        , anchorOffset = Nothing
        , onBeforetoggle = Nothing
        , onToggle = Nothing
        , noData = Nothing
        , default = []
        , loading = []
        , phantomMsg_ = Nothing
        }


{-| The state for which to present content. (default: `"content"`) -}
state :
    M3e.Value.Value { content : M3e.Value.Supported
    , loading : M3e.Value.Supported
    , noData : M3e.Value.Supported
    }
    -> Builder { a | state : M3e.Build.Internal.Available } s msg
    -> Builder { a | state : M3e.Build.Internal.Used } s msg
state v_ (Builder f_) =
    Builder { f_ | state = Just v_ }


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`) -}
scrollStrategy :
    M3e.Value.Value { hide : M3e.Value.Supported
    , reposition : M3e.Value.Supported
    }
    -> Builder { a | scrollStrategy : M3e.Build.Internal.Available } s msg
    -> Builder { a | scrollStrategy : M3e.Build.Internal.Used } s msg
scrollStrategy v_ (Builder f_) =
    Builder { f_ | scrollStrategy = Just v_ }


{-| Whether the panel's width should match its anchor's width. (default: `false`) -}
fitAnchorWidth :
    Bool
    -> Builder { a | fitAnchorWidth : M3e.Build.Internal.Available } s msg
    -> Builder { a | fitAnchorWidth : M3e.Build.Internal.Used } s msg
fitAnchorWidth v_ (Builder f_) =
    Builder { f_ | fitAnchorWidth = Just v_ }


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`) -}
anchorOffset :
    Float
    -> Builder { a | anchorOffset : M3e.Build.Internal.Available } s msg
    -> Builder { a | anchorOffset : M3e.Build.Internal.Used } s msg
anchorOffset v_ (Builder f_) =
    Builder { f_ | anchorOffset = Just v_ }


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


{-| Set the `no-data` slot. Consumes the `noData` slot capability. -}
noData :
    M3e.Element.Element {} msg
    -> Builder a { s | noData : M3e.Build.Internal.Available } msg
    -> Builder a { s | noData : M3e.Build.Internal.Used } msg
noData v_ (Builder f_) =
    Builder { f_ | noData = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default :
    M3e.Element.Element { option : M3e.Value.Supported
    , optgroup : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Add an element to the `loading` (multi) slot. -}
loading :
    M3e.Element.Element { circularProgressIndicator : M3e.Value.Supported
    , loadingIndicator : M3e.Value.Supported
    , text : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
loading v_ (Builder f_) =
    Builder { f_ | loading = List.append f_.loading [ v_ ] }


{-| Build the `<m3e-option-panel>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | optionPanel : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.OptionPanel.optionPanel
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.OptionPanel.state v_)
                            ]
                         )
                         f_.state
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.OptionPanel.scrollStrategy v_)
                            ]
                         )
                         f_.scrollStrategy
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.OptionPanel.fitAnchorWidth v_)
                            ]
                         )
                         f_.fitAnchorWidth
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.OptionPanel.anchorOffset v_)
                            ]
                         )
                         f_.anchorOffset
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.OptionPanel.onBeforetoggle
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
                                   M3e.Cem.Html.OptionPanel.onToggle
                                   v_
                                )
                            ]
                         )
                         f_.onToggle
                      )
                  ]
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "no-data" v_)
                            ]
                         )
                         f_.noData
                      )
                  , List.map (\el_ -> M3e.Element.toNode el_) f_.default
                  , List.map
                      (\el_ ->
                         M3e.Element.toNode (M3e.Element.withSlot "loading" el_)
                      )
                      f_.loading
                  ]
             )
        )