module M3e.Native exposing (a, label, input, textarea, select, button, span, div, p, ul, li, nav, header, footer, section, img, alt, checked, cols, disabled, download, for, height, href, max, min, multiple, name, placeholder, readonly, rel, required, rows, src, step, target, type_, value, width)

{-| GENERATED — the typed native/HTML IR (ADR 0014 §3): a public typed
facade of native HTML element constructors plus HTML-natural,
element-constrained attribute setters. The facade cannot lie — a semantic
tag stamps its kind, and each constructor's accepted attribute record is
CLOSED to the attrs HTML permits on that element (plus `slot`), so
`M3e.Native.div [ M3e.Native.href "x" ] []` is a compile error. The library-boundary
crossings live inside this generated `M3e.*` module. Do not edit by hand;
regenerate via `bin/elm-cem.js`.

@docs a, label, input, textarea, select, button, span, div, p, ul, li, nav, header, footer, section, img
@docs alt, checked, cols, disabled, download, for, height, href, max, min, multiple, name, placeholder, readonly, rel, required, rows, src, step, target, type_, value, width
-}

import Html
import Html.Attributes
import M3e.Cem.Attr.Internal as Attr exposing (Attr)
import M3e.Element.Internal as Element exposing (Element)
import M3e.Node as Node
import M3e.Value exposing (Supported)


a :
    List (Attr { download : Supported, href : Supported, rel : Supported, slot : Supported, target : Supported } msg) -> List (Element s msg) -> Element { k | link : Supported } msg
a attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.a (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


label :
    List (Attr { for : Supported, slot : Supported } msg) -> List (Element s msg) -> Element { k | label : Supported } msg
label attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.label (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


input :
    List (Attr { checked : Supported, disabled : Supported, max : Supported, min : Supported, multiple : Supported, name : Supported, placeholder : Supported, readonly : Supported, required : Supported, slot : Supported, step : Supported, type_ : Supported, value : Supported } msg) -> Element any msg
input attrs =
    Element.fromNode
        (Node.fromComponent
            (\erased _ -> Html.input (List.map Attr.toAttribute erased) [])
            (List.map Attr.forget attrs)
            []
        )


textarea :
    List (Attr { cols : Supported, disabled : Supported, name : Supported, placeholder : Supported, readonly : Supported, required : Supported, rows : Supported, slot : Supported, value : Supported } msg) -> List (Element s msg) -> Element any msg
textarea attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.textarea (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


select :
    List (Attr { disabled : Supported, multiple : Supported, name : Supported, required : Supported, slot : Supported } msg) -> List (Element s msg) -> Element any msg
select attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.select (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


button :
    List (Attr { disabled : Supported, name : Supported, slot : Supported, type_ : Supported, value : Supported } msg) -> List (Element s msg) -> Element any msg
button attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.button (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


span :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
span attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.span (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


div :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
div attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.div (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


p :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
p attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.p (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


ul :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
ul attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.ul (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


li :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
li attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.li (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


nav :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
nav attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.nav (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


header :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
header attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.header (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


footer :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
footer attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.footer (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


section :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
section attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.section (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


img :
    List (Attr { alt : Supported, height : Supported, slot : Supported, src : Supported, width : Supported } msg) -> Element any msg
img attrs =
    Element.fromNode
        (Node.fromComponent
            (\erased _ -> Html.img (List.map Attr.toAttribute erased) [])
            (List.map Attr.forget attrs)
            []
        )


alt : String -> Attr { c | alt : Supported } msg
alt =
    Attr.attribute Html.Attributes.alt


checked : Bool -> Attr { c | checked : Supported } msg
checked =
    Attr.attribute Html.Attributes.checked


cols : Int -> Attr { c | cols : Supported } msg
cols =
    Attr.attribute Html.Attributes.cols


disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Attr.attribute Html.Attributes.disabled


download : String -> Attr { c | download : Supported } msg
download =
    Attr.attribute Html.Attributes.download


for : String -> Attr { c | for : Supported } msg
for =
    Attr.attribute Html.Attributes.for


height : Int -> Attr { c | height : Supported } msg
height =
    Attr.attribute Html.Attributes.height


href : String -> Attr { c | href : Supported } msg
href =
    Attr.attribute Html.Attributes.href


max : String -> Attr { c | max : Supported } msg
max =
    Attr.attribute Html.Attributes.max


min : String -> Attr { c | min : Supported } msg
min =
    Attr.attribute Html.Attributes.min


multiple : Bool -> Attr { c | multiple : Supported } msg
multiple =
    Attr.attribute Html.Attributes.multiple


name : String -> Attr { c | name : Supported } msg
name =
    Attr.attribute Html.Attributes.name


placeholder : String -> Attr { c | placeholder : Supported } msg
placeholder =
    Attr.attribute Html.Attributes.placeholder


readonly : Bool -> Attr { c | readonly : Supported } msg
readonly =
    Attr.attribute Html.Attributes.readonly


rel : String -> Attr { c | rel : Supported } msg
rel =
    Attr.attribute Html.Attributes.rel


required : Bool -> Attr { c | required : Supported } msg
required =
    Attr.attribute Html.Attributes.required


rows : Int -> Attr { c | rows : Supported } msg
rows =
    Attr.attribute Html.Attributes.rows


src : String -> Attr { c | src : Supported } msg
src =
    Attr.attribute Html.Attributes.src


step : String -> Attr { c | step : Supported } msg
step =
    Attr.attribute Html.Attributes.step


target : String -> Attr { c | target : Supported } msg
target =
    Attr.attribute Html.Attributes.target


type_ : String -> Attr { c | type_ : Supported } msg
type_ =
    Attr.attribute Html.Attributes.type_


value : String -> Attr { c | value : Supported } msg
value =
    Attr.attribute Html.Attributes.value


width : Int -> Attr { c | width : Supported } msg
width =
    Attr.attribute Html.Attributes.width
