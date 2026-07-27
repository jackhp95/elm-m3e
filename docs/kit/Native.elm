module Native exposing
    ( node, custom
    , attribute, onClick, style
    )

{-| Escape-hatch IR producers — use `TypedHtml.*` for plain HTML tags.

This module exposes only what `TypedHtml.*` **cannot** express:

  - `node` / `custom` — forging elements with a dynamic or custom-element tag
    name and a fully-open capability row (no per-element row narrowing).
  - `attribute`, `onClick`, `style` — injecting raw HTML attributes, event
    handlers, or inline CSS into any typed `Attr` slot.

For plain HTML elements (`div`, `span`, `label`, `input`, `a`, …) use the
corresponding `TypedHtml.*` producer — it provides closed, element-natural
attribute rows (`LabelAttrs`, `InputAttrs`, …) so mismatched attrs are a
compile error rather than a runtime surprise.

@docs node, custom
@docs attribute, onClick, style

-}

import Html.Attributes
import Html.Events
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import M3e.Kind



-- GENERIC BUILDERS ------------------------------------------------------------


{-| Build a native element from any tag name. Carries the `html` kind so it
drops into any slot that admits it.

Use this for **dynamic tag names** (tag determined at runtime) or **custom
elements** whose tag is not yet in `TypedHtml.*`. For all standard HTML tags
reach for `TypedHtml.*` directly.

-}
node :
    String
    -> List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
node tagName attrs kids =
    Ir.fromNode
        (Ir.node tagName attrs (List.map HtmlIr.Element.toNode kids))


{-| Build a named custom element (e.g. `"my-widget"`). Thin alias over `node`
that makes the intent explicit in call sites — search for `Native.custom` to
find every custom-element forge in the codebase.
-}
custom :
    String
    -> List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
custom =
    node



-- NATIVE ATTRIBUTE / EVENT ESCAPES --------------------------------------------


{-| A raw HTML attribute as a typed `Attr` carrying a fully-open capability row.

Use when `TypedHtml.Attributes` doesn't cover the attribute you need (custom
data attributes, ARIA attributes not in `TypedHtml.Aria`, non-standard attrs).

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
