module WrongKindBuilderIntoIconSlot exposing (wrong)

{-| NEGATIVE probe, post `el`-unification: a Button element (kind
`{ s | button : Brand }`) passed into `Button.icon`, which expects an element
whose kind admits `Component.IconSlot` (`{ loadingIndicator : Brand, sharedIcon
: Shared }`). (Pre-unification this exercised the fluent-builder `withIcon`
setter, deleted along with `M3e.Build.*` — the same closed-row rejection now
lives on the component module's `icon` slot setter.)

Must FAIL to compile — `{ s | button : Brand }` does not extend
`{ loadingIndicator : Brand, sharedIcon : Shared }`.

-}

import HtmlIr.Element exposing (Element)
import M3e exposing (text)
import M3e.Action exposing (onClick)
import M3e.Component.Button as Button


type Msg
    = Save


wrong : Element (Button.Is s) b Msg
wrong =
    Button.component
        { content = text "Save", action = onClick Save }
        []
        [ Button.icon (Button.component { content = text "Nope", action = onClick Save } [] []) ]
