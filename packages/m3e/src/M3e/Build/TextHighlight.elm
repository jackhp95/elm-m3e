module M3e.Build.TextHighlight exposing
    ( Builder, AttrCaps, SlotCaps, textHighlight, caseSensitive, disabled
    , mode, term, onHighlight, default, build
    )

{-|
The ⑤ Build shape for `<m3e-text-highlight>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TextHighlight as TextHighlight`.

@docs Builder, AttrCaps, SlotCaps, textHighlight, caseSensitive, disabled
@docs mode, term, onHighlight, default, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.TextHighlight
import M3e.Cem.TextHighlight
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-text-highlight>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { caseSensitive : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , mode : M3e.Build.Internal.Available
    , term : M3e.Build.Internal.Available
    , onHighlight : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { caseSensitive : Maybe Bool
    , disabled : Maybe Bool
    , mode :
        Maybe (M3e.Value.Value { contains : M3e.Value.Supported
        , endsWith : M3e.Value.Supported
        , startsWith : M3e.Value.Supported
        })
    , term : Maybe String
    , onHighlight : Maybe (Json.Decode.Decoder msg)
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-text-highlight>`. -}
textHighlight : Builder AttrCaps SlotCaps msg
textHighlight =
    Builder
        { caseSensitive = Nothing
        , disabled = Nothing
        , mode = Nothing
        , term = Nothing
        , onHighlight = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| Whether matching is case sensitive. (default: `false`) -}
caseSensitive :
    Bool
    -> Builder { a | caseSensitive : M3e.Build.Internal.Available } s msg
    -> Builder { a | caseSensitive : M3e.Build.Internal.Used } s msg
caseSensitive v_ (Builder f_) =
    Builder { f_ | caseSensitive = Just v_ }


{-| A value indicating whether text highlighting is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| The mode in which to highlight text. (default: `"contains"`) -}
mode :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> Builder { a | mode : M3e.Build.Internal.Available } s msg
    -> Builder { a | mode : M3e.Build.Internal.Used } s msg
mode v_ (Builder f_) =
    Builder { f_ | mode = Just v_ }


{-| The term to highlight. (default: `""`) -}
term :
    String
    -> Builder { a | term : M3e.Build.Internal.Available } s msg
    -> Builder { a | term : M3e.Build.Internal.Used } s msg
term v_ (Builder f_) =
    Builder { f_ | term = Just v_ }


{-| Dispatched when content is highlighted. -}
onHighlight :
    Json.Decode.Decoder msg
    -> Builder { a | onHighlight : M3e.Build.Internal.Available } s msg
    -> Builder { a | onHighlight : M3e.Build.Internal.Used } s msg
onHighlight v_ (Builder f_) =
    Builder { f_ | onHighlight = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default : M3e.Element.Element {} msg -> Builder a s msg -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Build the `<m3e-text-highlight>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | textHighlight : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.TextHighlight.textHighlight
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.TextHighlight.caseSensitive v_)
                            ]
                         )
                         f_.caseSensitive
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.TextHighlight.disabled v_)
                            ]
                         )
                         f_.disabled
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.TextHighlight.mode v_)
                            ]
                         )
                         f_.mode
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.TextHighlight.term v_)
                            ]
                         )
                         f_.term
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.TextHighlight.onHighlight
                                   v_
                                )
                            ]
                         )
                         f_.onHighlight
                      )
                  ]
             )
             (List.concat
                  [ List.map (\el_ -> M3e.Element.toNode el_) f_.default ]
             )
        )