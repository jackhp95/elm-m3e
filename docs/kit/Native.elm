module Native exposing
    ( a, div, footer, header, img, input, label, li, nav, p, section, span, ul
    , button, select, textarea
    , br, em, hr, node, ol, small, strong
    , attribute, onClick, style
    )

{-| Native-HTML IR producers for userland composition.

**Covered tags come from the generated typed facade `M3e.Native`** (see `docs/DESIGN.md` §4):
the constructors and their HTML-natural, element-constrained attribute setters are
now generated over the `*.Internal` crossings, so `Native.div [ M3e.Native.href … ]`
is a compile error and semantic tags carry a real kind (`a` → `link`,
`label` → `label`). This module re-exports them under the familiar unqualified
names so existing feature/docs code keeps composing by name.

The remaining hand-written helpers are the tags the generator does not emit
(`br`, `em`, `hr`, `node`, `ol`, `small`, `strong`) plus the untyped escapes
(`attribute`, `style`, `onClick`) — the deliberately-open crossings a team uses
to name an arbitrary raw attribute/event without reaching for `Seam` at the call
site.

@docs a, div, footer, header, img, input, label, li, nav, p, section, span, ul
@docs button, select, textarea
@docs br, em, hr, node, ol, small, strong
@docs attribute, onClick, style

-}

import Html exposing (Html)
import Html.Attributes
import Html.Events
import M3e.Kind
import M3e.Native
import M3e.Token exposing (Supported)
import Markup.Element.Internal as Element exposing (Element)
import Markup.Html.Attr.Internal as Attr exposing (Attr)
import Markup.Kind
import Markup.Node as Node
import Seam



-- COVERED TAGS — re-exported from the generated typed facade `M3e.Native` -------


{-| An `<a>` anchor (link kind). See [`M3e.Native.a`](M3e-Native#a).
-}
a :
    List (Attr { download : Supported, href : Supported, rel : Supported, slot : Supported, target : Supported } msg)
    -> List (Element s msg)
    -> Element { k | link : Markup.Kind.Shared } msg
a =
    M3e.Native.a


{-| A `<div>`. See [`M3e.Native.div`](M3e-Native#div).
-}
div : List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
div =
    M3e.Native.div


{-| A `<span>`. See [`M3e.Native.span`](M3e-Native#span).
-}
span : List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
span =
    M3e.Native.span


{-| A `<section>`. See [`M3e.Native.section`](M3e-Native#section).
-}
section : List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
section =
    M3e.Native.section


{-| A `<nav>`. See [`M3e.Native.nav`](M3e-Native#nav).
-}
nav : List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
nav =
    M3e.Native.nav


{-| A `<header>`. See [`M3e.Native.header`](M3e-Native#header).
-}
header : List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
header =
    M3e.Native.header


{-| A `<footer>`. See [`M3e.Native.footer`](M3e-Native#footer).
-}
footer : List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
footer =
    M3e.Native.footer


{-| A `<p>`. See [`M3e.Native.p`](M3e-Native#p).
-}
p : List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
p =
    M3e.Native.p


{-| A `<ul>`. See [`M3e.Native.ul`](M3e-Native#ul).
-}
ul : List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
ul =
    M3e.Native.ul


{-| An `<li>`. See [`M3e.Native.li`](M3e-Native#li).
-}
li : List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
li =
    M3e.Native.li


{-| An `<img>` (void). See [`M3e.Native.img`](M3e-Native#img).
-}
img :
    List (Attr { alt : Supported, height : Supported, slot : Supported, src : Supported, width : Supported } msg)
    -> Element { k | html : M3e.Kind.Brand } msg
img =
    M3e.Native.img


{-| A `<label>` (label kind). See [`M3e.Native.label`](M3e-Native#label).
-}
label :
    List (Attr { for : Supported, slot : Supported } msg)
    -> List (Element s msg)
    -> Element { k | label : Markup.Kind.Shared } msg
label =
    M3e.Native.label


{-| An `<input>` (void). See [`M3e.Native.input`](M3e-Native#input).
-}
input :
    List (Attr { checked : Supported, disabled : Supported, max : Supported, min : Supported, multiple : Supported, name : Supported, placeholder : Supported, readonly : Supported, required : Supported, slot : Supported, step : Supported, type_ : Supported, value : Supported } msg)
    -> Element { k | html : M3e.Kind.Brand } msg
input =
    M3e.Native.input


{-| A `<button>`. See [`M3e.Native.button`](M3e-Native#button).
-}
button :
    List (Attr { disabled : Supported, name : Supported, slot : Supported, type_ : Supported, value : Supported } msg)
    -> List (Element s msg)
    -> Element { k | html : M3e.Kind.Brand } msg
button =
    M3e.Native.button


{-| A `<select>`. See [`M3e.Native.select`](M3e-Native#select).
-}
select :
    List (Attr { disabled : Supported, multiple : Supported, name : Supported, required : Supported, slot : Supported } msg)
    -> List (Element s msg)
    -> Element { k | html : M3e.Kind.Brand } msg
select =
    M3e.Native.select


{-| A `<textarea>`. See [`M3e.Native.textarea`](M3e-Native#textarea).
-}
textarea :
    List (Attr { cols : Supported, disabled : Supported, name : Supported, placeholder : Supported, readonly : Supported, required : Supported, rows : Supported, slot : Supported, value : Supported } msg)
    -> List (Element s msg)
    -> Element { k | html : M3e.Kind.Brand } msg
textarea =
    M3e.Native.textarea



-- UNCOVERED TAGS — the generic helper + tags the generator does not emit --------


{-| Build a native element from any `Html` constructor. The catch-all producer for
tags the generated `M3e.Native` does not emit; carries the `html` kind so it drops
into any `any` slot.
-}
node :
    (List (Html.Attribute msg) -> List (Html msg) -> Html msg)
    -> List (Attr c msg)
    -> List (Element s msg)
    -> Element { k | html : M3e.Kind.Brand } msg
node tag attrs kids =
    Node.fromComponent
        (\ha hc -> tag (List.map Attr.toAttribute ha) hc)
        (List.map Attr.forget attrs)
        (List.map Element.toNode kids)
        |> Element.fromNode


{-| A `<strong>` element.
-}
strong : List (Attr c msg) -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
strong =
    node Html.strong


{-| An `<em>` element.
-}
em : List (Attr c msg) -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
em =
    node Html.em


{-| A `<small>` element.
-}
small : List (Attr c msg) -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
small =
    node Html.small


{-| An `<ol>` element.
-}
ol : List (Attr c msg) -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
ol =
    node Html.ol


{-| A `<br>` element.
-}
br : Element { k | html : M3e.Kind.Brand } msg
br =
    node Html.br [] []


{-| An `<hr>` element.
-}
hr : Element { k | html : M3e.Kind.Brand } msg
hr =
    node Html.hr [] []



-- NATIVE ATTRIBUTE / EVENT ESCAPES --------------------------------------------


{-| A raw HTML attribute (`role`, `id`, `dir`, `data-*`, …) as a typed `Attr`
carrying a fully-open capability row, so it composes onto any native element or
component. The one named crossing for plain string attributes — feature code
names the attribute instead of reaching for `Seam`. For HTML-natural, element-
constrained attributes (`href`, `for`, `type_`, `src`, …) prefer the typed
setters on [`M3e.Native`](M3e-Native).
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
