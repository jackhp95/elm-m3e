module M3e.Ripple exposing (view, centered, disabled, for, radius, unbounded)

{-| Connects user input to screen reactions using ripples.

**Component Info:**

  - **Extends:** `LitElement`

@docs view, centered, disabled, for, radius, unbounded

-}

import M3e.Html.Ripple
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-ripple>` element (lazy IR).
-}
view :
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | ripple : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Ripple.ripple
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the ripple always originates from the center of the element's bounds, rather
than originating from the location of the click event. (default: `false`)
-}
centered : Bool -> Markup.Html.Attr.Attr { c | centered : M3e.Token.Supported } msg
centered =
    M3e.Html.Ripple.centered


{-| Whether click events will not trigger the ripple.
Ripples can be still controlled manually by using the `show` and 'hide' methods. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Ripple.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.Ripple.for


{-| The radius, in pixels, of the ripple. (default: `null`)
-}
radius : Float -> Markup.Html.Attr.Attr { c | radius : M3e.Token.Supported } msg
radius =
    M3e.Html.Ripple.radius


{-| Whether the ripple is visible outside the element's bounds. (default: `false`)
-}
unbounded : Bool -> Markup.Html.Attr.Attr { c | unbounded : M3e.Token.Supported } msg
unbounded =
    M3e.Html.Ripple.unbounded
