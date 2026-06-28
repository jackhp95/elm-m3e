module Cem.M3e.Fab exposing
    ( component
    , disabled, disabledInteractive, download, extended, href, lowered, name, rel, Size(..), size, target, Type(..), type_, value, Variant(..), variant
    , onClick
    , labelSlot, closeIconSlot
    , sizeToString, typeToString, variantToString
    )

{-| A floating action button (FAB) used to present important actions.


## Component

@docs component


### Attributes

@docs disabled, disabledInteractive, download, extended, href, lowered, name, rel, Size, size, target, Type, type_, value, Variant, variant


### Events

@docs onClick


### Slots

@docs labelSlot, closeIconSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A floating action button (FAB) used to present important actions.

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `label`: Renders the label of an extended button.
  - `close-icon`: Renders the close icon when used to open a FAB menu.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-fab" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    Html.Attributes.property "disabledInteractive" (Json.Encode.bool val_)


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Html.Attribute msg
download val_ =
    Html.Attributes.attribute "download" val_


{-| Whether the button is extended to show the label. (default: `false`)
-}
extended : Bool -> Html.Attribute msg
extended val_ =
    Html.Attributes.property "extended" (Json.Encode.bool val_)


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Html.Attribute msg
href val_ =
    Html.Attributes.attribute "href" val_


{-| Whether to present a lowered elevation. (default: `false`)
-}
lowered : Bool -> Html.Attribute msg
lowered val_ =
    Html.Attributes.property "lowered" (Json.Encode.bool val_)


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form.
-}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Html.Attribute msg
rel val_ =
    Html.Attributes.attribute "rel" val_


{-| Values for the `size` attribute.
-}
type Size
    = Large
    | Medium
    | Small


{-| The size of the button. (default: `"medium"`)
-}
size : Size -> Html.Attribute msg
size val_ =
    Html.Attributes.attribute "size" (sizeToString val_)


sizeToString : Size -> String
sizeToString val_ =
    case val_ of
        Large ->
            "large"

        Medium ->
            "medium"

        Small ->
            "small"


{-| The target of the link button. (default: `""`)
-}
target : String -> Html.Attribute msg
target val_ =
    Html.Attributes.attribute "target" val_


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


{-| The value associated with the element's name when it's submitted with form data.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| Values for the `variant` attribute.
-}
type Variant
    = Primary
    | PrimaryContainer
    | Secondary
    | SecondaryContainer
    | Surface
    | Tertiary
    | TertiaryContainer


{-| The appearance variant of the button. (default: `"primary-container"`)
-}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Primary ->
            "primary"

        PrimaryContainer ->
            "primary-container"

        Secondary ->
            "secondary"

        SecondaryContainer ->
            "secondary-container"

        Surface ->
            "surface"

        Tertiary ->
            "tertiary"

        TertiaryContainer ->
            "tertiary-container"


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders the label of an extended button.
-}
labelSlot : Html.Attribute msg
labelSlot =
    Html.Attributes.attribute "slot" "label"


{-| Renders the close icon when used to open a FAB menu.
-}
closeIconSlot : Html.Attribute msg
closeIconSlot =
    Html.Attributes.attribute "slot" "close-icon"
