module M3e.Cem.Html.LoadingIndicator exposing ( loadingIndicator, variant )

{-|
Bottom layer for `<m3e-loading-indicator>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs loadingIndicator, variant
-}


import Html
import Html.Attributes


{-| The raw `<m3e-loading-indicator>` element — a partial application of `Html.node`. -}
loadingIndicator :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
loadingIndicator =
    Html.node "m3e-loading-indicator"


{-| The appearance variant of the indicator. (default: `"uncontained"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"