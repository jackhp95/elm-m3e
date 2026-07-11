module M3e.Html.DatepickerToggle exposing (datepickerToggle, for)

{-| Middle layer for `<m3e-datepicker-toggle>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.DatepickerToggle` module for everyday use.

@docs datepickerToggle, for

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.DatepickerToggle
import M3e.Token


{-| An element, nested within a clickable element, used to toggle a datepicker.

**Component Info:**

  - **Extends:** `ActionElementBase`

-}
datepickerToggle :
    List
        (M3e.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
datepickerToggle attributes children =
    M3e.Raw.DatepickerToggle.datepickerToggle
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> M3e.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.Attr.Internal.attribute M3e.Raw.DatepickerToggle.for
