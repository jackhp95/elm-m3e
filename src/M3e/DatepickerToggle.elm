module M3e.DatepickerToggle exposing (view, for)

{-| An element, nested within a clickable element, used to toggle a datepicker.

**Component Info:**

  - **Extends:** `ActionElementBase`

@docs view, for

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.DatepickerToggle
import M3e.Node
import M3e.Token


{-| Build the `<m3e-datepicker-toggle>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | datepickerToggle : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.DatepickerToggle.datepickerToggle
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> M3e.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.DatepickerToggle.for
