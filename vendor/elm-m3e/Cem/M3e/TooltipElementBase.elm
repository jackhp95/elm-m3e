module Cem.M3e.TooltipElementBase exposing
    ( component, disabled, showDelay, hideDelay, touchGestures, for
    , isopen
    )

{-| Provides a base implementation for a tooltip. This class must be inherited.

@docs component, disabled, showDelay, hideDelay, touchGestures, for
@docs isopen

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Json.Encode


{-| Provides a base implementation for a tooltip. This class must be inherited.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "div" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`)
-}
showDelay : Float -> Html.Attribute msg
showDelay val_ =
    Html.Attributes.property "show-delay" (Json.Encode.float val_)


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`)
-}
hideDelay : Float -> Html.Attribute msg
hideDelay val_ =
    Html.Attributes.property "hide-delay" (Json.Encode.float val_)


{-| The mode in which to handle touch gestures. (default: `"auto"`)
-}
touchGestures :
    Cem.M3e.Common.Value
        { auto : Cem.M3e.Common.Supported
        , off : Cem.M3e.Common.Supported
        , on : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
touchGestures =
    Cem.M3e.Common.touchGestures


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| Whether the tooltip is currently open.
-}
isopen : Bool -> Html.Attribute msg
isopen val_ =
    Html.Attributes.property "isOpen" (Json.Encode.bool val_)
