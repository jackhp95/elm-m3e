module M3e.Build.SearchBar exposing
    ( Builder, AttrCaps, SlotCaps, searchBar, clearable, clearLabel
    , onClear, clearIcon, leading, trailing, build
    )

{-|
The ⑤ Build shape for `<m3e-search-bar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SearchBar as SearchBar`.

@docs Builder, AttrCaps, SlotCaps, searchBar, clearable, clearLabel
@docs onClear, clearIcon, leading, trailing, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.SearchBar
import M3e.Cem.SearchBar
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-search-bar>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { clearable : M3e.Build.Internal.Available
    , clearLabel : M3e.Build.Internal.Available
    , onClear : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { clearIcon : M3e.Build.Internal.Available }


type alias Fields msg =
    { input : M3e.Element.Element {} msg
    , clearable : Maybe Bool
    , clearLabel : Maybe String
    , onClear : Maybe (Json.Decode.Decoder msg)
    , clearIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , leading :
        List (M3e.Element.Element { icon : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        } msg)
    , trailing :
        List (M3e.Element.Element { icon : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-search-bar>` with the required fields. -}
searchBar :
    { input : M3e.Element.Element {} msg } -> Builder AttrCaps SlotCaps msg
searchBar req_ =
    Builder
        { input = req_.input
        , clearable = Nothing
        , clearLabel = Nothing
        , onClear = Nothing
        , clearIcon = Nothing
        , leading = []
        , trailing = []
        , phantomMsg_ = Nothing
        }


{-| Whether the bar presents a button used to clear the search term. (default: `false`) -}
clearable :
    Bool
    -> Builder { a | clearable : M3e.Build.Internal.Available } s msg
    -> Builder { a | clearable : M3e.Build.Internal.Used } s msg
clearable v_ (Builder f_) =
    Builder { f_ | clearable = Just v_ }


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`) -}
clearLabel :
    String
    -> Builder { a | clearLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | clearLabel : M3e.Build.Internal.Used } s msg
clearLabel v_ (Builder f_) =
    Builder { f_ | clearLabel = Just v_ }


{-| Dispatched when the search term is cleared. -}
onClear :
    Json.Decode.Decoder msg
    -> Builder { a | onClear : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClear : M3e.Build.Internal.Used } s msg
onClear v_ (Builder f_) =
    Builder { f_ | onClear = Just v_ }


{-| Set the `clear-icon` slot. Consumes the `clearIcon` slot capability. -}
clearIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | clearIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | clearIcon : M3e.Build.Internal.Used } msg
clearIcon v_ (Builder f_) =
    Builder { f_ | clearIcon = Just v_ }


{-| Add an element to the `leading` (multi) slot. -}
leading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
leading v_ (Builder f_) =
    Builder { f_ | leading = List.append f_.leading [ v_ ] }


{-| Add an element to the `trailing` (multi) slot. -}
trailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
trailing v_ (Builder f_) =
    Builder { f_ | trailing = List.append f_.trailing [ v_ ] }


{-| Build the `<m3e-search-bar>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | searchBar : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.SearchBar.searchBar
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SearchBar.clearable v_)
                            ]
                         )
                         f_.clearable
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SearchBar.clearLabel v_)
                            ]
                         )
                         f_.clearLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.SearchBar.onClear
                                   v_
                                )
                            ]
                         )
                         f_.onClear
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
                                (M3e.Element.withSlot "clear-icon" v_)
                            ]
                         )
                         f_.clearIcon
                      )
                  , List.map
                      (\el_ ->
                         M3e.Element.toNode (M3e.Element.withSlot "leading" el_)
                      )
                      f_.leading
                  , List.map
                      (\el_ ->
                         M3e.Element.toNode
                             (M3e.Element.withSlot "trailing" el_)
                      )
                      f_.trailing
                  ]
             )
        )