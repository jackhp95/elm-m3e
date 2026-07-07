module Kit.Avatar exposing (initials)

{-| A default **avatar** paint — the classic "initials on a colored disc".

`M3e.Avatar` is a bare semantic slot with no visual of its own, so painting the
familiar circular avatar means composing a `Kit.Surface` role, a `Kit.Shape`
corner, and a centered layout. `initials` bundles that scaffold (and the inline
`flex` fix an `Avatar` needs to render inside a `ListItem.leading` slot) so route
code names the avatar instead of re-deriving the disc.

@docs initials

-}

import Html.Attributes
import Kit
import Kit.Shape as Shape
import Kit.Surface as Surface
import M3e.Avatar as Avatar
import M3e.Element exposing (Element)
import M3e.Value as Value exposing (Supported)
import Seam


{-| A circular avatar: `initials` centered on a fixed `h-10 w-10`
`secondaryContainer` disc, shaped `full`. Drops straight into a `ListItem.leading`
/ `avatar` slot (the `flex` on the `<m3e-avatar>` makes it render inline).
-}
initials : String -> Element { s | avatar : Supported } msg
initials text =
    Avatar.view [ Seam.asAttribute (Html.Attributes.class "flex") ]
        [ Avatar.child
            (Surface.view Surface.secondaryContainer
                [ Shape.corner Shape.full
                , Seam.asAttribute (Html.Attributes.class "flex h-10 w-10 items-center justify-center")
                ]
                [ Kit.labelText Value.medium [] [ Kit.text text ] ]
            )
        ]
