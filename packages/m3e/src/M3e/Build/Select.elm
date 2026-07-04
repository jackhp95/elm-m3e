module M3e.Build.Select exposing
    ( Builder, AttrCaps, SlotCaps, select, disabled, hideSelectionIndicator
    , multi, name, panelClass, required, onChange, onToggle, onBeforeinput
    , onInput, arrow, value, default, build
    )

{-|
The ⑤ Build shape for `<m3e-select>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Select as Select`.

@docs Builder, AttrCaps, SlotCaps, select, disabled, hideSelectionIndicator
@docs multi, name, panelClass, required, onChange, onToggle
@docs onBeforeinput, onInput, arrow, value, default, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.Select
import M3e.Cem.Select
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-select>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , hideSelectionIndicator : M3e.Build.Internal.Available
    , multi : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , panelClass : M3e.Build.Internal.Available
    , required : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { arrow : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , default : M3e.Build.Internal.NotFilled
    }


type alias Fields msg =
    { disabled : Maybe Bool
    , hideSelectionIndicator : Maybe Bool
    , multi : Maybe Bool
    , name : Maybe String
    , panelClass : Maybe String
    , required : Maybe Bool
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , arrow : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , value : Maybe (M3e.Element.Element {} msg)
    , default : List (M3e.Element.Element { option : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-select>`. -}
select : Builder AttrCaps SlotCaps msg
select =
    Builder
        { disabled = Nothing
        , hideSelectionIndicator = Nothing
        , multi = Nothing
        , name = Nothing
        , panelClass = Nothing
        , required = Nothing
        , onChange = Nothing
        , onToggle = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , arrow = Nothing
        , value = Nothing
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


{-| Whether to hide the selection indicator for single select options. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> Builder { a
        | hideSelectionIndicator : M3e.Build.Internal.Available
    } s msg
    -> Builder { a | hideSelectionIndicator : M3e.Build.Internal.Used } s msg
hideSelectionIndicator v_ (Builder f_) =
    Builder { f_ | hideSelectionIndicator = Just v_ }


{-| Whether multiple options can be selected. (default: `false`) -}
multi :
    Bool
    -> Builder { a | multi : M3e.Build.Internal.Available } s msg
    -> Builder { a | multi : M3e.Build.Internal.Used } s msg
multi v_ (Builder f_) =
    Builder { f_ | multi = Just v_ }


{-| The name that identifies the element when submitting the associated form. -}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg
    -> Builder { a | name : M3e.Build.Internal.Used } s msg
name v_ (Builder f_) =
    Builder { f_ | name = Just v_ }


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`) -}
panelClass :
    String
    -> Builder { a | panelClass : M3e.Build.Internal.Available } s msg
    -> Builder { a | panelClass : M3e.Build.Internal.Used } s msg
panelClass v_ (Builder f_) =
    Builder { f_ | panelClass = Just v_ }


{-| Whether the element is required. (default: `false`) -}
required :
    Bool
    -> Builder { a | required : M3e.Build.Internal.Available } s msg
    -> Builder { a | required : M3e.Build.Internal.Used } s msg
required v_ (Builder f_) =
    Builder { f_ | required = Just v_ }


{-| Dispatched when the selected state changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }


{-| onToggle event handler. -}
onToggle :
    Json.Decode.Decoder msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg
onToggle v_ (Builder f_) =
    Builder { f_ | onToggle = Just v_ }


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


{-| Set the `arrow` slot. Consumes the `arrow` slot capability. -}
arrow :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | arrow : M3e.Build.Internal.Available } msg
    -> Builder a { s | arrow : M3e.Build.Internal.Used } msg
arrow v_ (Builder f_) =
    Builder { f_ | arrow = Just v_ }


{-| Set the `value` slot. Consumes the `value` slot capability. -}
value :
    M3e.Element.Element {} msg
    -> Builder a { s | value : M3e.Build.Internal.Available } msg
    -> Builder a { s | value : M3e.Build.Internal.Used } msg
value v_ (Builder f_) =
    Builder { f_ | value = Just v_ }


{-| Add an element to the required `unnamed` slot. Must be called at least once before `build`. -}
default :
    M3e.Element.Element { option : M3e.Value.Supported } msg
    -> Builder a { s | default : filled } msg
    -> Builder a { s | default : M3e.Build.Internal.Filled } msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Build the `<m3e-select>` element from a `Builder`. -}
build :
    Builder a { s | default : M3e.Build.Internal.Filled } msg
    -> M3e.Element.Element { kind | select : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Select.select
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Select.disabled v_) ]
                         )
                         f_.disabled
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Select.hideSelectionIndicator v_)
                            ]
                         )
                         f_.hideSelectionIndicator
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Select.multi v_) ]
                         )
                         f_.multi
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Select.name v_) ]
                         )
                         f_.name
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Select.panelClass v_)
                            ]
                         )
                         f_.panelClass
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Select.required v_) ]
                         )
                         f_.required
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.Select.onChange
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
                                   M3e.Cem.Html.Select.onToggle
                                   v_
                                )
                            ]
                         )
                         f_.onToggle
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.Select.onBeforeinput
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
                                   M3e.Cem.Html.Select.onInput
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
                                (M3e.Element.withSlot "arrow" v_)
                            ]
                         )
                         f_.arrow
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "value" v_)
                            ]
                         )
                         f_.value
                      )
                  , List.map (\el_ -> M3e.Element.toNode el_) f_.default
                  ]
             )
        )