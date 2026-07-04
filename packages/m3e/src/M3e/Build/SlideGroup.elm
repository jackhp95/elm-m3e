module M3e.Build.SlideGroup exposing
    ( Builder, AttrCaps, SlotCaps, slideGroup, disabled, nextPageLabel
    , previousPageLabel, threshold, vertical, nextIcon, prevIcon, default, build
    )

{-|
The ⑤ Build shape for `<m3e-slide-group>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SlideGroup as SlideGroup`.

@docs Builder, AttrCaps, SlotCaps, slideGroup, disabled, nextPageLabel
@docs previousPageLabel, threshold, vertical, nextIcon, prevIcon, default
@docs build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.SlideGroup
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-slide-group>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , nextPageLabel : M3e.Build.Internal.Available
    , previousPageLabel : M3e.Build.Internal.Available
    , threshold : M3e.Build.Internal.Available
    , vertical : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { nextIcon : M3e.Build.Internal.Available
    , prevIcon : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { disabled : Maybe Bool
    , nextPageLabel : Maybe String
    , previousPageLabel : Maybe String
    , threshold : Maybe Float
    , vertical : Maybe Bool
    , nextIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , prevIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-slide-group>`. -}
slideGroup : Builder AttrCaps SlotCaps msg
slideGroup =
    Builder
        { disabled = Nothing
        , nextPageLabel = Nothing
        , previousPageLabel = Nothing
        , threshold = Nothing
        , vertical = Nothing
        , nextIcon = Nothing
        , prevIcon = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| Whether scroll buttons are disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


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


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`) -}
threshold :
    Float
    -> Builder { a | threshold : M3e.Build.Internal.Available } s msg
    -> Builder { a | threshold : M3e.Build.Internal.Used } s msg
threshold v_ (Builder f_) =
    Builder { f_ | threshold = Just v_ }


{-| Whether content is oriented vertically. (default: `false`) -}
vertical :
    Bool
    -> Builder { a | vertical : M3e.Build.Internal.Available } s msg
    -> Builder { a | vertical : M3e.Build.Internal.Used } s msg
vertical v_ (Builder f_) =
    Builder { f_ | vertical = Just v_ }


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
default : M3e.Element.Element {} msg -> Builder a s msg -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Build the `<m3e-slide-group>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | slideGroup : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.SlideGroup.slideGroup
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SlideGroup.disabled v_)
                            ]
                         )
                         f_.disabled
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SlideGroup.nextPageLabel v_)
                            ]
                         )
                         f_.nextPageLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SlideGroup.previousPageLabel v_)
                            ]
                         )
                         f_.previousPageLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SlideGroup.threshold v_)
                            ]
                         )
                         f_.threshold
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SlideGroup.vertical v_)
                            ]
                         )
                         f_.vertical
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
                  ]
             )
        )