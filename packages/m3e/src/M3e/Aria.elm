module M3e.Aria exposing (label, labelledby, describedby)

{-| Accessibility attributes that apply to **any** component. Aria is universal,
so these setters are independent of the phantom slot/capability rows: each
carries a fully-open capability row and therefore type-checks inside any
component's attribute list (`M3e.<Component>.view [ M3e.Aria.label "…" ] …`).

Per-component _requirements_ (e.g. "a checkbox must be labelled") are enforced by
elm-review rules, not by the type system.

@docs label, labelledby, describedby

-}

import Html.Attributes
import M3e.Cem.Attr as Attr exposing (Attr)


{-| Set `aria-label` on any component.
-}
label : String -> Attr capability msg
label =
    Attr.attribute (Html.Attributes.attribute "aria-label")


{-| Set `aria-labelledby` on any component.
-}
labelledby : String -> Attr capability msg
labelledby =
    Attr.attribute (Html.Attributes.attribute "aria-labelledby")


{-| Set `aria-describedby` on any component.
-}
describedby : String -> Attr capability msg
describedby =
    Attr.attribute (Html.Attributes.attribute "aria-describedby")
