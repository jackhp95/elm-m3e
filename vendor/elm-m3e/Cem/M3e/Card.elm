module Cem.M3e.Card exposing
    ( component, actionable, inline, orientation, variant, href
    , target, rel, download, name, value, type_
    , disabledInteractive, disabled, onClick, headerSlot, contentSlot, actionsSlot
    , footerSlot
    )

{-| A content container for text, images (or other media), and actions in the context of a single subject.

@docs component, actionable, inline, orientation, variant, href
@docs target, rel, download, name, value, type_
@docs disabledInteractive, disabled, onClick, headerSlot, contentSlot, actionsSlot
@docs footerSlot

-}

import Cem.M3e.Common
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

**CSS Custom Properties:**

  - `--m3e-card-padding`: Internal spacing for all slotted regions
  - `--m3e-card-shape`: Corner radius of the card container.
  - `--m3e-filled-card-text-color`: Foreground color for text content in filled cards.
  - `--m3e-filled-card-container-color`: Background color of the filled card container.
  - `--m3e-filled-card-container-elevation`: Elevation level for filled card container.
  - `--m3e-filled-card-disabled-text-color`: Text color when filled card is disabled.
  - `--m3e-filled-card-disabled-text-opacity`: Opacity applied to text when disabled.
  - `--m3e-filled-card-disabled-container-color`: Background color when disabled.
  - `--m3e-filled-card-disabled-container-elevation`: Elevation level when disabled.
  - `--m3e-filled-card-disabled-container-elevation-color`: Shadow color when disabled.
  - `--m3e-filled-card-disabled-container-elevation-opacity`: Shadow opacity when disabled.
  - `--m3e-filled-card-disabled-container-opacity`: Overall container opacity when disabled.
  - `--m3e-filled-card-hover-text-color`: Text color on hover.
  - `--m3e-filled-card-hover-state-layer-color`: State layer color on hover.
  - `--m3e-filled-card-hover-state-layer-opacity`: State layer opacity on hover.
  - `--m3e-filled-card-hover-container-elevation`: Elevation level on hover.
  - `--m3e-filled-card-focus-text-color`: Text color on focus.
  - `--m3e-filled-card-focus-state-layer-color`: State layer color on focus.
  - `--m3e-filled-card-focus-state-layer-opacity`: State layer opacity on focus.
  - `--m3e-filled-card-focus-container-elevation`: Elevation level on focus.
  - `--m3e-filled-card-pressed-text-color`: Text color on press.
  - `--m3e-filled-card-pressed-state-layer-color`: State layer color on press.
  - `--m3e-filled-card-pressed-state-layer-opacity`: State layer opacity on press.
  - `--m3e-filled-card-pressed-container-elevation`: Elevation level on press.
  - `--m3e-elevated-card-text-color`: Foreground color for text content in elevated cards.
  - `--m3e-elevated-card-container-color`: Background color of the elevated card container.
  - `--m3e-elevated-card-container-elevation`: Elevation level for elevated card container.
  - `--m3e-elevated-card-disabled-text-color`: Text color when elevated card is disabled.
  - `--m3e-elevated-card-disabled-text-opacity`: Opacity applied to text when disabled.
  - `--m3e-elevated-card-disabled-container-color`: Background color when disabled.
  - `--m3e-elevated-card-disabled-container-elevation`: Elevation level when disabled.
  - `--m3e-elevated-card-disabled-container-elevation-color`: Shadow color when disabled.
  - `--m3e-elevated-card-disabled-container-elevation-opacity`: Shadow opacity when disabled.
  - `--m3e-elevated-card-disabled-container-opacity`: Overall container opacity when disabled.
  - `--m3e-elevated-card-hover-text-color`: Text color on hover.
  - `--m3e-elevated-card-hover-state-layer-color`: State layer color on hover.
  - `--m3e-elevated-card-hover-state-layer-opacity`: State layer opacity on hover.
  - `--m3e-elevated-card-hover-container-elevation`: Elevation level on hover.
  - `--m3e-elevated-card-focus-text-color`: Text color on focus.
  - `--m3e-elevated-card-focus-state-layer-color`: State layer color on focus.
  - `--m3e-elevated-card-focus-state-layer-opacity`: State layer opacity on focus.
  - `--m3e-elevated-card-focus-container-elevation`: Elevation level on focus.
  - `--m3e-elevated-card-pressed-text-color`: Text color on press.
  - `--m3e-elevated-card-pressed-state-layer-color`: State layer color on press.
  - `--m3e-elevated-card-pressed-state-layer-opacity`: State layer opacity on press.
  - `--m3e-elevated-card-pressed-container-elevation`: Elevation level on press.
  - `--m3e-outlined-card-text-color`: Foreground color for text content in outlined cards.
  - `--m3e-outlined-card-container-color`: Background color of the outlined card container.
  - `--m3e-outlined-card-container-elevation`: Elevation level for outlined card container.
  - `--m3e-outlined-card-outline-color`: Border color for outlined cards.
  - `--m3e-outlined-card-outline-thickness`: Border thickness for outlined cards.
  - `--m3e-outlined-card-disabled-text-color`: Text color when outlined card is disabled.
  - `--m3e-outlined-card-disabled-text-opacity`: Opacity applied to text when disabled.
  - `--m3e-outlined-card-disabled-container-elevation`: Elevation level when disabled.
  - `--m3e-outlined-card-disabled-container-elevation-color`: Shadow color when disabled.
  - `--m3e-outlined-card-disabled-container-elevation-opacity`: Shadow opacity when disabled.
  - `--m3e-outlined-card-disabled-outline-color`: Border color when disabled.
  - `--m3e-outlined-card-disabled-outline-opacity`: Border opacity when disabled.
  - `--m3e-outlined-card-hover-text-color`: Text color on hover.
  - `--m3e-outlined-card-hover-state-layer-color`: State layer color on hover.
  - `--m3e-outlined-card-hover-state-layer-opacity`: State layer opacity on hover.
  - `--m3e-outlined-card-hover-container-elevation`: Elevation level on hover.
  - `--m3e-outlined-card-hover-outline-color`: Border color on hover.
  - `--m3e-outlined-card-focus-text-color`: Text color on focus.
  - `--m3e-outlined-card-focus-state-layer-color`: State layer color on focus.
  - `--m3e-outlined-card-focus-state-layer-opacity`: State layer opacity on focus.
  - `--m3e-outlined-card-focus-container-elevation`: Elevation level on focus.
  - `--m3e-outlined-card-focus-outline-color`: Border color on focus.
  - `--m3e-outlined-card-pressed-text-color`: Text color on press.
  - `--m3e-outlined-card-pressed-state-layer-color`: State layer color on press.
  - `--m3e-outlined-card-pressed-state-layer-opacity`: State layer opacity on press.
  - `--m3e-outlined-card-pressed-container-elevation`: Elevation level on press.
  - `--m3e-outlined-card-pressed-outline-color`: Border color on press.

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


{-| The orientation of the card. (default: `"vertical"`)
-}
orientation :
    Cem.M3e.Common.Value
        { horizontal : Cem.M3e.Common.Supported
        , vertical : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
orientation =
    Cem.M3e.Common.orientation


{-| The appearance variant of the card. (default: `"filled"`)
-}
variant :
    Cem.M3e.Common.Value
        { elevated : Cem.M3e.Common.Supported
        , filled : Cem.M3e.Common.Supported
        , outlined : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


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


{-| The type of the element. (default: `"button"`)
-}
type_ :
    Cem.M3e.Common.Value
        { button : Cem.M3e.Common.Supported
        , reset : Cem.M3e.Common.Supported
        , submit : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
type_ =
    Cem.M3e.Common.type_


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
