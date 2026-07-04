module M3e.Build.Stepper exposing
    ( Builder, AttrCaps, SlotCaps, stepper, headerPosition, labelPosition
    , linear, orientation, onChange, onBeforeinput, onInput, step, panel
    , build
    )

{-|
The ⑤ Build shape for `<m3e-stepper>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Stepper as Stepper`.

@docs Builder, AttrCaps, SlotCaps, stepper, headerPosition, labelPosition
@docs linear, orientation, onChange, onBeforeinput, onInput, step
@docs panel, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.Stepper
import M3e.Cem.Stepper
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-stepper>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { headerPosition : M3e.Build.Internal.Available
    , labelPosition : M3e.Build.Internal.Available
    , linear : M3e.Build.Internal.Available
    , orientation : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { headerPosition :
        Maybe (M3e.Value.Value { above : M3e.Value.Supported
        , below : M3e.Value.Supported
        })
    , labelPosition :
        Maybe (M3e.Value.Value { below : M3e.Value.Supported
        , end : M3e.Value.Supported
        })
    , linear : Maybe Bool
    , orientation :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , horizontal : M3e.Value.Supported
        , vertical : M3e.Value.Supported
        })
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , step : List (M3e.Element.Element { step : M3e.Value.Supported } msg)
    , panel : List (M3e.Element.Element { stepPanel : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-stepper>`. -}
stepper : Builder AttrCaps SlotCaps msg
stepper =
    Builder
        { headerPosition = Nothing
        , labelPosition = Nothing
        , linear = Nothing
        , orientation = Nothing
        , onChange = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , step = []
        , panel = []
        , phantomMsg_ = Nothing
        }


{-| The position of the step header, when oriented horizontally. (default: `"above"`) -}
headerPosition :
    M3e.Value.Value { above : M3e.Value.Supported, below : M3e.Value.Supported }
    -> Builder { a | headerPosition : M3e.Build.Internal.Available } s msg
    -> Builder { a | headerPosition : M3e.Build.Internal.Used } s msg
headerPosition v_ (Builder f_) =
    Builder { f_ | headerPosition = Just v_ }


{-| The position of the step labels, when oriented horizontally. (default: `"end"`) -}
labelPosition :
    M3e.Value.Value { below : M3e.Value.Supported, end : M3e.Value.Supported }
    -> Builder { a | labelPosition : M3e.Build.Internal.Available } s msg
    -> Builder { a | labelPosition : M3e.Build.Internal.Used } s msg
labelPosition v_ (Builder f_) =
    Builder { f_ | labelPosition = Just v_ }


{-| Whether the validity of previous steps should be checked or not. (default: `false`) -}
linear :
    Bool
    -> Builder { a | linear : M3e.Build.Internal.Available } s msg
    -> Builder { a | linear : M3e.Build.Internal.Used } s msg
linear v_ (Builder f_) =
    Builder { f_ | linear = Just v_ }


{-| The orientation of the stepper. (default: `"horizontal"`) -}
orientation :
    M3e.Value.Value { auto : M3e.Value.Supported
    , horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> Builder { a | orientation : M3e.Build.Internal.Available } s msg
    -> Builder { a | orientation : M3e.Build.Internal.Used } s msg
orientation v_ (Builder f_) =
    Builder { f_ | orientation = Just v_ }


{-| Dispatched when the selected step changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }


{-| Dispatched before the selected state of a step changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg
onBeforeinput v_ (Builder f_) =
    Builder { f_ | onBeforeinput = Just v_ }


{-| Dispatched when the selected state of a step changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg
onInput v_ (Builder f_) =
    Builder { f_ | onInput = Just v_ }


{-| Add an element to the `step` (multi) slot. -}
step :
    M3e.Element.Element { step : M3e.Value.Supported } msg
    -> Builder a s msg
    -> Builder a s msg
step v_ (Builder f_) =
    Builder { f_ | step = List.append f_.step [ v_ ] }


{-| Add an element to the `panel` (multi) slot. -}
panel :
    M3e.Element.Element { stepPanel : M3e.Value.Supported } msg
    -> Builder a s msg
    -> Builder a s msg
panel v_ (Builder f_) =
    Builder { f_ | panel = List.append f_.panel [ v_ ] }


{-| Build the `<m3e-stepper>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | stepper : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Stepper.stepper
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Stepper.headerPosition v_)
                            ]
                         )
                         f_.headerPosition
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Stepper.labelPosition v_)
                            ]
                         )
                         f_.labelPosition
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Stepper.linear v_) ]
                         )
                         f_.linear
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Stepper.orientation v_)
                            ]
                         )
                         f_.orientation
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.Stepper.onChange
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
                                   M3e.Cem.Html.Stepper.onBeforeinput
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
                                   M3e.Cem.Html.Stepper.onInput
                                   v_
                                )
                            ]
                         )
                         f_.onInput
                      )
                  ]
             )
             (List.concat
                  [ List.map
                      (\el_ ->
                         M3e.Element.toNode (M3e.Element.withSlot "step" el_)
                      )
                      f_.step
                  , List.map
                      (\el_ ->
                         M3e.Element.toNode (M3e.Element.withSlot "panel" el_)
                      )
                      f_.panel
                  ]
             )
        )