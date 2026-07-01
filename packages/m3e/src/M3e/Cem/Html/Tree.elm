module M3e.Cem.Html.Tree exposing (cascade, multi, onChange, tree)

{-| 
@docs tree, multi, cascade, onChange
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-tree>` element — a partial application of `Html.node`. -}
tree : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
tree =
    Html.node "m3e-tree"


{-| Whether multiple items can be selected. (default: `false`) -}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)


{-| Whether multiple item selection cascades to child items. (default: `false`) -}
cascade : Bool -> Html.Attribute msg
cascade val_ =
    Html.Attributes.property "cascade" (Json.Encode.bool val_)


{-| Listen for `change` events. -}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"