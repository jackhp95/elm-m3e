module M3e.Build.RichTooltipAction exposing
    ( Builder, AttrCaps, SlotCaps, richTooltipAction, disableRestoreFocus, build
    )

{-|
The ⑤ Build shape for `<m3e-rich-tooltip-action>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.RichTooltipAction as RichTooltipAction`.

@docs Builder, AttrCaps, SlotCaps, richTooltipAction, disableRestoreFocus, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.RichTooltipAction
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-rich-tooltip-action>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disableRestoreFocus : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
    , disableRestoreFocus : Maybe Bool
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-rich-tooltip-action>` with the required fields. -}
richTooltipAction :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg
richTooltipAction req_ =
    Builder
        { content = req_.content
        , disableRestoreFocus = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`) -}
disableRestoreFocus :
    Bool
    -> Builder { a | disableRestoreFocus : M3e.Build.Internal.Available } s msg
    -> Builder { a | disableRestoreFocus : M3e.Build.Internal.Used } s msg
disableRestoreFocus v_ (Builder f_) =
    Builder { f_ | disableRestoreFocus = Just v_ }


{-| Build the `<m3e-rich-tooltip-action>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind
        | richTooltipAction : M3e.Value.Supported
    } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.RichTooltipAction.richTooltipAction
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.RichTooltipAction.disableRestoreFocus
                                   v_
                                )
                            ]
                         )
                         f_.disableRestoreFocus
                      )
                  ]
             )
             (List.concat [ [ M3e.Element.toNode f_.content ] ])
        )