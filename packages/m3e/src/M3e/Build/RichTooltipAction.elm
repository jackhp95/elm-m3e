module M3e.Build.RichTooltipAction exposing
    ( Builder, AttrCaps, SlotCaps, richTooltipAction, disableRestoreFocus
    )

{-|
The ⑤ Build shape for `<m3e-rich-tooltip-action>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.RichTooltipAction as RichTooltipAction`.

@docs Builder, AttrCaps, SlotCaps, richTooltipAction, disableRestoreFocus
-}


import M3e.Build.Internal
import M3e.Element
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