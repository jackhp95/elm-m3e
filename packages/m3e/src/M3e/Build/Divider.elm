module M3e.Build.Divider exposing
    ( Builder, AttrCaps, SlotCaps, divider, inset, insetStart
    , insetEnd, vertical, build
    )

{-|
The ⑤ Build shape for `<m3e-divider>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Divider as Divider`.

@docs Builder, AttrCaps, SlotCaps, divider, inset, insetStart
@docs insetEnd, vertical, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Divider
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-divider>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { inset : M3e.Build.Internal.Available
    , insetStart : M3e.Build.Internal.Available
    , insetEnd : M3e.Build.Internal.Available
    , vertical : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { inset : Maybe Bool
    , insetStart : Maybe Bool
    , insetEnd : Maybe Bool
    , vertical : Maybe Bool
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-divider>`. -}
divider : Builder AttrCaps SlotCaps msg
divider =
    Builder
        { inset = Nothing
        , insetStart = Nothing
        , insetEnd = Nothing
        , vertical = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether the divider is indented with equal padding on both sides. (default: `false`) -}
inset :
    Bool
    -> Builder { a | inset : M3e.Build.Internal.Available } s msg
    -> Builder { a | inset : M3e.Build.Internal.Used } s msg
inset v_ (Builder f_) =
    Builder { f_ | inset = Just v_ }


{-| Whether the divider is indented with padding on the leading side. (default: `false`) -}
insetStart :
    Bool
    -> Builder { a | insetStart : M3e.Build.Internal.Available } s msg
    -> Builder { a | insetStart : M3e.Build.Internal.Used } s msg
insetStart v_ (Builder f_) =
    Builder { f_ | insetStart = Just v_ }


{-| Whether the divider is indented with padding on the trailing side. (default: `false`) -}
insetEnd :
    Bool
    -> Builder { a | insetEnd : M3e.Build.Internal.Available } s msg
    -> Builder { a | insetEnd : M3e.Build.Internal.Used } s msg
insetEnd v_ (Builder f_) =
    Builder { f_ | insetEnd = Just v_ }


{-| Whether the divider is vertically aligned with adjacent content. (default: `false`) -}
vertical :
    Bool
    -> Builder { a | vertical : M3e.Build.Internal.Available } s msg
    -> Builder { a | vertical : M3e.Build.Internal.Used } s msg
vertical v_ (Builder f_) =
    Builder { f_ | vertical = Just v_ }


{-| Build the `<m3e-divider>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | divider : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Divider.divider
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Divider.inset v_) ]
                         )
                         f_.inset
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Divider.insetStart v_)
                            ]
                         )
                         f_.insetStart
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Divider.insetEnd v_)
                            ]
                         )
                         f_.insetEnd
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Divider.vertical v_)
                            ]
                         )
                         f_.vertical
                      )
                  ]
             )
             (List.concat [])
        )