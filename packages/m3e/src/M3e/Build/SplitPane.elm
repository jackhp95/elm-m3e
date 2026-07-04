module M3e.Build.SplitPane exposing
    ( Builder, AttrCaps, SlotCaps, splitPane, label, max
    , min, orientation, overshootLimit, step, value, wrapDetents, name
    , disabled, onChange, onBeforeinput, onInput, start, end, build
    )

{-|
The ⑤ Build shape for `<m3e-split-pane>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SplitPane as SplitPane`.

@docs Builder, AttrCaps, SlotCaps, splitPane, label, max
@docs min, orientation, overshootLimit, step, value, wrapDetents
@docs name, disabled, onChange, onBeforeinput, onInput, start
@docs end, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.SplitPane
import M3e.Cem.SplitPane
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-split-pane>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { label : M3e.Build.Internal.Available
    , max : M3e.Build.Internal.Available
    , min : M3e.Build.Internal.Available
    , orientation : M3e.Build.Internal.Available
    , overshootLimit : M3e.Build.Internal.Available
    , step : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , wrapDetents : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { start : M3e.Build.Internal.Available, end : M3e.Build.Internal.Available }


type alias Fields msg =
    { label : Maybe String
    , max : Maybe Float
    , min : Maybe Float
    , orientation :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , horizontal : M3e.Value.Supported
        , vertical : M3e.Value.Supported
        })
    , overshootLimit : Maybe Float
    , step : Maybe Float
    , value : Maybe Float
    , wrapDetents : Maybe Bool
    , name : Maybe String
    , disabled : Maybe Bool
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , start : Maybe (M3e.Element.Element {} msg)
    , end : Maybe (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-split-pane>`. -}
splitPane : Builder AttrCaps SlotCaps msg
splitPane =
    Builder
        { label = Nothing
        , max = Nothing
        , min = Nothing
        , orientation = Nothing
        , overshootLimit = Nothing
        , step = Nothing
        , value = Nothing
        , wrapDetents = Nothing
        , name = Nothing
        , disabled = Nothing
        , onChange = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , start = Nothing
        , end = Nothing
        , phantomMsg_ = Nothing
        }


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`) -}
label :
    String
    -> Builder { a | label : M3e.Build.Internal.Available } s msg
    -> Builder { a | label : M3e.Build.Internal.Used } s msg
label v_ (Builder f_) =
    Builder { f_ | label = Just v_ }


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`) -}
max :
    Float
    -> Builder { a | max : M3e.Build.Internal.Available } s msg
    -> Builder { a | max : M3e.Build.Internal.Used } s msg
max v_ (Builder f_) =
    Builder { f_ | max = Just v_ }


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`) -}
min :
    Float
    -> Builder { a | min : M3e.Build.Internal.Available } s msg
    -> Builder { a | min : M3e.Build.Internal.Used } s msg
min v_ (Builder f_) =
    Builder { f_ | min = Just v_ }


{-| The orientation of the split. (default: `"horizontal"`) -}
orientation :
    M3e.Value.Value { auto : M3e.Value.Supported
    , horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> Builder { a | orientation : M3e.Build.Internal.Available } s msg
    -> Builder { a | orientation : M3e.Build.Internal.Used } s msg
orientation v_ (Builder f_) =
    Builder { f_ | orientation = Just v_ }


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`) -}
overshootLimit :
    Float
    -> Builder { a | overshootLimit : M3e.Build.Internal.Available } s msg
    -> Builder { a | overshootLimit : M3e.Build.Internal.Used } s msg
overshootLimit v_ (Builder f_) =
    Builder { f_ | overshootLimit = Just v_ }


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`) -}
step :
    Float
    -> Builder { a | step : M3e.Build.Internal.Available } s msg
    -> Builder { a | step : M3e.Build.Internal.Used } s msg
step v_ (Builder f_) =
    Builder { f_ | step = Just v_ }


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`) -}
value :
    Float
    -> Builder { a | value : M3e.Build.Internal.Available } s msg
    -> Builder { a | value : M3e.Build.Internal.Used } s msg
value v_ (Builder f_) =
    Builder { f_ | value = Just v_ }


{-| Whether cycling through detents will wrap. (default: `false`) -}
wrapDetents :
    Bool
    -> Builder { a | wrapDetents : M3e.Build.Internal.Available } s msg
    -> Builder { a | wrapDetents : M3e.Build.Internal.Used } s msg
wrapDetents v_ (Builder f_) =
    Builder { f_ | wrapDetents = Just v_ }


{-| The name that identifies the element when submitting the associated form. -}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg
    -> Builder { a | name : M3e.Build.Internal.Used } s msg
name v_ (Builder f_) =
    Builder { f_ | name = Just v_ }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Dispatched when the user finishes adjusting the drag handle. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }


{-| Dispatched continuously before the user adjusts the drag handle. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg
onBeforeinput v_ (Builder f_) =
    Builder { f_ | onBeforeinput = Just v_ }


{-| Dispatched continuously while the user adjusts the drag handle. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg
onInput v_ (Builder f_) =
    Builder { f_ | onInput = Just v_ }


{-| Set the `start` slot. Consumes the `start` slot capability. -}
start :
    M3e.Element.Element {} msg
    -> Builder a { s | start : M3e.Build.Internal.Available } msg
    -> Builder a { s | start : M3e.Build.Internal.Used } msg
start v_ (Builder f_) =
    Builder { f_ | start = Just v_ }


{-| Set the `end` slot. Consumes the `end` slot capability. -}
end :
    M3e.Element.Element {} msg
    -> Builder a { s | end : M3e.Build.Internal.Available } msg
    -> Builder a { s | end : M3e.Build.Internal.Used } msg
end v_ (Builder f_) =
    Builder { f_ | end = Just v_ }


{-| Build the `<m3e-split-pane>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | splitPane : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.SplitPane.splitPane
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.SplitPane.label v_) ]
                         )
                         f_.label
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.SplitPane.max v_) ]
                         )
                         f_.max
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.SplitPane.min v_) ]
                         )
                         f_.min
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SplitPane.orientation v_)
                            ]
                         )
                         f_.orientation
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SplitPane.overshootLimit v_)
                            ]
                         )
                         f_.overshootLimit
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.SplitPane.step v_) ]
                         )
                         f_.step
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.SplitPane.value v_) ]
                         )
                         f_.value
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SplitPane.wrapDetents v_)
                            ]
                         )
                         f_.wrapDetents
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.SplitPane.name v_) ]
                         )
                         f_.name
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SplitPane.disabled v_)
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
                                   M3e.Cem.Html.SplitPane.onChange
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
                                   M3e.Cem.Html.SplitPane.onBeforeinput
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
                                   M3e.Cem.Html.SplitPane.onInput
                                   v_
                                )
                            ]
                         )
                         f_.onInput
                      )
                  ]
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "start" v_)
                            ]
                         )
                         f_.start
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode (M3e.Element.withSlot "end" v_)
                            ]
                         )
                         f_.end
                      )
                  ]
             )
        )