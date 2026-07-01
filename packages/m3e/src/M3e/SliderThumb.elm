module M3e.SliderThumb exposing (sliderThumb)

{-| 
@docs sliderThumb
-}


import M3e.Cem.Attr
import M3e.Cem.SliderThumb
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-slider-thumb>` element (lazy IR). -}
sliderThumb :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , name : M3e.Value.Supported
    , value : M3e.Value.Supported
    , onValueChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | sliderThumb : M3e.Value.Supported } msg
sliderThumb attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.SliderThumb.sliderThumb
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )