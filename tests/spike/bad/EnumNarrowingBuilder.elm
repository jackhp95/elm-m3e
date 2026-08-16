module EnumNarrowingBuilder exposing (wrong)

{-| NEGATIVE probe, post `el`-unification: Button.variant given a
foreign-component token — must FAIL. (Pre-unification this exercised the
fluent-builder `withVariant` setter, deleted along with `M3e.Build.*` — the
same closed-row rejection now lives on the component module's `variant`
attribute setter, used directly in `el`'s attrs list.)

Button.Variant = { elevated, filled, outlined, text, tonal } — NO rainbow.
V.rainbow : Value { v | rainbow : Supported } is a valid Theme token but does
NOT extend Button's closed Component.Variant row.

The setter's signature is:
Value Component.Variant -> Attr { c | variant : Supported } msg
where Component.Variant = { elevated, filled, outlined, text, tonal }

Passing V.rainbow (a Theme token) here must produce a TYPE MISMATCH.

-}

import HtmlIr.Element exposing (Element)
import M3e exposing (text)
import M3e.Action exposing (onClick)
import M3e.Component.Button as Button
import M3e.Values as V


type Msg
    = Save


wrong : Element (Button.Is s) admittedBy Msg
wrong =
    Button.component { content = text "Save", action = onClick Save } [ Button.variant V.rainbow ] []
