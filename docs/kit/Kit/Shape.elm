module Kit.Shape exposing
    ( Corner, corner
    , extraSmall, small, medium, large, extraLarge, full, none
    )

{-| M3 **corner-shape** tokens — the visual seam for `rounded-*` classes.

`corner` yields an attribute you compose onto any element (a `Kit.Surface.view`,
a `Native.*` box, …), so route code names the shape (`Kit.Shape.large`) instead
of writing `rounded-md-corner-large` through the seam.

@docs Corner, corner
@docs extraSmall, small, medium, large, extraLarge, full, none

-}

import Html.Attributes
import Markup.Html.Attr exposing (Attr)
import Seam


{-| An M3 corner-radius token.
-}
type Corner
    = Corner String


{-| The corner token as an attribute to compose onto an element.
-}
corner : Corner -> Attr c msg
corner (Corner cls) =
    Seam.asAttribute (Html.Attributes.class cls)


{-| `rounded-md-corner-extra-small`.
-}
extraSmall : Corner
extraSmall =
    Corner "rounded-md-corner-extra-small"


{-| `rounded-md-corner-small`.
-}
small : Corner
small =
    Corner "rounded-md-corner-small"


{-| `rounded-md-corner-medium`.
-}
medium : Corner
medium =
    Corner "rounded-md-corner-medium"


{-| `rounded-md-corner-large`.
-}
large : Corner
large =
    Corner "rounded-md-corner-large"


{-| `rounded-md-corner-extra-large`.
-}
extraLarge : Corner
extraLarge =
    Corner "rounded-md-corner-extra-large"


{-| `rounded-full`.
-}
full : Corner
full =
    Corner "rounded-full"


{-| `rounded-none`.
-}
none : Corner
none =
    Corner "rounded-none"
