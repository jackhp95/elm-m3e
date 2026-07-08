module M3e.Attributes exposing (id, for, class, style)

{-| Plain HTML attributes that apply to **any** component. Like `M3e.Aria`, these
setters are independent of the phantom slot/capability rows: each carries a fully
open `capability` row and therefore type-checks inside any component's attribute
list (`M3e.<Component>.view [ M3e.Attributes.id "…" ] …`).

They mirror the universal-attribute precedent set by `M3e.Aria`: pure HTML truth,
no CEM data. The barrel (`M3e`) re-exposes them flat as `M3e.id`, `M3e.for`,
`M3e.class`, `M3e.style`.

@docs id, for, class, style

-}

import Html
import Html.Attributes
import M3e.Cem.Attr.Internal as Attr exposing (Attr)


{-| Set the `id` attribute on any component.
-}
id : String -> Attr capability msg
id =
    Attr.attribute (Html.Attributes.attribute "id")


{-| Set the `for` attribute on any component (e.g. a label's `for="<control-id>"`).
-}
for : String -> Attr capability msg
for =
    Attr.attribute (Html.Attributes.attribute "for")


{-| Set the `class` attribute on any component (space-separated class names).
-}
class : String -> Attr capability msg
class =
    Attr.attribute (Html.Attributes.attribute "class")


{-| Set the inline `style` attribute on any component from a list of
`( css-property, value )` pairs, serialized as a single plain `style="a: b; c: d"`
attribute string. A single plain attribute (rather than per-property
`Html.Attributes.style` calls or a JS `property`) is chosen deliberately: it carries
CSS custom properties (`--var`) reliably and round-trips as a `style` attribute.
-}
style : List ( String, String ) -> Attr capability msg
style =
    Attr.attribute styleString


styleString : List ( String, String ) -> Html.Attribute msg
styleString pairs =
    Html.Attributes.attribute "style"
        (String.join "; " (List.map (\( k, v ) -> k ++ ": " ++ v) pairs))
