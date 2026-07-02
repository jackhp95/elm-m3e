module M3e.Cem.Html.OptionPanel exposing
    ( optionPanel, state, scrollStrategy, fitAnchorWidth, anchorOffset, onBeforetoggle
    , onToggle
    )

{-|
Bottom layer for `<m3e-option-panel>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs optionPanel, state, scrollStrategy, fitAnchorWidth, anchorOffset, onBeforetoggle
@docs onToggle
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-option-panel>` element — a partial application of `Html.node`. -}
optionPanel : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
optionPanel =
    Html.node "m3e-option-panel"


{-| The state for which to present content. (default: `"content"`) -}
state : String -> Html.Attribute msg
state =
    Html.Attributes.attribute "state"


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`) -}
scrollStrategy : String -> Html.Attribute msg
scrollStrategy =
    Html.Attributes.attribute "scroll-strategy"


{-| Whether the panel's width should match its anchor's width. (default: `false`) -}
fitAnchorWidth : Bool -> Html.Attribute msg
fitAnchorWidth val_ =
    Html.Attributes.property "fitAnchorWidth" (Json.Encode.bool val_)


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`) -}
anchorOffset : Float -> Html.Attribute msg
anchorOffset val_ =
    Html.Attributes.property "anchorOffset" (Json.Encode.float val_)


{-| Listen for `beforetoggle` events. -}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle =
    Html.Events.on "beforetoggle"


{-| Listen for `toggle` events. -}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle =
    Html.Events.on "toggle"