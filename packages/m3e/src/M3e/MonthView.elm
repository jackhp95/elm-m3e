module M3e.MonthView exposing (monthView)

{-| 
@docs monthView
-}


import M3e.Cem.Attr
import M3e.Cem.MonthView
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-month-view>` element (lazy IR). -}
monthView :
    List (M3e.Cem.Attr.Attr { rangeStart : M3e.Value.Supported
    , rangeEnd : M3e.Value.Supported
    , today : M3e.Value.Supported
    , date : M3e.Value.Supported
    , activeDate : M3e.Value.Supported
    , minDate : M3e.Value.Supported
    , maxDate : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onActiveChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | monthView : M3e.Value.Supported } msg
monthView attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.MonthView.monthView
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )