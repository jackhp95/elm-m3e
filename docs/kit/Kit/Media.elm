module Kit.Media exposing (view)

{-| M3 **card media** — a shape-clipped surface region for a card's media.

`m3e-card` has no dedicated media slot: media lives in the card's default
(unpadded) content area. To read as M3 card media it must be tinted _and_
corner-clipped, which means an inner surface carrying a corner shape plus
`overflow-hidden` so the media (a photo, gradient, or placeholder icon) actually
clips to the rounded corner. `view` bakes that convention into one call, so
route code names "card media" instead of re-deriving the clip each time.

Compose it with the shape and surface primitives (`Kit.Surface`, `Kit.Shape`);
this is a card-media convenience over them, not a new seam.

@docs view

-}

import Html.Attributes
import Kit.Shape as Shape exposing (Corner)
import Kit.Surface as Surface exposing (Surface)
import HtmlIr.Element exposing (Element)
import HtmlIr.Attribute exposing (Attr)
import M3e.Kind
import Seam


{-| A shape-clipped media region: a `Surface` role, corner-clipped to the given
`Corner` with `overflow-hidden` so content clips to the corner. Extra `attrs`
(layout sizing, alignment, …) and `kids` (an `<img>`, an icon placeholder, …)
compose on as with `Kit.Surface.view`.
-}
view : Surface -> Corner -> List (Attr c msg) -> List (Element s adm_ msg) -> Element { k | html : M3e.Kind.Brand } adm_ msg
view role corner attrs kids =
    Surface.view role
        (Shape.corner corner
            :: Seam.asAttribute (Html.Attributes.class "overflow-hidden")
            :: attrs
        )
        kids
