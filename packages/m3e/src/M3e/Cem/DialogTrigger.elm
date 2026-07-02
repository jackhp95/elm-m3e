module M3e.Cem.DialogTrigger exposing ( dialogTrigger, for )

{-|
Middle layer for `<m3e-dialog-trigger>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.DialogTrigger` module for everyday use.

@docs dialogTrigger, for
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.DialogTrigger
import M3e.Value


{-| An element, nested within a clickable element, used to open a dialog. -}
dialogTrigger :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
dialogTrigger attributes children =
    M3e.Cem.Html.DialogTrigger.dialogTrigger
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.attribute M3e.Cem.Html.DialogTrigger.for