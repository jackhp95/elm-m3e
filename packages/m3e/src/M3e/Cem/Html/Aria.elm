module M3e.Cem.Html.Aria exposing (label, labelledby, describedby, hidden)

{-| Accessibility attributes for the bottom (raw `elm/html`) layer — universal,
settable on any element. The strict/middle layers use `M3e.Aria`.

@docs label, labelledby, describedby, hidden

-}

import Html
import Html.Attributes


{-| Set `aria-label` on any element.
-}
label : String -> Html.Attribute msg
label =
    Html.Attributes.attribute "aria-label"


{-| Set `aria-labelledby` on any element.
-}
labelledby : String -> Html.Attribute msg
labelledby =
    Html.Attributes.attribute "aria-labelledby"


{-| Set `aria-describedby` on any element.
-}
describedby : String -> Html.Attribute msg
describedby =
    Html.Attributes.attribute "aria-describedby"


{-| Set `aria-hidden` on any element (e.g. `"true"` to hide a decorative
element from assistive technology).
-}
hidden : String -> Html.Attribute msg
hidden =
    Html.Attributes.attribute "aria-hidden"
