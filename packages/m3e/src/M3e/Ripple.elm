module M3e.Ripple exposing
    ( view, centered, disabled, for, radius, unbounded
    )

{-|
Connects user input to screen reactions using ripples.

@docs view, centered, disabled, for, radius, unbounded
-}


import M3e.Cem.Attr
import M3e.Cem.Ripple
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-ripple>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { centered : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , radius : M3e.Value.Supported
    , unbounded : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | ripple : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Ripple.ripple (List.map M3e.Cem.Attr.forget erased) ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether the ripple always originates from the center of the element's bounds, rather
than originating from the location of the click event. (default: `false`)
-}
centered : Bool -> M3e.Cem.Attr.Attr { c | centered : M3e.Value.Supported } msg
centered =
    M3e.Cem.Ripple.centered


{-| Whether click events will not trigger the ripple.
Ripples can be still controlled manually by using the `show` and 'hide' methods. (default: `false`)
-}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Ripple.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Ripple.for


{-| The radius, in pixels, of the ripple. (default: `null`) -}
radius : Float -> M3e.Cem.Attr.Attr { c | radius : M3e.Value.Supported } msg
radius =
    M3e.Cem.Ripple.radius


{-| Whether the ripple is visible outside the element's bounds. (default: `false`) -}
unbounded :
    Bool -> M3e.Cem.Attr.Attr { c | unbounded : M3e.Value.Supported } msg
unbounded =
    M3e.Cem.Ripple.unbounded