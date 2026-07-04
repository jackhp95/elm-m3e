module M3e.Build.Tabs exposing
    ( Builder, AttrCaps, SlotCaps, tabs, disablePagination, headerPosition
    , nextPageLabel, previousPageLabel, stretch, variant, onChange, onBeforeinput, onInput
    , nextIcon, prevIcon, default, panel, build
    )

{-|
The ⑤ Build shape for `<m3e-tabs>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Tabs as Tabs`.

@docs Builder, AttrCaps, SlotCaps, tabs, disablePagination, headerPosition
@docs nextPageLabel, previousPageLabel, stretch, variant, onChange, onBeforeinput
@docs onInput, nextIcon, prevIcon, default, panel, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.Tabs
import M3e.Cem.Tabs
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-tabs>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disablePagination : M3e.Build.Internal.Available
    , headerPosition : M3e.Build.Internal.Available
    , nextPageLabel : M3e.Build.Internal.Available
    , previousPageLabel : M3e.Build.Internal.Available
    , stretch : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { nextIcon : M3e.Build.Internal.Available
    , prevIcon : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { disablePagination : Maybe String
    , headerPosition :
        Maybe (M3e.Value.Value { after : M3e.Value.Supported
        , before : M3e.Value.Supported
        })
    , nextPageLabel : Maybe String
    , previousPageLabel : Maybe String
    , stretch : Maybe Bool
    , variant :
        Maybe (M3e.Value.Value { primary : M3e.Value.Supported
        , secondary : M3e.Value.Supported
        })
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , nextIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , prevIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , default : List (M3e.Element.Element { tab : M3e.Value.Supported } msg)
    , panel : List (M3e.Element.Element { tabPanel : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-tabs>`. -}
tabs : Builder AttrCaps SlotCaps msg
tabs =
    Builder
        { disablePagination = Nothing
        , headerPosition = Nothing
        , nextPageLabel = Nothing
        , previousPageLabel = Nothing
        , stretch = Nothing
        , variant = Nothing
        , onChange = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , nextIcon = Nothing
        , prevIcon = Nothing
        , default = []
        , panel = []
        , phantomMsg_ = Nothing
        }


{-| Whether scroll buttons are disabled. -}
disablePagination :
    String
    -> Builder { a | disablePagination : M3e.Build.Internal.Available } s msg
    -> Builder { a | disablePagination : M3e.Build.Internal.Used } s msg
disablePagination v_ (Builder f_) =
    Builder { f_ | disablePagination = Just v_ }


{-| The position of the tab headers. (default: `"before"`) -}
headerPosition :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> Builder { a | headerPosition : M3e.Build.Internal.Available } s msg
    -> Builder { a | headerPosition : M3e.Build.Internal.Used } s msg
headerPosition v_ (Builder f_) =
    Builder { f_ | headerPosition = Just v_ }


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel :
    String
    -> Builder { a | nextPageLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | nextPageLabel : M3e.Build.Internal.Used } s msg
nextPageLabel v_ (Builder f_) =
    Builder { f_ | nextPageLabel = Just v_ }


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel :
    String
    -> Builder { a | previousPageLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | previousPageLabel : M3e.Build.Internal.Used } s msg
previousPageLabel v_ (Builder f_) =
    Builder { f_ | previousPageLabel = Just v_ }


{-| Whether tabs are stretched to fill the header. (default: `false`) -}
stretch :
    Bool
    -> Builder { a | stretch : M3e.Build.Internal.Available } s msg
    -> Builder { a | stretch : M3e.Build.Internal.Used } s msg
stretch v_ (Builder f_) =
    Builder { f_ | stretch = Just v_ }


{-| The appearance variant of the tabs. (default: `"secondary"`) -}
variant :
    M3e.Value.Value { primary : M3e.Value.Supported
    , secondary : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }


{-| Dispatched when the selected tab changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }


{-| Dispatched before the selected state of a tab changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg
onBeforeinput v_ (Builder f_) =
    Builder { f_ | onBeforeinput = Just v_ }


{-| Dispatched when the selected state of a tab changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg
onInput v_ (Builder f_) =
    Builder { f_ | onInput = Just v_ }


{-| Set the `next-icon` slot. Consumes the `nextIcon` slot capability. -}
nextIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | nextIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | nextIcon : M3e.Build.Internal.Used } msg
nextIcon v_ (Builder f_) =
    Builder { f_ | nextIcon = Just v_ }


{-| Set the `prev-icon` slot. Consumes the `prevIcon` slot capability. -}
prevIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | prevIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | prevIcon : M3e.Build.Internal.Used } msg
prevIcon v_ (Builder f_) =
    Builder { f_ | prevIcon = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default :
    M3e.Element.Element { tab : M3e.Value.Supported } msg
    -> Builder a s msg
    -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Add an element to the `panel` (multi) slot. -}
panel :
    M3e.Element.Element { tabPanel : M3e.Value.Supported } msg
    -> Builder a s msg
    -> Builder a s msg
panel v_ (Builder f_) =
    Builder { f_ | panel = List.append f_.panel [ v_ ] }


{-| Build the `<m3e-tabs>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | tabs : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Tabs.tabs (List.map M3e.Cem.Attr.forget erased_) ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Tabs.disablePagination v_)
                            ]
                         )
                         f_.disablePagination
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Tabs.headerPosition v_)
                            ]
                         )
                         f_.headerPosition
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Tabs.nextPageLabel v_)
                            ]
                         )
                         f_.nextPageLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Tabs.previousPageLabel v_)
                            ]
                         )
                         f_.previousPageLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Tabs.stretch v_) ]
                         )
                         f_.stretch
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Tabs.variant v_) ]
                         )
                         f_.variant
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.Tabs.onChange
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
                                   M3e.Cem.Html.Tabs.onBeforeinput
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
                                   M3e.Cem.Html.Tabs.onInput
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
                                (M3e.Element.withSlot "next-icon" v_)
                            ]
                         )
                         f_.nextIcon
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "prev-icon" v_)
                            ]
                         )
                         f_.prevIcon
                      )
                  , List.map (\el_ -> M3e.Element.toNode el_) f_.default
                  , List.map
                      (\el_ ->
                         M3e.Element.toNode (M3e.Element.withSlot "panel" el_)
                      )
                      f_.panel
                  ]
             )
        )