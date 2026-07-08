module M3e.Cem.Html.Attributes exposing (id, for, class, style)

{-| Plain HTML attributes for the bottom (raw `elm/html`) layer — universal,
settable on any element. The strict/middle layers use `M3e.Attributes`.

@docs id, for, class, style

-}

import Html
import Html.Attributes


{-| Set the `id` attribute on any element.
-}
id : String -> Html.Attribute msg
id =
    Html.Attributes.attribute "id"


{-| Set the `for` attribute on any element.
-}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"


{-| Set the `class` attribute on any element (space-separated class names).
-}
class : String -> Html.Attribute msg
class =
    Html.Attributes.attribute "class"


{-| Set the inline `style` attribute on any element from a list of
`( css-property, value )` pairs, serialized as a single plain `style="a: b; c: d"`
attribute string (CSS-custom-property safe, round-trips as a `style` attribute).
-}
style : List ( String, String ) -> Html.Attribute msg
style pairs =
    Html.Attributes.attribute "style"
        (String.join "; " (List.map (\( k, v ) -> k ++ ": " ++ v) pairs))
