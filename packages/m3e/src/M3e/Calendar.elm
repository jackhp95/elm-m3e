module M3e.Calendar exposing (calendar, header)

{-| 
@docs calendar, header
-}


import M3e.Cem.Attr
import M3e.Cem.Calendar
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-calendar>` element (lazy IR). -}
calendar :
    List (M3e.Cem.Attr.Attr { date : M3e.Value.Supported
    , maxDate : M3e.Value.Supported
    , minDate : M3e.Value.Supported
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
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { header : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | calendar : M3e.Value.Supported } msg
calendar attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Calendar.calendar
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `header` slot. -}
header :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | header : M3e.Value.Supported } msg
header el =
    M3e.Content.slot "header" el