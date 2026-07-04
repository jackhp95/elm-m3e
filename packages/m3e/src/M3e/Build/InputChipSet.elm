module M3e.Build.InputChipSet exposing
    ( Builder, AttrCaps, SlotCaps, inputChipSet, disabled, name
    , required, vertical, onChange, input, default, build
    )

{-|
The ⑤ Build shape for `<m3e-input-chip-set>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.InputChipSet as InputChipSet`.

@docs Builder, AttrCaps, SlotCaps, inputChipSet, disabled, name
@docs required, vertical, onChange, input, default, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.InputChipSet
import M3e.Cem.InputChipSet
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-input-chip-set>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , required : M3e.Build.Internal.Available
    , vertical : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { input : M3e.Build.Internal.Available }


type alias Fields msg =
    { disabled : Maybe Bool
    , name : Maybe String
    , required : Maybe Bool
    , vertical : Maybe Bool
    , onChange : Maybe (Json.Decode.Decoder msg)
    , input : Maybe (M3e.Element.Element {} msg)
    , default :
        List (M3e.Element.Element { inputChip : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-input-chip-set>`. -}
inputChipSet : Builder AttrCaps SlotCaps msg
inputChipSet =
    Builder
        { disabled = Nothing
        , name = Nothing
        , required = Nothing
        , vertical = Nothing
        , onChange = Nothing
        , input = Nothing
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


{-| The name that identifies the element when submitting the associated form. -}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg
    -> Builder { a | name : M3e.Build.Internal.Used } s msg
name v_ (Builder f_) =
    Builder { f_ | name = Just v_ }


{-| Whether a value is required for the element. (default: `false`) -}
required :
    Bool
    -> Builder { a | required : M3e.Build.Internal.Available } s msg
    -> Builder { a | required : M3e.Build.Internal.Used } s msg
required v_ (Builder f_) =
    Builder { f_ | required = Just v_ }


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical :
    Bool
    -> Builder { a | vertical : M3e.Build.Internal.Available } s msg
    -> Builder { a | vertical : M3e.Build.Internal.Used } s msg
vertical v_ (Builder f_) =
    Builder { f_ | vertical = Just v_ }


{-| Dispatched when a chip is added to, or removed from, the set. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }


{-| Set the `input` slot. Consumes the `input` slot capability. -}
input :
    M3e.Element.Element {} msg
    -> Builder a { s | input : M3e.Build.Internal.Available } msg
    -> Builder a { s | input : M3e.Build.Internal.Used } msg
input v_ (Builder f_) =
    Builder { f_ | input = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default :
    M3e.Element.Element { inputChip : M3e.Value.Supported } msg
    -> Builder a s msg
    -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Build the `<m3e-input-chip-set>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | inputChipSet : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.InputChipSet.inputChipSet
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.InputChipSet.disabled v_)
                            ]
                         )
                         f_.disabled
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.InputChipSet.name v_)
                            ]
                         )
                         f_.name
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.InputChipSet.required v_)
                            ]
                         )
                         f_.required
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.InputChipSet.vertical v_)
                            ]
                         )
                         f_.vertical
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.InputChipSet.onChange
                                   v_
                                )
                            ]
                         )
                         f_.onChange
                      )
                  ]
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "input" v_)
                            ]
                         )
                         f_.input
                      )
                  , List.map (\el_ -> M3e.Element.toNode el_) f_.default
                  ]
             )
        )