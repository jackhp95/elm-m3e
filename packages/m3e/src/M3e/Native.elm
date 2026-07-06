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


{-| The `<a>` HTML element (or anchor element), with its `href` attribute, creates a hyperlink to web pages, files, email addresses, locations in the same page, or anything else a URL can address. Stamps the `link` slot kind.
-}
a :
    List (Attr { download : Supported, href : Supported, rel : Supported, slot : Supported, target : Supported } msg) -> List (Element s msg) -> Element { k | link : Supported } msg
a attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.a (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


{-| The `<label>` HTML element represents a caption for an item in a user interface. Stamps the `label` slot kind.
-}
label :
    List (Attr { for : Supported, slot : Supported } msg) -> List (Element s msg) -> Element { k | label : Supported } msg
label attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.label (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


{-| The `<input>` HTML element is used to create interactive controls for web-based forms in order to accept data from the user.
-}
input :
    List (Attr { checked : Supported, disabled : Supported, max : Supported, min : Supported, multiple : Supported, name : Supported, placeholder : Supported, readonly : Supported, required : Supported, slot : Supported, step : Supported, type_ : Supported, value : Supported } msg) -> Element any msg
input attrs =
    Element.fromNode
        (Node.fromComponent
            (\erased _ -> Html.input (List.map Attr.toAttribute erased) [])
            (List.map Attr.forget attrs)
            []
        )


{-| The `<textarea>` HTML element represents a multi-line plain-text editing control, useful when you want to allow users to enter a sizeable amount of free-form text.
-}
textarea :
    List (Attr { cols : Supported, disabled : Supported, name : Supported, placeholder : Supported, readonly : Supported, required : Supported, rows : Supported, slot : Supported, value : Supported } msg) -> List (Element s msg) -> Element any msg
textarea attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.textarea (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


{-| The `<select>` HTML element represents a control that provides a menu of options.
-}
select :
    List (Attr { disabled : Supported, multiple : Supported, name : Supported, required : Supported, slot : Supported } msg) -> List (Element s msg) -> Element any msg
select attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.select (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


{-| The `<button>` HTML element is an interactive element activated by a user with a mouse, keyboard, finger, voice command, or other assistive technology.
-}
button :
    List (Attr { disabled : Supported, name : Supported, slot : Supported, type_ : Supported, value : Supported } msg) -> List (Element s msg) -> Element any msg
button attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.button (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


{-| The `<span>` HTML element is a generic inline container for phrasing content, which does not inherently represent anything.
-}
span :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
span attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.span (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


{-| The `<div>` HTML element is the generic container for flow content. It has no effect on the content or layout until styled in some way using CSS.
-}
div :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
div attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.div (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


{-| The `<p>` HTML element represents a paragraph.
-}
p :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
p attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.p (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


{-| The `<ul>` HTML element represents an unordered list of items, typically rendered as a bulleted list.
-}
ul :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
ul attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.ul (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


{-| The `<li>` HTML element is used to represent an item in a list.
-}
li :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
li attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.li (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


{-| The `<nav>` HTML element represents a section of a page whose purpose is to provide navigation links, either within the current document or to other documents.
-}
nav :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
nav attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.nav (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


{-| The `<header>` HTML element represents introductory content, typically a group of introductory or navigational aids.
-}
header :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
header attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.header (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


{-| The `<footer>` HTML element represents a footer for its nearest ancestor sectioning content or sectioning root element.
-}
footer :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
footer attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.footer (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


{-| The `<section>` HTML element represents a generic standalone section of a document, which doesn't have a more specific semantic element to represent it.
-}
section :
    List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg
section attrs children =
    Element.fromNode
        (Node.fromComponent
            (\erased ch -> Html.section (List.map Attr.toAttribute erased) ch)
            (List.map Attr.forget attrs)
            (List.map Element.toNode children)
        )


{-| The `<img>` HTML element embeds an image into the document.
-}
img :
    List (Attr { alt : Supported, height : Supported, slot : Supported, src : Supported, width : Supported } msg) -> Element any msg
img attrs =
    Element.fromNode
        (Node.fromComponent
            (\erased _ -> Html.img (List.map Attr.toAttribute erased) [])
            (List.map Attr.forget attrs)
            []
        )


{-| Alternative text describing the image, shown when the image cannot be displayed and read out by assistive technology. Valid on `<img>`, `<area>`.
-}
alt : String -> Attr { c | alt : Supported } msg
alt =
    Attr.attribute Html.Attributes.alt


{-| Whether a checkbox or radio-button `<input>` is selected (checked) by default. Valid on `<input>`.
-}
checked : Bool -> Attr { c | checked : Supported } msg
checked =
    Attr.attribute Html.Attributes.checked


{-| The visible width of the `<textarea>` control, in average character widths. Valid on `<textarea>`.
-}
cols : Int -> Attr { c | cols : Supported } msg
cols =
    Attr.attribute Html.Attributes.cols


{-| Whether the control is disabled, meaning the user cannot interact with it and its value is not submitted with the form. Valid on `<input>`, `<textarea>`, `<select>`, `<button>`, `<option>`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Attr.attribute Html.Attributes.disabled


{-| Prompts the user to save the linked URL instead of navigating to it; if given a value, it is used as the suggested filename for the saved file. Valid on `<a>`, `<area>`.
-}
download : String -> Attr { c | download : Supported } msg
download =
    Attr.attribute Html.Attributes.download


{-| The `id` of a labelable form-related element in the same document as the `<label>` element it associates with. Valid on `<label>`, `<output>`.
-}
for : String -> Attr { c | for : Supported } msg
for =
    Attr.attribute Html.Attributes.for


{-| The intrinsic height of the image, in pixels. Valid on `<img>`.
-}
height : Int -> Attr { c | height : Supported } msg
height =
    Attr.attribute Html.Attributes.height


{-| The URL that the hyperlink points to. Links are not restricted to HTTP-based URLs — they can use any URL scheme supported by browsers. Valid on `<a>`, `<area>`.
-}
href : String -> Attr { c | href : Supported } msg
href =
    Attr.attribute Html.Attributes.href


{-| The greatest (maximum) value acceptable for a numeric, date, or time `<input>`. Valid on `<input>`.
-}
max : String -> Attr { c | max : Supported } msg
max =
    Attr.attribute Html.Attributes.max


{-| The most negative (minimum) value acceptable for a numeric, date, or time `<input>`. Valid on `<input>`.
-}
min : String -> Attr { c | min : Supported } msg
min =
    Attr.attribute Html.Attributes.min


{-| Whether the control allows more than one value: multiple selected options on a `<select>`, or multiple comma-separated values on an email or file `<input>`. Valid on `<select>`, `<input>`.
-}
multiple : Bool -> Attr { c | multiple : Supported } msg
multiple =
    Attr.attribute Html.Attributes.multiple


{-| The name of the form control, submitted with the form as part of a name/value pair. Valid on `<input>`, `<textarea>`, `<select>`, `<button>`.
-}
name : String -> Attr { c | name : Supported } msg
name =
    Attr.attribute Html.Attributes.name


{-| A short hint describing the expected value of the control, displayed before the user enters a value. Valid on `<input>`, `<textarea>`.
-}
placeholder : String -> Attr { c | placeholder : Supported } msg
placeholder =
    Attr.attribute Html.Attributes.placeholder


{-| Whether the value of the control cannot be edited by the user (though it can still be submitted with the form). Valid on `<input>`, `<textarea>`.
-}
readonly : Bool -> Attr { c | readonly : Supported } msg
readonly =
    Attr.attribute Html.Attributes.readonly


{-| The relationship of the linked URL to the current document, as a space-separated list of link types. Valid on `<a>`, `<area>`, `<link>`.
-}
rel : String -> Attr { c | rel : Supported } msg
rel =
    Attr.attribute Html.Attributes.rel


{-| Whether the user must specify a value for the control before the owning form can be submitted. Valid on `<input>`, `<textarea>`, `<select>`.
-}
required : Bool -> Attr { c | required : Supported } msg
required =
    Attr.attribute Html.Attributes.required


{-| The number of visible text lines for the `<textarea>` control. Valid on `<textarea>`.
-}
rows : Int -> Attr { c | rows : Supported } msg
rows =
    Attr.attribute Html.Attributes.rows


{-| The URL of the image resource to embed. Valid on `<img>`.
-}
src : String -> Attr { c | src : Supported } msg
src =
    Attr.attribute Html.Attributes.src


{-| The granularity that the value must adhere to for a numeric, date, or time `<input>`, or `any` to allow any value. Valid on `<input>`.
-}
step : String -> Attr { c | step : Supported } msg
step =
    Attr.attribute Html.Attributes.step


{-| Where to display the linked URL, as the name of a browsing context (a tab, window, or `<iframe>`); keywords include `_self`, `_blank`, `_parent`, and `_top`. Valid on `<a>`, `<area>`, `<form>`.
-}
target : String -> Attr { c | target : Supported } msg
target =
    Attr.attribute Html.Attributes.target


{-| How an `<input>` element behaves and is displayed (for example `text`, `checkbox`, or `number`), or the default behavior of a `<button>` (`submit`, `reset`, or `button`). Valid on `<input>`, `<button>`.
-}
type_ : String -> Attr { c | type_ : Supported } msg
type_ =
    Attr.attribute Html.Attributes.type_


{-| The value of the form control, submitted with the form as part of a name/value pair. Valid on `<input>`, `<textarea>`, `<button>`, `<option>`.
-}
value : String -> Attr { c | value : Supported } msg
value =
    Attr.attribute Html.Attributes.value


{-| The intrinsic width of the image, in pixels. Valid on `<img>`.
-}
width : Int -> Attr { c | width : Supported } msg
width =
    Attr.attribute Html.Attributes.width
