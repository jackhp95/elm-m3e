module M3e.Build.SelectionList exposing
    ( Builder, AttrCaps, SlotCaps, selectionList, hideSelectionIndicator, multi
    , variant, name, disabled, onChange, onBeforeinput, onInput, default
    , build
    )

{-|
The ⑤ Build shape for `<m3e-selection-list>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SelectionList as SelectionList`.

@docs Builder, AttrCaps, SlotCaps, selectionList, hideSelectionIndicator, multi
@docs variant, name, disabled, onChange, onBeforeinput, onInput
@docs default, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.SelectionList
import M3e.Cem.SelectionList
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-selection-list>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { hideSelectionIndicator : M3e.Build.Internal.Available
    , multi : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { hideSelectionIndicator : Maybe Bool
    , multi : Maybe Bool
    , variant :
        Maybe (M3e.Value.Value { segmented : M3e.Value.Supported
        , standard : M3e.Value.Supported
        })
    , name : Maybe String
    , disabled : Maybe Bool
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , default :
        List (M3e.Element.Element { listOption : M3e.Value.Supported
        , expandableListItem : M3e.Value.Supported
        , divider : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-selection-list>`. -}
selectionList : Builder AttrCaps SlotCaps msg
selectionList =
    Builder
        { hideSelectionIndicator = Nothing
        , multi = Nothing
        , variant = Nothing
        , name = Nothing
        , disabled = Nothing
        , onChange = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> Builder { a
        | hideSelectionIndicator : M3e.Build.Internal.Available
    } s msg
    -> Builder { a | hideSelectionIndicator : M3e.Build.Internal.Used } s msg
hideSelectionIndicator v_ (Builder f_) =
    Builder { f_ | hideSelectionIndicator = Just v_ }


{-| Whether multiple items can be selected. (default: `false`) -}
multi :
    Bool
    -> Builder { a | multi : M3e.Build.Internal.Available } s msg
    -> Builder { a | multi : M3e.Build.Internal.Used } s msg
multi v_ (Builder f_) =
    Builder { f_ | multi = Just v_ }


{-| The appearance variant of the list. (default: `"standard"`) -}
variant :
    M3e.Value.Value { segmented : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }


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


{-| Dispatched when the selected state of an option changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }


{-| Dispatched before the selected state of an option changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg
onBeforeinput v_ (Builder f_) =
    Builder { f_ | onBeforeinput = Just v_ }


{-| Dispatched when the selected state of an option changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg
onInput v_ (Builder f_) =
    Builder { f_ | onInput = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default :
    M3e.Element.Element { listOption : M3e.Value.Supported
    , expandableListItem : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Build the `<m3e-selection-list>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | selectionList : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.SelectionList.selectionList
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SelectionList.hideSelectionIndicator v_
                                )
                            ]
                         )
                         f_.hideSelectionIndicator
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SelectionList.multi v_)
                            ]
                         )
                         f_.multi
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SelectionList.variant v_)
                            ]
                         )
                         f_.variant
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SelectionList.name v_)
                            ]
                         )
                         f_.name
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SelectionList.disabled v_)
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
                                   M3e.Cem.Html.SelectionList.onChange
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
                                   M3e.Cem.Html.SelectionList.onBeforeinput
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
                                   M3e.Cem.Html.SelectionList.onInput
                                   v_
                                )
                            ]
                         )
                         f_.onInput
                      )
                  ]
             )
             (List.concat
                  [ List.map (\el_ -> M3e.Element.toNode el_) f_.default ]
             )
        )