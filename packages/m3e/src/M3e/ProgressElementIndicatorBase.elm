module M3e.ProgressElementIndicatorBase exposing ( view, value, max, variant )

{-|
A base implementation for an element used to convey progress. This class must be inherited.

**Component Info:**
- **Extends:** `LitElement`

@docs view, value, max, variant
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.ProgressElementIndicatorBase
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<div>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { value : M3e.Value.Supported
    , max : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s
        | progressElementIndicatorBase : M3e.Value.Supported
    } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.ProgressElementIndicatorBase.progressElementIndicatorBase
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`) -}
value : Float -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.ProgressElementIndicatorBase.value


{-| The maximum progress value. (default: `100`) -}
max : Float -> M3e.Cem.Attr.Attr { c | max : M3e.Value.Supported } msg
max =
    M3e.Cem.ProgressElementIndicatorBase.max


{-| The appearance of the indicator. (default: `"flat"`) -}
variant :
    M3e.Value.Value { flat : M3e.Value.Supported, wavy : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.ProgressElementIndicatorBase.variant