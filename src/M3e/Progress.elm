module M3e.Progress exposing
    ( bufferValue, max, mode, value, variant, indeterminate
    , linear, circular
    )

{-| The `Progress` family: the shared attribute setters plus one constructor per variant in the group, each building its variant's element with that variant's typed content.

@docs bufferValue, max, mode, value, variant, indeterminate
@docs linear, circular

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.CircularProgressIndicator
import M3e.Html.LinearProgressIndicator
import M3e.Node
import M3e.Token


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`)
-}
bufferValue : Float -> M3e.Html.Attr.Attr { c | bufferValue : M3e.Token.Supported } msg
bufferValue =
    M3e.Html.LinearProgressIndicator.bufferValue


{-| The maximum progress value. (default: `100`)
-}
max : Float -> M3e.Html.Attr.Attr { c | max : M3e.Token.Supported } msg
max =
    M3e.Html.LinearProgressIndicator.max


{-| The mode of the progress bar. (default: `"determinate"`)
-}
mode :
    M3e.Token.Value
        { buffer : M3e.Token.Supported
        , determinate : M3e.Token.Supported
        , indeterminate : M3e.Token.Supported
        , query : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
mode =
    M3e.Html.LinearProgressIndicator.mode


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`)
-}
value : Float -> M3e.Html.Attr.Attr { c | valueFloat : M3e.Token.Supported } msg
value =
    M3e.Html.LinearProgressIndicator.value


{-| The appearance of the indicator. (default: `"flat"`)
-}
variant :
    M3e.Token.Value { flat : M3e.Token.Supported, wavy : M3e.Token.Supported }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.LinearProgressIndicator.variant


{-| Whether to show something is happening without conveying progress. (default: `false`)
-}
indeterminate : Bool -> M3e.Html.Attr.Attr { c | indeterminate : M3e.Token.Supported } msg
indeterminate =
    M3e.Html.CircularProgressIndicator.indeterminate


{-| The `m3e-linear-progress-indicator` variant.
-}
linear :
    List
        (M3e.Html.Attr.Attr
            { bufferValue : M3e.Token.Supported
            , max : M3e.Token.Supported
            , mode : M3e.Token.Supported
            , valueFloat : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | progress : M3e.Token.Supported } msg
linear attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.LinearProgressIndicator.linearProgressIndicator
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The `m3e-circular-progress-indicator` variant.
-}
circular :
    List
        (M3e.Html.Attr.Attr
            { indeterminate : M3e.Token.Supported
            , max : M3e.Token.Supported
            , valueFloat : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | progress : M3e.Token.Supported } msg
circular attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.CircularProgressIndicator.circularProgressIndicator
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )
