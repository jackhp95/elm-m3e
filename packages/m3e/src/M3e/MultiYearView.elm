module M3e.MultiYearView exposing (multiYearView)

{-| 
@docs multiYearView
-}


import M3e.Cem.Attr
import M3e.Cem.MultiYearView
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-multi-year-view>` element (lazy IR). -}
multiYearView :
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
    -> M3e.Element.Element { s | multiYearView : M3e.Value.Supported } msg
multiYearView attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.MultiYearView.multiYearView
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )