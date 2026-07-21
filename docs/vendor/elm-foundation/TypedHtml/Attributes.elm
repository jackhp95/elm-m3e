module TypedHtml.Attributes exposing
    ( class, id, slot, style
    , abbr, accept, acceptCharset, action, allow, allowfullscreen, alpha, alt, async, autocomplete, autoplay, checked, cite, color, cols, colspan, commandfor, content, controls, coords, data, datetime, default, defer, dirname, disabled, download, for, form, formaction, formnovalidate, formtarget, headers, height, high, href, hreflang, imagesizes, imagesrcset, integrity, ismap, label, list, loop, low, max, maxlength, media, min, minlength, multiple, muted, name, nomodule, novalidate, open, optimum, pattern, ping, placeholder, playsinline, popovertarget, poster, readonly, rel, required, reversed, rows, rowspan, selected, shadowrootclonable, shadowrootcustomelementregistry, shadowrootdelegatesfocus, shadowrootserializable, size, sizes, span, src, srcdoc, srclang, srcset, start, step, target, usemap, value, width
    , blocking, charset, closedby, colorspace, crossorigin, decoding, enctype, fetchpriority, formenctype, formmethod, httpEquiv, kind, loading, method, popovertargetaction, preload, referrerpolicy, sandbox, scope, shadowrootmode, shadowrootslotassignment, shape, wrap
    )

{-| The canonical shared attribute vocabulary. Every setter is an open
producer (`{ c | attr : Supported }`); each element's closed `Attrs` row
decides admittance. Enum setters here close over the library-wide UNION of
values — cross-component misuse is caught by elm-review; reach for the
per-component setters (`TypedHtml.<Component>.<attr>`) for compile-tight narrowing.

@docs class, id, slot, style
@docs abbr, accept, acceptCharset, action, allow, allowfullscreen, alpha, alt, async, autocomplete, autoplay, checked, cite, color, cols, colspan, commandfor, content, controls, coords, data, datetime, default, defer, dirname, disabled, download, for, form, formaction, formnovalidate, formtarget, headers, height, high, href, hreflang, imagesizes, imagesrcset, integrity, ismap, label, list, loop, low, max, maxlength, media, min, minlength, multiple, muted, name, nomodule, novalidate, open, optimum, pattern, ping, placeholder, playsinline, popovertarget, poster, readonly, rel, required, reversed, rows, rowspan, selected, shadowrootclonable, shadowrootcustomelementregistry, shadowrootdelegatesfocus, shadowrootserializable, size, sizes, span, src, srcdoc, srclang, srcset, start, step, target, usemap, value, width
@docs blocking, charset, closedby, colorspace, crossorigin, decoding, enctype, fetchpriority, formenctype, formmethod, httpEquiv, kind, loading, method, popovertargetaction, preload, referrerpolicy, sandbox, scope, shadowrootmode, shadowrootslotassignment, shape, wrap

-}

import Html.Attributes
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value exposing (Value)
import TypedHtml.Values


{-| The global `class` attribute.
-}
class : String -> Attr { c | class : Supported } msg
class =
    Ir.attribute "class"


{-| The global `id` attribute.
-}
id : String -> Attr { c | id : Supported } msg
id =
    Ir.attribute "id"


{-| The global `slot` attribute (named-slot placement by hand).
-}
slot : String -> Attr { c | slot : Supported } msg
slot =
    Ir.attribute "slot"


{-| The global `style` attribute (the full inline-style string).
-}
style : String -> Attr { c | style : Supported } msg
style =
    Ir.attribute "style"


{-| The shared `abbr` attribute.
-}
abbr : String -> Attr { c | abbr : Supported } msg
abbr =
    Ir.attribute "abbr"


{-| The shared `accept` attribute.
-}
accept : String -> Attr { c | accept : Supported } msg
accept =
    Ir.attribute "accept"


{-| The shared `acceptCharset` attribute.
-}
acceptCharset : String -> Attr { c | acceptCharset : Supported } msg
acceptCharset =
    Ir.attribute "accept-charset"


{-| The shared `action` attribute.
-}
action : String -> Attr { c | action : Supported } msg
action =
    Ir.attribute "action"


{-| The shared `allow` attribute.
-}
allow : String -> Attr { c | allow : Supported } msg
allow =
    Ir.attribute "allow"


{-| The shared `allowfullscreen` attribute.
-}
allowfullscreen : Bool -> Attr { c | allowfullscreen : Supported } msg
allowfullscreen value_ =
    if value_ then
        Ir.attribute "allowfullscreen" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `alpha` attribute.
-}
alpha : Bool -> Attr { c | alpha : Supported } msg
alpha value_ =
    if value_ then
        Ir.attribute "alpha" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `alt` attribute.
-}
alt : String -> Attr { c | alt : Supported } msg
alt =
    Ir.attribute "alt"


{-| The shared `async` attribute.
-}
async : Bool -> Attr { c | async : Supported } msg
async value_ =
    if value_ then
        Ir.attribute "async" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `autocomplete` attribute.
-}
autocomplete : String -> Attr { c | autocomplete : Supported } msg
autocomplete =
    Ir.attribute "autocomplete"


{-| The shared `autoplay` attribute.
-}
autoplay : Bool -> Attr { c | autoplay : Supported } msg
autoplay value_ =
    if value_ then
        Ir.attribute "autoplay" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `checked` attribute.
-}
checked : Bool -> Attr { c | checked : Supported } msg
checked value_ =
    if value_ then
        Ir.attribute "checked" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `cite` attribute.
-}
cite : String -> Attr { c | cite : Supported } msg
cite =
    Ir.attribute "cite"


{-| The shared `color` attribute.
-}
color : String -> Attr { c | color : Supported } msg
color =
    Ir.attribute "color"


{-| The shared `cols` attribute.
-}
cols : Float -> Attr { c | cols : Supported } msg
cols value_ =
    Ir.attribute "cols" (String.fromFloat value_)


{-| The shared `colspan` attribute.
-}
colspan : Float -> Attr { c | colspan : Supported } msg
colspan value_ =
    Ir.attribute "colspan" (String.fromFloat value_)


{-| The shared `commandfor` attribute.
-}
commandfor : String -> Attr { c | commandfor : Supported } msg
commandfor =
    Ir.attribute "commandfor"


{-| The shared `content` attribute.
-}
content : String -> Attr { c | content : Supported } msg
content =
    Ir.attribute "content"


{-| The shared `controls` attribute.
-}
controls : Bool -> Attr { c | controls : Supported } msg
controls value_ =
    if value_ then
        Ir.attribute "controls" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `coords` attribute.
-}
coords : Float -> Attr { c | coords : Supported } msg
coords value_ =
    Ir.attribute "coords" (String.fromFloat value_)


{-| The shared `data` attribute.
-}
data : String -> Attr { c | data : Supported } msg
data =
    Ir.attribute "data"


{-| The shared `datetime` attribute.
-}
datetime : Float -> Attr { c | datetime : Supported } msg
datetime value_ =
    Ir.attribute "datetime" (String.fromFloat value_)


{-| The shared `default` attribute.
-}
default : Bool -> Attr { c | default : Supported } msg
default value_ =
    if value_ then
        Ir.attribute "default" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `defer` attribute.
-}
defer : Bool -> Attr { c | defer : Supported } msg
defer value_ =
    if value_ then
        Ir.attribute "defer" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `dirname` attribute.
-}
dirname : String -> Attr { c | dirname : Supported } msg
dirname =
    Ir.attribute "dirname"


{-| The shared `disabled` attribute.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled value_ =
    if value_ then
        Ir.attribute "disabled" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `download` attribute.
-}
download : String -> Attr { c | download : Supported } msg
download =
    Ir.attribute "download"


{-| The shared `for` attribute.
-}
for : String -> Attr { c | for : Supported } msg
for =
    Ir.attribute "for"


{-| The shared `form` attribute.
-}
form : String -> Attr { c | form : Supported } msg
form =
    Ir.attribute "form"


{-| The shared `formaction` attribute.
-}
formaction : String -> Attr { c | formaction : Supported } msg
formaction =
    Ir.attribute "formaction"


{-| The shared `formnovalidate` attribute.
-}
formnovalidate : Bool -> Attr { c | formnovalidate : Supported } msg
formnovalidate value_ =
    if value_ then
        Ir.attribute "formnovalidate" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `formtarget` attribute.
-}
formtarget : String -> Attr { c | formtarget : Supported } msg
formtarget =
    Ir.attribute "formtarget"


{-| The shared `headers` attribute.
-}
headers : String -> Attr { c | headers : Supported } msg
headers =
    Ir.attribute "headers"


{-| The shared `height` attribute.
-}
height : Float -> Attr { c | height : Supported } msg
height value_ =
    Ir.attribute "height" (String.fromFloat value_)


{-| The shared `high` attribute.
-}
high : Float -> Attr { c | high : Supported } msg
high value_ =
    Ir.attribute "high" (String.fromFloat value_)


{-| The shared `href` attribute.
-}
href : String -> Attr { c | href : Supported } msg
href =
    Ir.attribute "href"


{-| The shared `hreflang` attribute.
-}
hreflang : String -> Attr { c | hreflang : Supported } msg
hreflang =
    Ir.attribute "hreflang"


{-| The shared `imagesizes` attribute.
-}
imagesizes : String -> Attr { c | imagesizes : Supported } msg
imagesizes =
    Ir.attribute "imagesizes"


{-| The shared `imagesrcset` attribute.
-}
imagesrcset : String -> Attr { c | imagesrcset : Supported } msg
imagesrcset =
    Ir.attribute "imagesrcset"


{-| The shared `integrity` attribute.
-}
integrity : String -> Attr { c | integrity : Supported } msg
integrity =
    Ir.attribute "integrity"


{-| The shared `ismap` attribute.
-}
ismap : Bool -> Attr { c | ismap : Supported } msg
ismap value_ =
    if value_ then
        Ir.attribute "ismap" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `label` attribute.
-}
label : String -> Attr { c | label : Supported } msg
label =
    Ir.attribute "label"


{-| The shared `list` attribute.
-}
list : String -> Attr { c | list : Supported } msg
list =
    Ir.attribute "list"


{-| The shared `loop` attribute.
-}
loop : Bool -> Attr { c | loop : Supported } msg
loop value_ =
    if value_ then
        Ir.attribute "loop" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `low` attribute.
-}
low : Float -> Attr { c | low : Supported } msg
low value_ =
    Ir.attribute "low" (String.fromFloat value_)


{-| The shared `max` attribute.
-}
max : String -> Attr { c | max : Supported } msg
max =
    Ir.attribute "max"


{-| The shared `maxlength` attribute.
-}
maxlength : Float -> Attr { c | maxlength : Supported } msg
maxlength value_ =
    Ir.attribute "maxlength" (String.fromFloat value_)


{-| The shared `media` attribute.
-}
media : String -> Attr { c | media : Supported } msg
media =
    Ir.attribute "media"


{-| The shared `min` attribute.
-}
min : String -> Attr { c | min : Supported } msg
min =
    Ir.attribute "min"


{-| The shared `minlength` attribute.
-}
minlength : Float -> Attr { c | minlength : Supported } msg
minlength value_ =
    Ir.attribute "minlength" (String.fromFloat value_)


{-| The shared `multiple` attribute.
-}
multiple : Bool -> Attr { c | multiple : Supported } msg
multiple value_ =
    if value_ then
        Ir.attribute "multiple" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `muted` attribute.
-}
muted : Bool -> Attr { c | muted : Supported } msg
muted value_ =
    if value_ then
        Ir.attribute "muted" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `name` attribute.
-}
name : String -> Attr { c | name : Supported } msg
name =
    Ir.attribute "name"


{-| The shared `nomodule` attribute.
-}
nomodule : Bool -> Attr { c | nomodule : Supported } msg
nomodule value_ =
    if value_ then
        Ir.attribute "nomodule" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `novalidate` attribute.
-}
novalidate : Bool -> Attr { c | novalidate : Supported } msg
novalidate value_ =
    if value_ then
        Ir.attribute "novalidate" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `open` attribute.
-}
open : Bool -> Attr { c | open : Supported } msg
open value_ =
    if value_ then
        Ir.attribute "open" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `optimum` attribute.
-}
optimum : Float -> Attr { c | optimum : Supported } msg
optimum value_ =
    Ir.attribute "optimum" (String.fromFloat value_)


{-| The shared `pattern` attribute.
-}
pattern : String -> Attr { c | pattern : Supported } msg
pattern =
    Ir.attribute "pattern"


{-| The shared `ping` attribute.
-}
ping : String -> Attr { c | ping : Supported } msg
ping =
    Ir.attribute "ping"


{-| The shared `placeholder` attribute.
-}
placeholder : String -> Attr { c | placeholder : Supported } msg
placeholder =
    Ir.attribute "placeholder"


{-| The shared `playsinline` attribute.
-}
playsinline : Bool -> Attr { c | playsinline : Supported } msg
playsinline value_ =
    if value_ then
        Ir.attribute "playsinline" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `popovertarget` attribute.
-}
popovertarget : String -> Attr { c | popovertarget : Supported } msg
popovertarget =
    Ir.attribute "popovertarget"


{-| The shared `poster` attribute.
-}
poster : String -> Attr { c | poster : Supported } msg
poster =
    Ir.attribute "poster"


{-| The shared `readonly` attribute.
-}
readonly : Bool -> Attr { c | readonly : Supported } msg
readonly value_ =
    if value_ then
        Ir.attribute "readonly" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `rel` attribute.
-}
rel : String -> Attr { c | rel : Supported } msg
rel =
    Ir.attribute "rel"


{-| The shared `required` attribute.
-}
required : Bool -> Attr { c | required : Supported } msg
required value_ =
    if value_ then
        Ir.attribute "required" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `reversed` attribute.
-}
reversed : Bool -> Attr { c | reversed : Supported } msg
reversed value_ =
    if value_ then
        Ir.attribute "reversed" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `rows` attribute.
-}
rows : Float -> Attr { c | rows : Supported } msg
rows value_ =
    Ir.attribute "rows" (String.fromFloat value_)


{-| The shared `rowspan` attribute.
-}
rowspan : Float -> Attr { c | rowspan : Supported } msg
rowspan value_ =
    Ir.attribute "rowspan" (String.fromFloat value_)


{-| The shared `selected` attribute.
-}
selected : Bool -> Attr { c | selected : Supported } msg
selected value_ =
    if value_ then
        Ir.attribute "selected" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `shadowrootclonable` attribute.
-}
shadowrootclonable : Bool -> Attr { c | shadowrootclonable : Supported } msg
shadowrootclonable value_ =
    if value_ then
        Ir.attribute "shadowrootclonable" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `shadowrootcustomelementregistry` attribute.
-}
shadowrootcustomelementregistry : Bool -> Attr { c | shadowrootcustomelementregistry : Supported } msg
shadowrootcustomelementregistry value_ =
    if value_ then
        Ir.attribute "shadowrootcustomelementregistry" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `shadowrootdelegatesfocus` attribute.
-}
shadowrootdelegatesfocus : Bool -> Attr { c | shadowrootdelegatesfocus : Supported } msg
shadowrootdelegatesfocus value_ =
    if value_ then
        Ir.attribute "shadowrootdelegatesfocus" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `shadowrootserializable` attribute.
-}
shadowrootserializable : Bool -> Attr { c | shadowrootserializable : Supported } msg
shadowrootserializable value_ =
    if value_ then
        Ir.attribute "shadowrootserializable" ""

    else
        Ir.fromHtmlAttribute (Html.Attributes.classList [])


{-| The shared `size` attribute.
-}
size : Float -> Attr { c | size : Supported } msg
size value_ =
    Ir.attribute "size" (String.fromFloat value_)


{-| The shared `sizes` attribute.
-}
sizes : String -> Attr { c | sizes : Supported } msg
sizes =
    Ir.attribute "sizes"


{-| The shared `span` attribute.
-}
span : Float -> Attr { c | span : Supported } msg
span value_ =
    Ir.attribute "span" (String.fromFloat value_)


{-| The shared `src` attribute.
-}
src : String -> Attr { c | src : Supported } msg
src =
    Ir.attribute "src"


{-| The shared `srcdoc` attribute.
-}
srcdoc : String -> Attr { c | srcdoc : Supported } msg
srcdoc =
    Ir.attribute "srcdoc"


{-| The shared `srclang` attribute.
-}
srclang : String -> Attr { c | srclang : Supported } msg
srclang =
    Ir.attribute "srclang"


{-| The shared `srcset` attribute.
-}
srcset : String -> Attr { c | srcset : Supported } msg
srcset =
    Ir.attribute "srcset"


{-| The shared `start` attribute.
-}
start : Float -> Attr { c | start : Supported } msg
start value_ =
    Ir.attribute "start" (String.fromFloat value_)


{-| The shared `step` attribute.
-}
step : Float -> Attr { c | step : Supported } msg
step value_ =
    Ir.attribute "step" (String.fromFloat value_)


{-| The shared `target` attribute.
-}
target : String -> Attr { c | target : Supported } msg
target =
    Ir.attribute "target"


{-| The shared `usemap` attribute.
-}
usemap : String -> Attr { c | usemap : Supported } msg
usemap =
    Ir.attribute "usemap"


{-| The shared `value` attribute.
-}
value : String -> Attr { c | value : Supported } msg
value =
    Ir.attribute "value"


{-| The shared `width` attribute.
-}
width : Float -> Attr { c | width : Supported } msg
width value_ =
    Ir.attribute "width" (String.fromFloat value_)


{-| The `blocking` union setter.
-}
blocking : Value TypedHtml.Values.Blocking -> Attr { c | blocking : Supported } msg
blocking value_ =
    Ir.attribute "blocking" (HtmlIr.Value.toString value_)


{-| The `charset` union setter.
-}
charset : Value TypedHtml.Values.Charset -> Attr { c | charset : Supported } msg
charset value_ =
    Ir.attribute "charset" (HtmlIr.Value.toString value_)


{-| The `closedby` union setter.
-}
closedby : Value TypedHtml.Values.Closedby -> Attr { c | closedby : Supported } msg
closedby value_ =
    Ir.attribute "closedby" (HtmlIr.Value.toString value_)


{-| The `colorspace` union setter.
-}
colorspace : Value TypedHtml.Values.Colorspace -> Attr { c | colorspace : Supported } msg
colorspace value_ =
    Ir.attribute "colorspace" (HtmlIr.Value.toString value_)


{-| The `crossorigin` union setter.
-}
crossorigin : Value TypedHtml.Values.Crossorigin -> Attr { c | crossorigin : Supported } msg
crossorigin value_ =
    Ir.attribute "crossorigin" (HtmlIr.Value.toString value_)


{-| The `decoding` union setter.
-}
decoding : Value TypedHtml.Values.Decoding -> Attr { c | decoding : Supported } msg
decoding value_ =
    Ir.attribute "decoding" (HtmlIr.Value.toString value_)


{-| The `enctype` union setter.
-}
enctype : Value TypedHtml.Values.Enctype -> Attr { c | enctype : Supported } msg
enctype value_ =
    Ir.attribute "enctype" (HtmlIr.Value.toString value_)


{-| The `fetchpriority` union setter.
-}
fetchpriority : Value TypedHtml.Values.Fetchpriority -> Attr { c | fetchpriority : Supported } msg
fetchpriority value_ =
    Ir.attribute "fetchpriority" (HtmlIr.Value.toString value_)


{-| The `formenctype` union setter.
-}
formenctype : Value TypedHtml.Values.Formenctype -> Attr { c | formenctype : Supported } msg
formenctype value_ =
    Ir.attribute "formenctype" (HtmlIr.Value.toString value_)


{-| The `formmethod` union setter.
-}
formmethod : Value TypedHtml.Values.Formmethod -> Attr { c | formmethod : Supported } msg
formmethod value_ =
    Ir.attribute "formmethod" (HtmlIr.Value.toString value_)


{-| The `httpEquiv` union setter.
-}
httpEquiv : Value TypedHtml.Values.HttpEquiv -> Attr { c | httpEquiv : Supported } msg
httpEquiv value_ =
    Ir.attribute "http-equiv" (HtmlIr.Value.toString value_)


{-| The `kind` union setter.
-}
kind : Value TypedHtml.Values.Kind -> Attr { c | kind : Supported } msg
kind value_ =
    Ir.attribute "kind" (HtmlIr.Value.toString value_)


{-| The `loading` union setter.
-}
loading : Value TypedHtml.Values.Loading -> Attr { c | loading : Supported } msg
loading value_ =
    Ir.attribute "loading" (HtmlIr.Value.toString value_)


{-| The `method` union setter.
-}
method : Value TypedHtml.Values.Method -> Attr { c | method : Supported } msg
method value_ =
    Ir.attribute "method" (HtmlIr.Value.toString value_)


{-| The `popovertargetaction` union setter.
-}
popovertargetaction : Value TypedHtml.Values.Popovertargetaction -> Attr { c | popovertargetaction : Supported } msg
popovertargetaction value_ =
    Ir.attribute "popovertargetaction" (HtmlIr.Value.toString value_)


{-| The `preload` union setter.
-}
preload : Value TypedHtml.Values.Preload -> Attr { c | preload : Supported } msg
preload value_ =
    Ir.attribute "preload" (HtmlIr.Value.toString value_)


{-| The `referrerpolicy` union setter.
-}
referrerpolicy : Value TypedHtml.Values.Referrerpolicy -> Attr { c | referrerpolicy : Supported } msg
referrerpolicy value_ =
    Ir.attribute "referrerpolicy" (HtmlIr.Value.toString value_)


{-| The `sandbox` union setter.
-}
sandbox : Value TypedHtml.Values.Sandbox -> Attr { c | sandbox : Supported } msg
sandbox value_ =
    Ir.attribute "sandbox" (HtmlIr.Value.toString value_)


{-| The `scope` union setter.
-}
scope : Value TypedHtml.Values.Scope -> Attr { c | scope : Supported } msg
scope value_ =
    Ir.attribute "scope" (HtmlIr.Value.toString value_)


{-| The `shadowrootmode` union setter.
-}
shadowrootmode : Value TypedHtml.Values.Shadowrootmode -> Attr { c | shadowrootmode : Supported } msg
shadowrootmode value_ =
    Ir.attribute "shadowrootmode" (HtmlIr.Value.toString value_)


{-| The `shadowrootslotassignment` union setter.
-}
shadowrootslotassignment : Value TypedHtml.Values.Shadowrootslotassignment -> Attr { c | shadowrootslotassignment : Supported } msg
shadowrootslotassignment value_ =
    Ir.attribute "shadowrootslotassignment" (HtmlIr.Value.toString value_)


{-| The `shape` union setter.
-}
shape : Value TypedHtml.Values.Shape -> Attr { c | shape : Supported } msg
shape value_ =
    Ir.attribute "shape" (HtmlIr.Value.toString value_)


{-| The `wrap` union setter.
-}
wrap : Value TypedHtml.Values.Wrap -> Attr { c | wrap : Supported } msg
wrap value_ =
    Ir.attribute "wrap" (HtmlIr.Value.toString value_)
