module M3e.Build.SearchView exposing
    ( Builder, AttrCaps, SlotCaps, searchView, contained, mode
    , open, clearLabel, closeLabel, hideSearchIcon, onQuery, onClear, onBeforetoggle
    , onToggle, searchIcon, closeIcon, clearIcon, default, openLeading, openTrailing
    , closedLeading, closedTrailing, build
    )

{-|
The ⑤ Build shape for `<m3e-search-view>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SearchView as SearchView`.

@docs Builder, AttrCaps, SlotCaps, searchView, contained, mode
@docs open, clearLabel, closeLabel, hideSearchIcon, onQuery, onClear
@docs onBeforetoggle, onToggle, searchIcon, closeIcon, clearIcon, default
@docs openLeading, openTrailing, closedLeading, closedTrailing, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.SearchView
import M3e.Cem.SearchView
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-search-view>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { contained : M3e.Build.Internal.Available
    , mode : M3e.Build.Internal.Available
    , open : M3e.Build.Internal.Available
    , clearLabel : M3e.Build.Internal.Available
    , closeLabel : M3e.Build.Internal.Available
    , hideSearchIcon : M3e.Build.Internal.Available
    , onQuery : M3e.Build.Internal.Available
    , onClear : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { searchIcon : M3e.Build.Internal.Available
    , closeIcon : M3e.Build.Internal.Available
    , clearIcon : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { input : M3e.Element.Element {} msg
    , contained : Maybe Bool
    , mode :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , docked : M3e.Value.Supported
        , fullscreen : M3e.Value.Supported
        })
    , open : Maybe Bool
    , clearLabel : Maybe String
    , closeLabel : Maybe String
    , hideSearchIcon : Maybe Bool
    , onQuery : Maybe (Json.Decode.Decoder msg)
    , onClear : Maybe (Json.Decode.Decoder msg)
    , onBeforetoggle : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    , searchIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , closeIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , clearIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , default : List (M3e.Element.Element {} msg)
    , openLeading :
        List (M3e.Element.Element { icon : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        } msg)
    , openTrailing :
        List (M3e.Element.Element { icon : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        } msg)
    , closedLeading :
        List (M3e.Element.Element { icon : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        } msg)
    , closedTrailing :
        List (M3e.Element.Element { icon : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-search-view>` with the required fields. -}
searchView :
    { input : M3e.Element.Element {} msg } -> Builder AttrCaps SlotCaps msg
searchView req_ =
    Builder
        { input = req_.input
        , contained = Nothing
        , mode = Nothing
        , open = Nothing
        , clearLabel = Nothing
        , closeLabel = Nothing
        , hideSearchIcon = Nothing
        , onQuery = Nothing
        , onClear = Nothing
        , onBeforetoggle = Nothing
        , onToggle = Nothing
        , searchIcon = Nothing
        , closeIcon = Nothing
        , clearIcon = Nothing
        , default = []
        , openLeading = []
        , openTrailing = []
        , closedLeading = []
        , closedTrailing = []
        , phantomMsg_ = Nothing
        }


{-| Whether the view features a persistent, filled search container. (default: `false`) -}
contained :
    Bool
    -> Builder { a | contained : M3e.Build.Internal.Available } s msg
    -> Builder { a | contained : M3e.Build.Internal.Used } s msg
contained v_ (Builder f_) =
    Builder { f_ | contained = Just v_ }


{-| The behavior mode of the view. (default: `"docked"`) -}
mode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , docked : M3e.Value.Supported
    , fullscreen : M3e.Value.Supported
    }
    -> Builder { a | mode : M3e.Build.Internal.Available } s msg
    -> Builder { a | mode : M3e.Build.Internal.Used } s msg
mode v_ (Builder f_) =
    Builder { f_ | mode = Just v_ }


{-| Whether the view is expanded to show results. (default: `false`) -}
open :
    Bool
    -> Builder { a | open : M3e.Build.Internal.Available } s msg
    -> Builder { a | open : M3e.Build.Internal.Used } s msg
open v_ (Builder f_) =
    Builder { f_ | open = Just v_ }


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`) -}
clearLabel :
    String
    -> Builder { a | clearLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | clearLabel : M3e.Build.Internal.Used } s msg
clearLabel v_ (Builder f_) =
    Builder { f_ | clearLabel = Just v_ }


{-| The accessible label given to the button used to collapse the view. (default: `"Close"`) -}
closeLabel :
    String
    -> Builder { a | closeLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | closeLabel : M3e.Build.Internal.Used } s msg
closeLabel v_ (Builder f_) =
    Builder { f_ | closeLabel = Just v_ }


{-| Whether to hide the search icon. (default: `false`) -}
hideSearchIcon :
    Bool
    -> Builder { a | hideSearchIcon : M3e.Build.Internal.Available } s msg
    -> Builder { a | hideSearchIcon : M3e.Build.Internal.Used } s msg
hideSearchIcon v_ (Builder f_) =
    Builder { f_ | hideSearchIcon = Just v_ }


{-| Dispatched when the view is opened or when the user modifies the search term. -}
onQuery :
    Json.Decode.Decoder msg
    -> Builder { a | onQuery : M3e.Build.Internal.Available } s msg
    -> Builder { a | onQuery : M3e.Build.Internal.Used } s msg
onQuery v_ (Builder f_) =
    Builder { f_ | onQuery = Just v_ }


{-| Dispatched when the search term is cleared. -}
onClear :
    Json.Decode.Decoder msg
    -> Builder { a | onClear : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClear : M3e.Build.Internal.Used } s msg
onClear v_ (Builder f_) =
    Builder { f_ | onClear = Just v_ }


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


{-| Set the `search-icon` slot. Consumes the `searchIcon` slot capability. -}
searchIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | searchIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | searchIcon : M3e.Build.Internal.Used } msg
searchIcon v_ (Builder f_) =
    Builder { f_ | searchIcon = Just v_ }


{-| Set the `close-icon` slot. Consumes the `closeIcon` slot capability. -}
closeIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | closeIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | closeIcon : M3e.Build.Internal.Used } msg
closeIcon v_ (Builder f_) =
    Builder { f_ | closeIcon = Just v_ }


{-| Set the `clear-icon` slot. Consumes the `clearIcon` slot capability. -}
clearIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | clearIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | clearIcon : M3e.Build.Internal.Used } msg
clearIcon v_ (Builder f_) =
    Builder { f_ | clearIcon = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default : M3e.Element.Element {} msg -> Builder a s msg -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Add an element to the `open-leading` (multi) slot. -}
openLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
openLeading v_ (Builder f_) =
    Builder { f_ | openLeading = List.append f_.openLeading [ v_ ] }


{-| Add an element to the `open-trailing` (multi) slot. -}
openTrailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
openTrailing v_ (Builder f_) =
    Builder { f_ | openTrailing = List.append f_.openTrailing [ v_ ] }


{-| Add an element to the `closed-leading` (multi) slot. -}
closedLeading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
closedLeading v_ (Builder f_) =
    Builder { f_ | closedLeading = List.append f_.closedLeading [ v_ ] }


{-| Add an element to the `closed-trailing` (multi) slot. -}
closedTrailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
closedTrailing v_ (Builder f_) =
    Builder { f_ | closedTrailing = List.append f_.closedTrailing [ v_ ] }


{-| Build the `<m3e-search-view>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | searchView : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.SearchView.searchView
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SearchView.contained v_)
                            ]
                         )
                         f_.contained
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.SearchView.mode v_) ]
                         )
                         f_.mode
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.SearchView.open v_) ]
                         )
                         f_.open
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SearchView.clearLabel v_)
                            ]
                         )
                         f_.clearLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SearchView.closeLabel v_)
                            ]
                         )
                         f_.closeLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SearchView.hideSearchIcon v_)
                            ]
                         )
                         f_.hideSearchIcon
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.SearchView.onQuery
                                   v_
                                )
                            ]
                         )
                         f_.onQuery
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.SearchView.onClear
                                   v_
                                )
                            ]
                         )
                         f_.onClear
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.SearchView.onBeforetoggle
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
                                   M3e.Cem.Html.SearchView.onToggle
                                   v_
                                )
                            ]
                         )
                         f_.onToggle
                      )
                  ]
             )
             (List.concat
                  [ [ M3e.Element.toNode (M3e.Element.withSlot "input" f_.input)
                    ]
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "search-icon" v_)
                            ]
                         )
                         f_.searchIcon
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "close-icon" v_)
                            ]
                         )
                         f_.closeIcon
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "clear-icon" v_)
                            ]
                         )
                         f_.clearIcon
                      )
                  , List.map (\el_ -> M3e.Element.toNode el_) f_.default
                  , List.map
                      (\el_ ->
                         M3e.Element.toNode
                             (M3e.Element.withSlot "open-leading" el_)
                      )
                      f_.openLeading
                  , List.map
                      (\el_ ->
                         M3e.Element.toNode
                             (M3e.Element.withSlot "open-trailing" el_)
                      )
                      f_.openTrailing
                  , List.map
                      (\el_ ->
                         M3e.Element.toNode
                             (M3e.Element.withSlot "closed-leading" el_)
                      )
                      f_.closedLeading
                  , List.map
                      (\el_ ->
                         M3e.Element.toNode
                             (M3e.Element.withSlot "closed-trailing" el_)
                      )
                      f_.closedTrailing
                  ]
             )
        )