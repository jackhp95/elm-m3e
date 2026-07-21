module Native exposing
    ( a, div, footer, header, img, input, label, li, nav, p, section, span, ul
    , button, select, textarea
    , br, em, hr, node, ol, small, strong
    , attribute, onClick, style
    )

{-| Native-HTML IR producers for userland composition.

**Migrated to the phantom substrate.** All constructors now go through
`HtmlIr.Internal.node` (the untyped forger) via the local `node` helper, which
stamps the M3e brand's `html` kind. Native elements carry `{ k | html : M3e.Kind.Brand }`.

@docs a, div, footer, header, img, input, label, li, nav, p, section, span, ul
@docs button, select, textarea
@docs br, em, hr, node, ol, small, strong
@docs attribute, onClick, style

-}

import Html exposing (Html)
import Html.Attributes
import Html.Events
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import M3e.Kind


-- GENERIC BUILDER (the Seam crossing) ----------------------------------------


{-| Build a native element from any tag name. Carries the `html` kind so it
drops into any slot that admits it.
-}
node :
    String
    -> List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
node tagName attrs kids =
    Ir.fromNode
        (Ir.node tagName attrs (List.map HtmlIr.Element.toNode kids))


-- COVERED TAGS ----------------------------------------------------------------


{-| An `<a>` anchor — open capability row, html kind.
-}
a :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
a =
    node "a"


{-| A `<div>`.
-}
div :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
div =
    node "div"


{-| A `<span>`.
-}
span :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
span =
    node "span"


{-| A `<section>`.
-}
section :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
section =
    node "section"


{-| A `<nav>`.
-}
nav :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
nav =
    node "nav"


{-| A `<header>`.
-}
header :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
header =
    node "header"


{-| A `<footer>`.
-}
footer :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
footer =
    node "footer"


{-| A `<p>`.
-}
p :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
p =
    node "p"


{-| A `<ul>`.
-}
ul :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
ul =
    node "ul"


{-| An `<li>`.
-}
li :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
li =
    node "li"


{-| An `<img>` (void).
-}
img :
    List (Attr c msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
img attrs =
    node "img" attrs []


{-| A `<label>`.
-}
label :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
label =
    node "label"


{-| An `<input>` (void).
-}
input :
    List (Attr c msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
input attrs =
    node "input" attrs []


{-| A `<button>`.
-}
button :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
button =
    node "button"


{-| A `<select>`.
-}
select :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
select =
    node "select"


{-| A `<textarea>`.
-}
textarea :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
textarea =
    node "textarea"


-- UNCOVERED TAGS --------------------------------------------------------------


{-| A `<strong>` element.
-}
strong :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
strong =
    node "strong"


{-| An `<em>` element.
-}
em :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
em =
    node "em"


{-| A `<small>` element.
-}
small :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
small =
    node "small"


{-| An `<ol>` element.
-}
ol :
    List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
ol =
    node "ol"


{-| A `<br>` element.
-}
br : Element { k | html : M3e.Kind.Brand } freeAdm msg
br =
    node "br" [] []


{-| An `<hr>` element.
-}
hr : Element { k | html : M3e.Kind.Brand } freeAdm msg
hr =
    node "hr" [] []


-- NATIVE ATTRIBUTE / EVENT ESCAPES --------------------------------------------


{-| A raw HTML attribute as a typed `Attr` carrying a fully-open capability row.
-}
attribute : String -> String -> Attr c msg
attribute name value =
    Ir.fromHtmlAttribute (Html.Attributes.attribute name value)


{-| A raw inline CSS declaration as a typed `Attr`.
-}
style : String -> String -> Attr c msg
style key value =
    Ir.fromHtmlAttribute (Html.Attributes.style key value)


{-| A native `click` handler as a typed `Attr`.
-}
onClick : msg -> Attr c msg
onClick msg =
    Ir.fromHtmlAttribute (Html.Events.onClick msg)
