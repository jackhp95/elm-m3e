module M3e.YearView exposing (yearView)

{-| 
@docs yearView
-}


import M3e.Cem.Attr
import M3e.Cem.YearView
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-year-view>` element (lazy IR). -}
yearView :
    List (M3e.Cem.Attr.Attr { today : M3e.Value.Supported
    , date : M3e.Value.Supported
    , activeDate : M3e.Value.Supported
    , minDate : M3e.Value.Supported
    , maxDate : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onActiveChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | yearView : M3e.Value.Supported } msg
yearView attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.YearView.yearView
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )