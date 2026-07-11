module Kit.Badge exposing (on)

{-| **Badge on an anchor** — the notification/cart-count affordance.

`M3e.Badge` advertises a `position` axis and a `for` attribute, but the m3e
anchors (`M3e.IconButton`, …) take no badge slot, so overlaying a count on a
button is a userland layout concern. `on` encapsulates the `relative inline-flex`
wrapper + `pointer-events-none absolute right-0 top-0` overlay so route code
names the affordance instead of hand-rolling the positioning through the seam.

The anchor and badge keep independent slot kinds (an `iconButton` anchor next to
a `badge` overlay), so this is a plain layout wrapper rather than a slot.

Only the top-right overlay is implemented — the reported `M3e.IconButton` +
`M3e.Badge` case. Honoring `Badge`'s full `position` axis (above / after / …)
would be a natural extension: take a position value and map it to the matching
`absolute` edge classes.

@docs on

-}

import Html
import Html.Attributes
import M3e.Element.Internal as Element exposing (Element)
import M3e.Html.Attr as Attr
import M3e.Node as Node
import M3e.Token exposing (Supported)


{-| Overlay a `badge` in the top-right corner of an `anchor` element. The anchor
and badge may carry different slot kinds; the result is a positioned `<span>`
wrapper carrying the `html` kind.
-}
on : { anchor : Element sa msg, badge : Element sb msg } -> Element { k | html : Supported } msg
on { anchor, badge } =
    Node.fromComponent
        (\a c -> Html.span (Html.Attributes.class "relative inline-flex" :: List.map Attr.toAttribute a) c)
        []
        [ Element.toNode anchor
        , Node.fromComponent
            (\a c -> Html.span (Html.Attributes.class "pointer-events-none absolute right-0 top-0" :: List.map Attr.toAttribute a) c)
            []
            [ Element.toNode badge ]
        ]
        |> Element.fromNode
