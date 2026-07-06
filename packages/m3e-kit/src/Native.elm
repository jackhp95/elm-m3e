module Native exposing (a, attribute, br, div, em, footer, header, hr, img, li, nav, node, ol, onClick, p, section, small, span, strong, style, ul)

{-| Native-HTML IR producers (prose/inline/block). Each carries the `html` kind, so
it drops into any `any` slot directly, and into a specific slot via `Seam.stripPhantom`.
This is the "teams get normal HTML inside our composition" seam (docs §8).

Also hosts the typed native attribute/event escapes (`attribute`, `style`,
`onClick`) — raw HTML attributes/events lifted through `Seam` once, here, so feature
code composes them by name instead of reaching for `Seam` at the call site.
-}

import Html exposing (Html)
import Html.Attributes
import Html.Events
import M3e.Cem.Attr.Internal as Attr exposing (Attr)
import M3e.Element.Internal as Element exposing (Element)
import M3e.Node as Node
import M3e.Value exposing (Supported)
import Seam


node :
    (List (Html.Attribute msg) -> List (Html msg) -> Html msg)
    -> List (Attr c msg)
    -> List (Element s msg)
    -> Element { k | html : Supported } msg
node tag attrs kids =
    Node.fromComponent
        (\ha hc -> tag (List.map Attr.toAttribute ha) hc)
        (List.map Attr.forget attrs)
        (List.map Element.toNode kids)
        |> Element.fromNode


div : List (Attr c msg) -> List (Element s msg) -> Element { k | html : Supported } msg
div =
    node Html.div


section : List (Attr c msg) -> List (Element s msg) -> Element { k | html : Supported } msg
section =
    node Html.section


nav : List (Attr c msg) -> List (Element s msg) -> Element { k | html : Supported } msg
nav =
    node Html.nav


header : List (Attr c msg) -> List (Element s msg) -> Element { k | html : Supported } msg
header =
    node Html.header


footer : List (Attr c msg) -> List (Element s msg) -> Element { k | html : Supported } msg
footer =
    node Html.footer


span : List (Attr c msg) -> List (Element s msg) -> Element { k | html : Supported } msg
span =
    node Html.span


p : List (Attr c msg) -> List (Element s msg) -> Element { k | html : Supported } msg
p =
    node Html.p


a : List (Attr c msg) -> List (Element s msg) -> Element { k | html : Supported } msg
a =
    node Html.a


strong : List (Attr c msg) -> List (Element s msg) -> Element { k | html : Supported } msg
strong =
    node Html.strong


em : List (Attr c msg) -> List (Element s msg) -> Element { k | html : Supported } msg
em =
    node Html.em


small : List (Attr c msg) -> List (Element s msg) -> Element { k | html : Supported } msg
small =
    node Html.small


ul : List (Attr c msg) -> List (Element s msg) -> Element { k | html : Supported } msg
ul =
    node Html.ul


ol : List (Attr c msg) -> List (Element s msg) -> Element { k | html : Supported } msg
ol =
    node Html.ol


li : List (Attr c msg) -> List (Element s msg) -> Element { k | html : Supported } msg
li =
    node Html.li


img : List (Attr c msg) -> Element { k | html : Supported } msg
img attrs =
    node Html.img attrs []


br : Element { k | html : Supported } msg
br =
    node Html.br [] []


hr : Element { k | html : Supported } msg
hr =
    node Html.hr [] []



-- NATIVE ATTRIBUTE / EVENT ESCAPES --------------------------------------------


{-| A raw HTML attribute (`placeholder`, `type`, `src`, `role`, `id`, `dir`, …) as
a typed `Attr` carrying a fully-open capability row, so it composes onto any
native element or component. The one named crossing for plain string attributes —
feature code names the attribute instead of reaching for `Seam`.
-}
attribute : String -> String -> Attr c msg
attribute name value =
    Seam.asAttribute (Html.Attributes.attribute name value)


{-| A raw inline CSS declaration (e.g. a `--md-sys-*` custom property) as a typed
`Attr`. The style counterpart of `attribute`.
-}
style : String -> String -> Attr c msg
style key value =
    Seam.asAttribute (Html.Attributes.style key value)


{-| A native `click` handler as a typed `Attr`, for wiring a message onto a native
element (or a component that has no typed action of its own).
-}
onClick : msg -> Attr c msg
onClick msg =
    Seam.asAttribute (Html.Events.onClick msg)
