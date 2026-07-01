module M3e.Cem.DatepickerToggle exposing (datepickerToggle, for)

{-| 
@docs datepickerToggle, for
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.DatepickerToggle
import M3e.Value


{-| An element, nested within a clickable element, used to toggle a datepicker. -}
datepickerToggle :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
datepickerToggle attributes children =
    M3e.Cem.Html.DatepickerToggle.datepickerToggle
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.attribute M3e.Cem.Html.DatepickerToggle.for