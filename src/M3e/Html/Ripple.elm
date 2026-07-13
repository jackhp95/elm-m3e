module M3e.Html.Ripple exposing (ripple, centered, disabled, for, radius, unbounded)

{-| Middle layer for `<m3e-ripple>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Ripple` module for everyday use.

@docs ripple, centered, disabled, for, radius, unbounded

-}

import Html
import M3e.Raw.Ripple
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| Connects user input to screen reactions using ripples.

**Component Info:**

  - **Extends:** `LitElement`

-}
ripple :
    List
        (Markup.Html.Attr.Attr
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
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the ripple always originates from the center of the element's bounds, rather
than originating from the location of the click event. (default: `false`)
-}
centered : Bool -> Markup.Html.Attr.Attr { c | centered : M3e.Token.Supported } msg
centered =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Ripple.centered


{-| Whether click events will not trigger the ripple.
Ripples can be still controlled manually by using the `show` and 'hide' methods. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Ripple.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Ripple.for


{-| The radius, in pixels, of the ripple. (default: `null`)
-}
radius : Float -> Markup.Html.Attr.Attr { c | radius : M3e.Token.Supported } msg
radius =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Ripple.radius


{-| Whether the ripple is visible outside the element's bounds. (default: `false`)
-}
unbounded : Bool -> Markup.Html.Attr.Attr { c | unbounded : M3e.Token.Supported } msg
unbounded =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Ripple.unbounded
