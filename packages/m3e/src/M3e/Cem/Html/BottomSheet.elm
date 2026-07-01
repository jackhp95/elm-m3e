module M3e.Cem.Html.BottomSheet exposing (bottomSheet, detent, handle, handleLabel, hideFriction, hideable, modal, onCancel, onClosed, onClosing, onOpened, onOpening, open, overshootLimit)

{-| 
@docs bottomSheet, detent, handle, handleLabel, hideable, hideFriction, modal, open, overshootLimit, onOpening, onClosing, onCancel, onOpened, onClosed
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-bottom-sheet>` element — a partial application of `Html.node`. -}
bottomSheet : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
bottomSheet =
    Html.node "m3e-bottom-sheet"


{-| The zero‑based index of the detent the sheet should open to. (default: `0`) -}
detent : Float -> Html.Attribute msg
detent val_ =
    Html.Attributes.property "detent" (Json.Encode.float val_)


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
handle : Bool -> Html.Attribute msg
handle val_ =
    Html.Attributes.property "handle" (Json.Encode.bool val_)


{-| The accessible label given to the drag handle. (default: `"Drag handle"`) -}
handleLabel : String -> Html.Attribute msg
handleLabel =
    Html.Attributes.attribute "handle-label"


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`) -}
hideable : Bool -> Html.Attribute msg
hideable val_ =
    Html.Attributes.property "hideable" (Json.Encode.bool val_)


{-| The friction coefficient to hide the sheet. (default: `0.5`) -}
hideFriction : Float -> Html.Attribute msg
hideFriction val_ =
    Html.Attributes.property "hideFriction" (Json.Encode.float val_)


{-| Whether the bottom sheet behaves as modal. (default: `false`) -}
modal : Bool -> Html.Attribute msg
modal val_ =
    Html.Attributes.property "modal" (Json.Encode.bool val_)


{-| Whether the bottom sheet is open. (default: `false`) -}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`) -}
overshootLimit : Float -> Html.Attribute msg
overshootLimit val_ =
    Html.Attributes.property "overshootLimit" (Json.Encode.float val_)


{-| Listen for `opening` events. -}
onOpening : Json.Decode.Decoder msg -> Html.Attribute msg
onOpening =
    Html.Events.on "opening"


{-| Listen for `closing` events. -}
onClosing : Json.Decode.Decoder msg -> Html.Attribute msg
onClosing =
    Html.Events.on "closing"


{-| Listen for `cancel` events. -}
onCancel : Json.Decode.Decoder msg -> Html.Attribute msg
onCancel =
    Html.Events.on "cancel"


{-| Listen for `opened` events. -}
onOpened : Json.Decode.Decoder msg -> Html.Attribute msg
onOpened =
    Html.Events.on "opened"


{-| Listen for `closed` events. -}
onClosed : Json.Decode.Decoder msg -> Html.Attribute msg
onClosed =
    Html.Events.on "closed"