module M3e.Stepper exposing (panel, step, stepper)

{-| 
@docs stepper, step, panel
-}


import M3e.Cem.Attr
import M3e.Cem.Stepper
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-stepper>` element (lazy IR). -}
stepper :
    List (M3e.Cem.Attr.Attr { headerPosition : M3e.Value.Supported
    , labelPosition : M3e.Value.Supported
    , linear : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { step : M3e.Value.Supported
    , panel : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | stepper : M3e.Value.Supported } msg
stepper attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Stepper.stepper (List.map M3e.Cem.Attr.forget erased) ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `step` slot. -}
step :
    M3e.Element.Element { step : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | step : M3e.Value.Supported } msg
step el =
    M3e.Content.slot "step" el


{-| Place content in the `panel` slot. -}
panel :
    M3e.Element.Element { stepPanel : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | panel : M3e.Value.Supported } msg
panel el =
    M3e.Content.slot "panel" el