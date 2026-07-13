module M3e.DatepickerToggle exposing (view, for)

{-| An element, nested within a clickable element, used to toggle a datepicker.

**Component Info:**

  - **Extends:** `ActionElementBase`

@docs view, for

-}

import M3e.Html.DatepickerToggle
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-datepicker-toggle>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | datepickerToggle : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.DatepickerToggle.datepickerToggle
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.DatepickerToggle.for
