module M3e.Progress exposing
    ( bufferValue, max, mode, value, variant, indeterminate
    , linear, circular
    )

{-|
The `Progress` family: the shared attribute setters plus one constructor per variant in the group, each building its variant's element with that variant's typed content.

@docs bufferValue, max, mode, value, variant, indeterminate
@docs linear, circular
-}


import M3e.Cem.Attr
import M3e.Cem.CircularProgressIndicator
import M3e.Cem.LinearProgressIndicator
import M3e.Element
import M3e.Node
import M3e.Value


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`) -}
bufferValue :
    Float -> M3e.Cem.Attr.Attr { c | bufferValue : M3e.Value.Supported } msg
bufferValue =
    M3e.Cem.LinearProgressIndicator.bufferValue


{-| The maximum progress value. (default: `100`) -}
max : Float -> M3e.Cem.Attr.Attr { c | max : M3e.Value.Supported } msg
max =
    M3e.Cem.LinearProgressIndicator.max


{-| The mode of the progress bar. (default: `"determinate"`) -}
mode :
    M3e.Value.Value { buffer : M3e.Value.Supported
    , determinate : M3e.Value.Supported
    , indeterminate : M3e.Value.Supported
    , query : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
mode =
    M3e.Cem.LinearProgressIndicator.mode


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`) -}
value : Float -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.LinearProgressIndicator.value


{-| The appearance of the indicator. (default: `"flat"`) -}
variant :
    M3e.Value.Value { flat : M3e.Value.Supported, wavy : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.LinearProgressIndicator.variant


{-| Whether to show something is happening without conveying progress. (default: `false`) -}
indeterminate :
    Bool -> M3e.Cem.Attr.Attr { c | indeterminate : M3e.Value.Supported } msg
indeterminate =
    M3e.Cem.CircularProgressIndicator.indeterminate


{-| The `m3e-linear-progress-indicator` variant. -}
linear :
    List (M3e.Cem.Attr.Attr { bufferValue : M3e.Value.Supported
    , max : M3e.Value.Supported
    , mode : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | progress : M3e.Value.Supported } msg
linear attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.LinearProgressIndicator.linearProgressIndicator
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| The `m3e-circular-progress-indicator` variant. -}
circular :
    List (M3e.Cem.Attr.Attr { indeterminate : M3e.Value.Supported
    , max : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | progress : M3e.Value.Supported } msg
circular attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.CircularProgressIndicator.circularProgressIndicator
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Element.toNode children)
        )