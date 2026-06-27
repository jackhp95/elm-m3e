module Cem.M3e.Card exposing
    ( component
    , actionable, inline, Orientation(..), orientation, Variant(..), variant, href, target, rel, download, name, value, Type(..), type_, disabledInteractive, disabled
    , onClick
    , headerSlot, contentSlot, actionsSlot, footerSlot
    , orientationToString, typeToString, variantToString
    )

{-| A content container for text, images (or other media), and actions in the context of a single subject.


## Component

@docs component


### Attributes

@docs actionable, inline, Orientation, orientation, Variant, variant, href, target, rel, download, name, value, Type, type_, disabledInteractive, disabled


### Events

@docs onClick


### Slots

@docs headerSlot, contentSlot, actionsSlot, footerSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A content container for text, images (or other media), and actions in the context of a single subject.

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `header`: Renders the header of the card.
  - `content`: Renders the content of the card with padding.
  - `actions`: Renders the actions of the card.
  - `footer`: Renders the footer of the card.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-card" attributes children


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`)
-}
actionable : Bool -> Html.Attribute msg
actionable val_ =
    Html.Attributes.property "actionable" (Json.Encode.bool val_)


{-| Whether to present the card inline with surrounding content. (default: `false`)
-}
inline : Bool -> Html.Attribute msg
inline val_ =
    Html.Attributes.property "inline" (Json.Encode.bool val_)


{-| Values for the `orientation` attribute.
-}
type Orientation
    = Horizontal
    | Vertical


{-| The orientation of the card. (default: `"vertical"`)
-}
orientation : Orientation -> Html.Attribute msg
orientation val_ =
    Html.Attributes.attribute "orientation" (orientationToString val_)


orientationToString : Orientation -> String
orientationToString val_ =
    case val_ of
        Horizontal ->
            "horizontal"

        Vertical ->
            "vertical"


{-| Values for the `variant` attribute.
-}
type Variant
    = Elevated
    | Filled
    | Outlined


{-| The appearance variant of the card. (default: `"filled"`)
-}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Elevated ->
            "elevated"

        Filled ->
            "filled"

        Outlined ->
            "outlined"


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Html.Attribute msg
href val_ =
    Html.Attributes.attribute "href" val_


{-| The target of the link button. (default: `""`)
-}
target : String -> Html.Attribute msg
target val_ =
    Html.Attributes.attribute "target" val_


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Html.Attribute msg
rel val_ =
    Html.Attributes.attribute "rel" val_


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Html.Attribute msg
download val_ =
    Html.Attributes.attribute "download" val_


{-| The name of the element, submitted as a pair with the element's `value`
as part of form data, when the element is used to submit a form.
-}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| The value associated with the element's name when it's submitted with form data.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| Values for the `type` attribute.
-}
type Type
    = Button
    | Reset
    | Submit


{-| The type of the element. (default: `"button"`)
-}
type_ : Type -> Html.Attribute msg
type_ val_ =
    Html.Attributes.attribute "type" (typeToString val_)


typeToString : Type -> String
typeToString val_ =
    case val_ of
        Button ->
            "button"

        Reset ->
            "reset"

        Submit ->
            "submit"


{-| Whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    Html.Attributes.property "disabled-interactive" (Json.Encode.bool val_)


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders the header of the card.
-}
headerSlot : Html.Attribute msg
headerSlot =
    Html.Attributes.attribute "slot" "header"


{-| Renders the content of the card with padding.
-}
contentSlot : Html.Attribute msg
contentSlot =
    Html.Attributes.attribute "slot" "content"


{-| Renders the actions of the card.
-}
actionsSlot : Html.Attribute msg
actionsSlot =
    Html.Attributes.attribute "slot" "actions"


{-| Renders the footer of the card.
-}
footerSlot : Html.Attribute msg
footerSlot =
    Html.Attributes.attribute "slot" "footer"
