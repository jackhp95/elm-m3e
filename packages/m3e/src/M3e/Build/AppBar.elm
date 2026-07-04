module M3e.Build.AppBar exposing
    ( Builder, AttrCaps, SlotCaps, appBar, centered, for
    , size, leading, title, subtitle, leadingIcon, trailingIcon, trailing
    , build
    )

{-|
The ⑤ Build shape for `<m3e-app-bar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.AppBar as AppBar`.

@docs Builder, AttrCaps, SlotCaps, appBar, centered, for
@docs size, leading, title, subtitle, leadingIcon, trailingIcon
@docs trailing, build
-}


import M3e.Build.Internal
import M3e.Cem.AppBar
import M3e.Cem.Attr
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-app-bar>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { centered : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { leading : M3e.Build.Internal.Available
    , title : M3e.Build.Internal.Available
    , subtitle : M3e.Build.Internal.Available
    , leadingIcon : M3e.Build.Internal.Available
    , trailingIcon : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { centered : Maybe Bool
    , for : Maybe String
    , size :
        Maybe (M3e.Value.Value { large : M3e.Value.Supported
        , medium : M3e.Value.Supported
        , small : M3e.Value.Supported
        })
    , leading :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        , button : M3e.Value.Supported
        } msg)
    , title :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , subtitle :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , leadingIcon : Maybe (M3e.Element.Element {} msg)
    , trailingIcon : Maybe (M3e.Element.Element {} msg)
    , trailing :
        List (M3e.Element.Element { iconButton : M3e.Value.Supported
        , button : M3e.Value.Supported
        , searchBar : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-app-bar>`. -}
appBar : Builder AttrCaps SlotCaps msg
appBar =
    Builder
        { centered = Nothing
        , for = Nothing
        , size = Nothing
        , leading = Nothing
        , title = Nothing
        , subtitle = Nothing
        , leadingIcon = Nothing
        , trailingIcon = Nothing
        , trailing = []
        , phantomMsg_ = Nothing
        }


{-| Whether the title and subtitle are centered. (default: `false`) -}
centered :
    Bool
    -> Builder { a | centered : M3e.Build.Internal.Available } s msg
    -> Builder { a | centered : M3e.Build.Internal.Used } s msg
centered v_ (Builder f_) =
    Builder { f_ | centered = Just v_ }


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg
    -> Builder { a | for : M3e.Build.Internal.Used } s msg
for v_ (Builder f_) =
    Builder { f_ | for = Just v_ }


{-| The size of the bar. (default: `"small"`) -}
size :
    M3e.Value.Value { large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg
    -> Builder { a | size : M3e.Build.Internal.Used } s msg
size v_ (Builder f_) =
    Builder { f_ | size = Just v_ }


{-| Set the `leading` slot. Consumes the `leading` slot capability. -}
leading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    , button : M3e.Value.Supported
    } msg
    -> Builder a { s | leading : M3e.Build.Internal.Available } msg
    -> Builder a { s | leading : M3e.Build.Internal.Used } msg
leading v_ (Builder f_) =
    Builder { f_ | leading = Just v_ }


{-| Set the `title` slot. Consumes the `title` slot capability. -}
title :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | title : M3e.Build.Internal.Available } msg
    -> Builder a { s | title : M3e.Build.Internal.Used } msg
title v_ (Builder f_) =
    Builder { f_ | title = Just v_ }


{-| Set the `subtitle` slot. Consumes the `subtitle` slot capability. -}
subtitle :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | subtitle : M3e.Build.Internal.Available } msg
    -> Builder a { s | subtitle : M3e.Build.Internal.Used } msg
subtitle v_ (Builder f_) =
    Builder { f_ | subtitle = Just v_ }


{-| Set the `leading-icon` slot. Consumes the `leadingIcon` slot capability. -}
leadingIcon :
    M3e.Element.Element {} msg
    -> Builder a { s | leadingIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | leadingIcon : M3e.Build.Internal.Used } msg
leadingIcon v_ (Builder f_) =
    Builder { f_ | leadingIcon = Just v_ }


{-| Set the `trailing-icon` slot. Consumes the `trailingIcon` slot capability. -}
trailingIcon :
    M3e.Element.Element {} msg
    -> Builder a { s | trailingIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | trailingIcon : M3e.Build.Internal.Used } msg
trailingIcon v_ (Builder f_) =
    Builder { f_ | trailingIcon = Just v_ }


{-| Add an element to the `trailing` (multi) slot. -}
trailing :
    M3e.Element.Element { iconButton : M3e.Value.Supported
    , button : M3e.Value.Supported
    , searchBar : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
trailing v_ (Builder f_) =
    Builder { f_ | trailing = List.append f_.trailing [ v_ ] }


{-| Build the `<m3e-app-bar>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | appBar : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.AppBar.appBar
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.AppBar.centered v_) ]
                         )
                         f_.centered
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ -> [ M3e.Cem.Attr.forget (M3e.Cem.AppBar.for v_) ]
                         )
                         f_.for
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.AppBar.size v_) ]
                         )
                         f_.size
                      )
                  ]
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "leading" v_)
                            ]
                         )
                         f_.leading
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "title" v_)
                            ]
                         )
                         f_.title
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "subtitle" v_)
                            ]
                         )
                         f_.subtitle
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "leading-icon" v_)
                            ]
                         )
                         f_.leadingIcon
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "trailing-icon" v_)
                            ]
                         )
                         f_.trailingIcon
                      )
                  , List.map
                      (\el_ ->
                         M3e.Element.toNode
                             (M3e.Element.withSlot "trailing" el_)
                      )
                      f_.trailing
                  ]
             )
        )