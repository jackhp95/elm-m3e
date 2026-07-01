module M3e.NavRailToggle exposing (for, navRailToggle)

{-| 
@docs navRailToggle, for
-}


import M3e.Cem.Attr
import M3e.Cem.NavRailToggle
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-nav-rail-toggle>` element (lazy IR). -}
navRailToggle :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | navRailToggle : M3e.Value.Supported } msg
navRailToggle attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.NavRailToggle.navRailToggle
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.NavRailToggle.for