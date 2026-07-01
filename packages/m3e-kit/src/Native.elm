module Native exposing (node, div, span, p, a, strong, em, small, ul, ol, li, img, br, hr)

{-| Native-HTML IR producers (prose/inline/block). Each carries the `html` kind, so
it drops into any `any` slot directly, and into a specific slot via `EscapeHatch`.
This is the "teams get normal HTML inside our composition" seam (docs §8).
-}

import Html
import M3e.Cem.Attr as Attr exposing (Attr)
import M3e.Element as Element exposing (Element)
import M3e.Node as Node
import M3e.Value exposing (Supported)


node :
    (List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg)
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
