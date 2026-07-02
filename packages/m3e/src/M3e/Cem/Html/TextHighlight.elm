module M3e.Cem.Html.TextHighlight exposing
    ( textHighlight, caseSensitive, disabled, mode, term, onHighlight
    )

{-|
Bottom layer for `<m3e-text-highlight>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs textHighlight, caseSensitive, disabled, mode, term, onHighlight
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-text-highlight>` element — a partial application of `Html.node`. -}
textHighlight :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
textHighlight =
    Html.node "m3e-text-highlight"


{-| Whether matching is case sensitive. (default: `false`) -}
caseSensitive : Bool -> Html.Attribute msg
caseSensitive val_ =
    Html.Attributes.property "caseSensitive" (Json.Encode.bool val_)


{-| A value indicating whether text highlighting is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The mode in which to highlight text. (default: `"contains"`) -}
mode : String -> Html.Attribute msg
mode =
    Html.Attributes.attribute "mode"


{-| The term to highlight. (default: `""`) -}
term : String -> Html.Attribute msg
term =
    Html.Attributes.attribute "term"


{-| Listen for `highlight` events. -}
onHighlight : Json.Decode.Decoder msg -> Html.Attribute msg
onHighlight =
    Html.Events.on "highlight"