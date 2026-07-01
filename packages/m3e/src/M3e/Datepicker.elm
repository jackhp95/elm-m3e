module M3e.Datepicker exposing (datepicker)

{-| 
@docs datepicker
-}


import M3e.Cem.Attr
import M3e.Cem.Datepicker
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-datepicker>` element (lazy IR). -}
datepicker :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , clearable : M3e.Value.Supported
    , date : M3e.Value.Supported
    , maxDate : M3e.Value.Supported
    , minDate : M3e.Value.Supported
    , range : M3e.Value.Supported
    , rangeEnd : M3e.Value.Supported
    , rangeStart : M3e.Value.Supported
    , startAt : M3e.Value.Supported
    , startView : M3e.Value.Supported
    , previousMonthLabel : M3e.Value.Supported
    , nextMonthLabel : M3e.Value.Supported
    , previousYearLabel : M3e.Value.Supported
    , nextYearLabel : M3e.Value.Supported
    , previousMultiYearLabel : M3e.Value.Supported
    , nextMultiYearLabel : M3e.Value.Supported
    , clearLabel : M3e.Value.Supported
    , confirmLabel : M3e.Value.Supported
    , dismissLabel : M3e.Value.Supported
    , label : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | datepicker : M3e.Value.Supported } msg
datepicker attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Datepicker.datepicker
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )