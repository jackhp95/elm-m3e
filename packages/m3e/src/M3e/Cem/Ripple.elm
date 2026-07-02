module M3e.Cem.Ripple exposing
    ( ripple, centered, disabled, for, radius, unbounded
    )

{-|
Middle layer for `<m3e-ripple>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Ripple` module for everyday use.

@docs ripple, centered, disabled, for, radius, unbounded
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Ripple
import M3e.Value


{-| Connects user input to screen reactions using ripples. -}
ripple :
    List (M3e.Cem.Attr.Attr { centered : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , radius : M3e.Value.Supported
    , unbounded : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
ripple attributes children =
    M3e.Cem.Html.Ripple.ripple
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the ripple always originates from the center of the element's bounds, rather
than originating from the location of the click event. (default: `false`)
-}
centered : Bool -> M3e.Cem.Attr.Attr { c | centered : M3e.Value.Supported } msg
centered =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Ripple.centered


{-| Whether click events will not trigger the ripple.
Ripples can be still controlled manually by using the `show` and 'hide' methods. (default: `false`)
-}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Ripple.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Ripple.for


{-| The radius, in pixels, of the ripple. (default: `null`) -}
radius : Float -> M3e.Cem.Attr.Attr { c | radius : M3e.Value.Supported } msg
radius =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Ripple.radius


{-| Whether the ripple is visible outside the element's bounds. (default: `false`) -}
unbounded :
    Bool -> M3e.Cem.Attr.Attr { c | unbounded : M3e.Value.Supported } msg
unbounded =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Ripple.unbounded