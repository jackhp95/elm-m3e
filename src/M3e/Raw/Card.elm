module M3e.Raw.Card exposing
    ( card, actionable, inline, orientation, variant, href
    , target, rel, download, name, value, type_
    , disabledInteractive, disabled, onClick
    )

{-| Bottom layer for `<m3e-card>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs card, actionable, inline, orientation, variant, href
@docs target, rel, download, name, value, type_
@docs disabledInteractive, disabled, onClick

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-card>` element — a partial application of `Html.node`.
-}
card : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
card =
    Html.node "m3e-card"


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`)
-}
actionable : Bool -> Html.Attribute msg
actionable val_ =
    if val_ then
        Html.Attributes.attribute "actionable" ""

    else
        Html.Attributes.classList []


{-| Whether to present the card inline with surrounding content. (default: `false`)
-}
inline : Bool -> Html.Attribute msg
inline val_ =
    if val_ then
        Html.Attributes.attribute "inline" ""

    else
        Html.Attributes.classList []


{-| The orientation of the card. (default: `"vertical"`)
-}
orientation : String -> Html.Attribute msg
orientation =
    Html.Attributes.attribute "orientation"


{-| The appearance variant of the card. (default: `"filled"`)
-}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Html.Attribute msg
href =
    Html.Attributes.attribute "href"


{-| The target of the link button. (default: `""`)
-}
target : String -> Html.Attribute msg
target =
    Html.Attributes.attribute "target"


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Html.Attribute msg
rel =
    Html.Attributes.attribute "rel"


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Html.Attribute msg
download =
    Html.Attributes.attribute "download"


{-| The name of the element, submitted as a pair with the element's `value`
as part of form data, when the element is used to submit a form.
-}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"


{-| The value associated with the element's name when it's submitted with form data.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.attribute "value"


{-| The type of the element. (default: `"button"`)
-}
type_ : String -> Html.Attribute msg
type_ =
    Html.Attributes.attribute "type"


{-| Whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    if val_ then
        Html.Attributes.attribute "disabled-interactive" ""

    else
        Html.Attributes.classList []


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""

    else
        Html.Attributes.classList []


{-| Listen for `click` events.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"
