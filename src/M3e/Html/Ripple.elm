module M3e.Html.Ripple exposing (ripple, centered, disabled, for, radius, unbounded)

{-| Middle layer for `<m3e-ripple>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Ripple` module for everyday use.

@docs ripple, centered, disabled, for, radius, unbounded

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.Ripple
import M3e.Token


{-| Connects user input to screen reactions using ripples.

**Component Info:**

  - **Extends:** `LitElement`

-}
ripple :
    List
        (M3e.Html.Attr.Attr
            { centered : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , radius : M3e.Token.Supported
            , unbounded : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
ripple attributes children =
    M3e.Raw.Ripple.ripple
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether the ripple always originates from the center of the element's bounds, rather
than originating from the location of the click event. (default: `false`)
-}
centered : Bool -> M3e.Html.Attr.Attr { c | centered : M3e.Token.Supported } msg
centered =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Ripple.centered


{-| Whether click events will not trigger the ripple.
Ripples can be still controlled manually by using the `show` and 'hide' methods. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Ripple.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> M3e.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Ripple.for


{-| The radius, in pixels, of the ripple. (default: `null`)
-}
radius : Float -> M3e.Html.Attr.Attr { c | radius : M3e.Token.Supported } msg
radius =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Ripple.radius


{-| Whether the ripple is visible outside the element's bounds. (default: `false`)
-}
unbounded : Bool -> M3e.Html.Attr.Attr { c | unbounded : M3e.Token.Supported } msg
unbounded =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Ripple.unbounded
