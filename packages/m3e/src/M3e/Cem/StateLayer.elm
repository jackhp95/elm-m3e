module M3e.Cem.StateLayer exposing (disableHover, disabled, for, stateLayer)

{-| 
@docs stateLayer, disabled, disableHover, for
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.StateLayer
import M3e.Value


{-| Provides focus and hover state layer treatment for an interactive element. -}
stateLayer :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disableHover : M3e.Value.Supported
    , for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
stateLayer attributes children =
    M3e.Cem.Html.StateLayer.stateLayer
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether hover and focus events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.StateLayer.disabled


{-| Whether hover events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disableHover :
    Bool -> M3e.Cem.Attr.Attr { c | disableHover : M3e.Value.Supported } msg
disableHover =
    M3e.Cem.Attr.attribute M3e.Cem.Html.StateLayer.disableHover


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.attribute M3e.Cem.Html.StateLayer.for