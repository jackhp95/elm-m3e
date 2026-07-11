module M3e.Raw.FloatingPanel exposing (floatingPanel, scrollStrategy, fitAnchorWidth, anchorOffset, onBeforetoggle, onToggle)

{-| Bottom layer for `<m3e-floating-panel>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs floatingPanel, scrollStrategy, fitAnchorWidth, anchorOffset, onBeforetoggle, onToggle

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-floating-panel>` element — a partial application of `Html.node`.
-}
floatingPanel : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
floatingPanel =
    Html.node "m3e-floating-panel"


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`)
-}
scrollStrategy : String -> Html.Attribute msg
scrollStrategy =
    Html.Attributes.attribute "scroll-strategy"


{-| Whether the panel's width should match its anchor's width. (default: `false`)
-}
fitAnchorWidth : Bool -> Html.Attribute msg
fitAnchorWidth val_ =
    if val_ then
        Html.Attributes.attribute "fit-anchor-width" ""

    else
        Html.Attributes.classList []


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`)
-}
anchorOffset : Float -> Html.Attribute msg
anchorOffset val_ =
    Html.Attributes.attribute "anchor-offset" (String.fromFloat val_)


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle =
    Html.Events.on "beforetoggle"


{-| Listen for `toggle` events.
-}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle =
    Html.Events.on "toggle"
