module M3e.Build.Option exposing
    ( Builder, AttrCaps, SlotCaps, option, disabled, disableHighlight
    , highlightMode, selected, term, value, build
    )

{-|
The ⑤ Build shape for `<m3e-option>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Option as Option`.

@docs Builder, AttrCaps, SlotCaps, option, disabled, disableHighlight
@docs highlightMode, selected, term, value, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Option
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-option>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , disableHighlight : M3e.Build.Internal.Available
    , highlightMode : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , term : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
    , disabled : Maybe Bool
    , disableHighlight : Maybe Bool
    , highlightMode :
        Maybe (M3e.Value.Value { contains : M3e.Value.Supported
        , endsWith : M3e.Value.Supported
        , startsWith : M3e.Value.Supported
        })
    , selected : Maybe Bool
    , term : Maybe String
    , value : Maybe String
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-option>` with the required fields. -}
option :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg
option req_ =
    Builder
        { content = req_.content
        , disabled = Nothing
        , disableHighlight = Nothing
        , highlightMode = Nothing
        , selected = Nothing
        , term = Nothing
        , value = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Whether text highlighting is disabled. (default: `false`) -}
disableHighlight :
    Bool
    -> Builder { a | disableHighlight : M3e.Build.Internal.Available } s msg
    -> Builder { a | disableHighlight : M3e.Build.Internal.Used } s msg
disableHighlight v_ (Builder f_) =
    Builder { f_ | disableHighlight = Just v_ }


{-| The mode in which to highlight a term. (default: `"contains"`) -}
highlightMode :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> Builder { a | highlightMode : M3e.Build.Internal.Available } s msg
    -> Builder { a | highlightMode : M3e.Build.Internal.Used } s msg
highlightMode v_ (Builder f_) =
    Builder { f_ | highlightMode = Just v_ }


{-| Whether the element is selected. (default: `false`) -}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg
    -> Builder { a | selected : M3e.Build.Internal.Used } s msg
selected v_ (Builder f_) =
    Builder { f_ | selected = Just v_ }


{-| The search term to highlight. (default: `""`) -}
term :
    String
    -> Builder { a | term : M3e.Build.Internal.Available } s msg
    -> Builder { a | term : M3e.Build.Internal.Used } s msg
term v_ (Builder f_) =
    Builder { f_ | term = Just v_ }


{-| A string representing the value of the option. -}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg
    -> Builder { a | value : M3e.Build.Internal.Used } s msg
value v_ (Builder f_) =
    Builder { f_ | value = Just v_ }


{-| Build the `<m3e-option>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | option : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Option.option
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Option.disabled v_) ]
                         )
                         f_.disabled
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Option.disableHighlight v_)
                            ]
                         )
                         f_.disableHighlight
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Option.highlightMode v_)
                            ]
                         )
                         f_.highlightMode
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Option.selected v_) ]
                         )
                         f_.selected
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Option.term v_) ]
                         )
                         f_.term
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Option.value v_) ]
                         )
                         f_.value
                      )
                  ]
             )
             (List.concat [ [ M3e.Element.toNode f_.content ] ])
        )