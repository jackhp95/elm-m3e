module M3e.Build.Tooltip exposing
    ( Builder, AttrCaps, SlotCaps, tooltip, disabled, for
    , hideDelay, position, showDelay, touchGestures, build
    )

{-|
The ⑤ Build shape for `<m3e-tooltip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Tooltip as Tooltip`.

@docs Builder, AttrCaps, SlotCaps, tooltip, disabled, for
@docs hideDelay, position, showDelay, touchGestures, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Tooltip
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-tooltip>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , hideDelay : M3e.Build.Internal.Available
    , position : M3e.Build.Internal.Available
    , showDelay : M3e.Build.Internal.Available
    , touchGestures : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
    , disabled : Maybe Bool
    , for : Maybe String
    , hideDelay : Maybe Float
    , position :
        Maybe (M3e.Value.Value { above : M3e.Value.Supported
        , after : M3e.Value.Supported
        , before : M3e.Value.Supported
        , below : M3e.Value.Supported
        })
    , showDelay : Maybe Float
    , touchGestures :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , off : M3e.Value.Supported
        , on : M3e.Value.Supported
        })
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-tooltip>` with the required fields. -}
tooltip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg
tooltip req_ =
    Builder
        { content = req_.content
        , disabled = Nothing
        , for = Nothing
        , hideDelay = Nothing
        , position = Nothing
        , showDelay = Nothing
        , touchGestures = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg
    -> Builder { a | for : M3e.Build.Internal.Used } s msg
for v_ (Builder f_) =
    Builder { f_ | for = Just v_ }


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay :
    Float
    -> Builder { a | hideDelay : M3e.Build.Internal.Available } s msg
    -> Builder { a | hideDelay : M3e.Build.Internal.Used } s msg
hideDelay v_ (Builder f_) =
    Builder { f_ | hideDelay = Just v_ }


{-| The position of the tooltip. (default: `"below"`) -}
position :
    M3e.Value.Value { above : M3e.Value.Supported
    , after : M3e.Value.Supported
    , before : M3e.Value.Supported
    , below : M3e.Value.Supported
    }
    -> Builder { a | position : M3e.Build.Internal.Available } s msg
    -> Builder { a | position : M3e.Build.Internal.Used } s msg
position v_ (Builder f_) =
    Builder { f_ | position = Just v_ }


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay :
    Float
    -> Builder { a | showDelay : M3e.Build.Internal.Available } s msg
    -> Builder { a | showDelay : M3e.Build.Internal.Used } s msg
showDelay v_ (Builder f_) =
    Builder { f_ | showDelay = Just v_ }


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures :
    M3e.Value.Value { auto : M3e.Value.Supported
    , off : M3e.Value.Supported
    , on : M3e.Value.Supported
    }
    -> Builder { a | touchGestures : M3e.Build.Internal.Available } s msg
    -> Builder { a | touchGestures : M3e.Build.Internal.Used } s msg
touchGestures v_ (Builder f_) =
    Builder { f_ | touchGestures = Just v_ }


{-| Build the `<m3e-tooltip>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | tooltip : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Tooltip.tooltip
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Tooltip.disabled v_)
                            ]
                         )
                         f_.disabled
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Tooltip.for v_) ]
                         )
                         f_.for
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Tooltip.hideDelay v_)
                            ]
                         )
                         f_.hideDelay
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Tooltip.position v_)
                            ]
                         )
                         f_.position
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Tooltip.showDelay v_)
                            ]
                         )
                         f_.showDelay
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Tooltip.touchGestures v_)
                            ]
                         )
                         f_.touchGestures
                      )
                  ]
             )
             (List.concat [ [ M3e.Element.toNode f_.content ] ])
        )