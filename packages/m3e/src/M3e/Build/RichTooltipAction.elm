module M3e.Build.RichTooltipAction exposing ( Builder, AttrCaps, SlotCaps, richTooltipAction )

{-|
The ⑤ Build shape for `<m3e-rich-tooltip-action>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.RichTooltipAction as RichTooltipAction`.

@docs Builder, AttrCaps, SlotCaps, richTooltipAction
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-rich-tooltip-action>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


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