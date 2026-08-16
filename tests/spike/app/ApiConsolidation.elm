module ApiConsolidation exposing (annotationGate, card, saveButton)

{-| Compile-only spike for the canonical zero-conversion API, post `el`-unification
(elm-cem L1/L2, plan §3.5B superseded — the fluent-builder `M3e.Build.*` surface this
spike originally exercised was deleted wholesale; every component now has ONE `el`,
bare or required-record, that already returns a slot-ready `Element` with no
intermediate conversion step at all).

Direction (a): THE canonical snippet — a nested component composes directly into a
slot, no unwrap/rewrap.
Direction (b): child `el` result flows straight into a container's slot setter.
Annotation-only: naming a component's phantom type with only the slim import.

-}

import HtmlIr.Element exposing (Element)
import M3e exposing (text)
import M3e.Action exposing (onClick)
import M3e.Component.Button as Button
import M3e.Component.Card as Card
import M3e.Component.Icon as Icon
import M3e.Values as Value


type Msg
    = Save
    | Ok


{-| Direction (a): THE canonical zero-conversion snippet (post `el`-unification).

    `Button.component` is required-record (content + action); its icon slot setter takes
    a nested `Icon.component` call directly — no `.toElement`, no builder pipe, nothing to
    unwrap. Only `Button`/`Icon` component-module imports.

-}
saveButton : Element (Button.Is s) admittedBy Msg
saveButton =
    Button.component
        { content = text "Save", action = onClick Save }
        []
        [ Button.icon (Icon.component [ Icon.name "home" ] []) ]


{-| Direction (b): a child component's `el` result flows into a container's slot
setter with zero unwrap.

    A `Button.component` value flows into a `Card` slot with zero conversion — it already
    IS the slot-ready `Element`, same as direction (a).

-}
card : Element (Card.Is s) admittedBy Msg
card =
    Card.component
        []
        [ Card.content
            (Button.component
                { content = text "Ok", action = onClick Ok }
                [ Button.variant Value.filled ]
                []
            )
        ]


{-| Annotation-only: slim import to name a type.

    Imports only `M3e.Component.Button` (not the barrel) for the `Button.Is`
    phantom.

-}
annotationGate : List (Element (Button.Is s) admittedBy Msg)
annotationGate =
    [ saveButton ]
