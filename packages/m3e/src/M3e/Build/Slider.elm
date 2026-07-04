module M3e.Build.Slider exposing
    ( Builder, AttrCaps, SlotCaps, slider, disabled, discrete
    , labelled, max, min, step, size, onBeforeinput, onInput
    , onChange, default, build
    )

{-|
The ⑤ Build shape for `<m3e-slider>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Slider as Slider`.

@docs Builder, AttrCaps, SlotCaps, slider, disabled, discrete
@docs labelled, max, min, step, size, onBeforeinput
@docs onInput, onChange, default, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.Slider
import M3e.Cem.Slider
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-slider>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , discrete : M3e.Build.Internal.Available
    , labelled : M3e.Build.Internal.Available
    , max : M3e.Build.Internal.Available
    , min : M3e.Build.Internal.Available
    , step : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.NotFilled }


type alias Fields msg =
    { disabled : Maybe Bool
    , discrete : Maybe Bool
    , labelled : Maybe Bool
    , max : Maybe Float
    , min : Maybe Float
    , step : Maybe Float
    , size :
        Maybe (M3e.Value.Value { extraLarge : M3e.Value.Supported
        , extraSmall : M3e.Value.Supported
        , large : M3e.Value.Supported
        , medium : M3e.Value.Supported
        , small : M3e.Value.Supported
        })
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-slider>`. -}
slider : Builder AttrCaps SlotCaps msg
slider =
    Builder
        { disabled = Nothing
        , discrete = Nothing
        , labelled = Nothing
        , max = Nothing
        , min = Nothing
        , step = Nothing
        , size = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Whether to show tick marks. (default: `false`) -}
discrete :
    Bool
    -> Builder { a | discrete : M3e.Build.Internal.Available } s msg
    -> Builder { a | discrete : M3e.Build.Internal.Used } s msg
discrete v_ (Builder f_) =
    Builder { f_ | discrete = Just v_ }


{-| Whether to show value labels when activated. (default: `false`) -}
labelled :
    Bool
    -> Builder { a | labelled : M3e.Build.Internal.Available } s msg
    -> Builder { a | labelled : M3e.Build.Internal.Used } s msg
labelled v_ (Builder f_) =
    Builder { f_ | labelled = Just v_ }


{-| The maximum allowable value. (default: `100`) -}
max :
    Float
    -> Builder { a | max : M3e.Build.Internal.Available } s msg
    -> Builder { a | max : M3e.Build.Internal.Used } s msg
max v_ (Builder f_) =
    Builder { f_ | max = Just v_ }


{-| The minimum allowable value. (default: `0`) -}
min :
    Float
    -> Builder { a | min : M3e.Build.Internal.Available } s msg
    -> Builder { a | min : M3e.Build.Internal.Used } s msg
min v_ (Builder f_) =
    Builder { f_ | min = Just v_ }


{-| The value at which the thumb will snap. (default: `1`) -}
step :
    Float
    -> Builder { a | step : M3e.Build.Internal.Available } s msg
    -> Builder { a | step : M3e.Build.Internal.Used } s msg
step v_ (Builder f_) =
    Builder { f_ | step = Just v_ }


{-| The size of the slider. (default: `"extra-small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg
    -> Builder { a | size : M3e.Build.Internal.Used } s msg
size v_ (Builder f_) =
    Builder { f_ | size = Just v_ }


{-| Dispatched before the value of a thumb changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg
onBeforeinput v_ (Builder f_) =
    Builder { f_ | onBeforeinput = Just v_ }


{-| Dispatched when the value of a thumb changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg
onInput v_ (Builder f_) =
    Builder { f_ | onInput = Just v_ }


{-| Dispatched when the value of a thumb changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }


{-| Add an element to the required `unnamed` slot. Must be called at least once before `build`. -}
default :
    M3e.Element.Element {} msg
    -> Builder a { s | default : filled } msg
    -> Builder a { s | default : M3e.Build.Internal.Filled } msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Build the `<m3e-slider>` element from a `Builder`. -}
build :
    Builder a { s | default : M3e.Build.Internal.Filled } msg
    -> M3e.Element.Element { kind | slider : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Slider.slider
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Slider.disabled v_) ]
                         )
                         f_.disabled
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Slider.discrete v_) ]
                         )
                         f_.discrete
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Slider.labelled v_) ]
                         )
                         f_.labelled
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ -> [ M3e.Cem.Attr.forget (M3e.Cem.Slider.max v_) ]
                         )
                         f_.max
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ -> [ M3e.Cem.Attr.forget (M3e.Cem.Slider.min v_) ]
                         )
                         f_.min
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Slider.step v_) ]
                         )
                         f_.step
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Slider.size v_) ]
                         )
                         f_.size
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.Slider.onBeforeinput
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
                                   M3e.Cem.Html.Slider.onInput
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
                                   M3e.Cem.Html.Slider.onChange
                                   v_
                                )
                            ]
                         )
                         f_.onChange
                      )
                  ]
             )
             (List.concat
                  [ List.map (\el_ -> M3e.Element.toNode el_) f_.default ]
             )
        )