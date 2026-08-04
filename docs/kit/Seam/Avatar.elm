module Seam.Avatar exposing (initials)

{-| A default **avatar** paint — the classic "initials on a colored disc".

`M3e.Avatar` is a bare semantic slot with no visual of its own, so painting the
familiar circular avatar means composing a `Seam.Surface` role, a `Seam.Shape`
corner, and a centered layout. `initials` bundles that scaffold (and the inline
`flex` fix an `Avatar` needs to render inside a `ListItem.leading` slot) so route
code names the avatar instead of re-deriving the disc.

@docs initials

-}

import HtmlIr.Element exposing (Element)
import M3e
import M3e.Attributes
import M3e.Kind
import M3e.Values as Value
import Seam
import TypedHtml.Attributes as TA


{-| A circular avatar: `initials` centered on a fixed `h-10 w-10`
`secondaryContainer` disc, shaped `full`. Drops straight into a `ListItem.leading`
/ `avatar` slot (the `flex` on the `<m3e-avatar>` makes it render inline).
-}
initials : String -> Element { s | avatar : M3e.Kind.Brand } adm_ msg
initials text =
    M3e.avatar [ TA.class "flex" ]
        [ Seam.node "div"
            [ TA.class "bg-secondary-container text-on-secondary-container rounded-full flex h-10 w-10 items-center justify-center"
            ]
            [ M3e.heading [ M3e.Attributes.variant Value.label, M3e.Attributes.size Value.medium ] [ M3e.text text ] ]
        ]
