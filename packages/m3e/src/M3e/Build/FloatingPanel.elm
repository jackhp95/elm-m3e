module M3e.Build.FloatingPanel exposing
    ( Builder, AttrCaps, SlotCaps, floatingPanel, scrollStrategy, fitAnchorWidth
    , anchorOffset, onBeforetoggle, onToggle, default, build
    )

{-|
The ⑤ Build shape for `<m3e-floating-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FloatingPanel as FloatingPanel`.

@docs Builder, AttrCaps, SlotCaps, floatingPanel, scrollStrategy, fitAnchorWidth
@docs anchorOffset, onBeforetoggle, onToggle, default, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.FloatingPanel
import M3e.Cem.Html.FloatingPanel
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-floating-panel>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { scrollStrategy : M3e.Build.Internal.Available
    , fitAnchorWidth : M3e.Build.Internal.Available
    , anchorOffset : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { scrollStrategy :
        Maybe (M3e.Value.Value { hide : M3e.Value.Supported
        , reposition : M3e.Value.Supported
        })
    , fitAnchorWidth : Maybe Bool
    , anchorOffset : Maybe Float
    , onBeforetoggle : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-floating-panel>`. -}
floatingPanel : Builder AttrCaps SlotCaps msg
floatingPanel =
    Builder
        { scrollStrategy = Nothing
        , fitAnchorWidth = Nothing
        , anchorOffset = Nothing
        , onBeforetoggle = Nothing
        , onToggle = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


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


{-| Add an element to the `unnamed` (multi) slot. -}
default : M3e.Element.Element {} msg -> Builder a s msg -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Build the `<m3e-floating-panel>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | floatingPanel : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.FloatingPanel.floatingPanel
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.FloatingPanel.scrollStrategy v_)
                            ]
                         )
                         f_.scrollStrategy
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.FloatingPanel.fitAnchorWidth v_)
                            ]
                         )
                         f_.fitAnchorWidth
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.FloatingPanel.anchorOffset v_)
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
                                   M3e.Cem.Html.FloatingPanel.onBeforetoggle
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
                                   M3e.Cem.Html.FloatingPanel.onToggle
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