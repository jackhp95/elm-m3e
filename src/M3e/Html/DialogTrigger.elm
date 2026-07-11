module M3e.Html.DialogTrigger exposing (dialogTrigger, for)

{-| Middle layer for `<m3e-dialog-trigger>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.DialogTrigger` module for everyday use.

@docs dialogTrigger, for

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.DialogTrigger
import M3e.Token


{-| An element, nested within a clickable element, used to open a dialog.

**Component Info:**

  - **Extends:** `ActionElementBase`

-}
dialogTrigger :
    List
        (M3e.Html.Attr.Attr
            { for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
dialogTrigger attributes children =
    M3e.Raw.DialogTrigger.dialogTrigger
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> M3e.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.Attr.Internal.attribute M3e.Raw.DialogTrigger.for
