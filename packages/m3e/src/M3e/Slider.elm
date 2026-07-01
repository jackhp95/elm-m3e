module M3e.Slider exposing (child, children, slider)

{-| 
@docs slider, child, children
-}


import Html.Attributes
import M3e.Cem.Attr
import M3e.Cem.Slider
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-slider>` element (lazy IR). -}
slider :
    { ariaLabel : String }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , discrete : M3e.Value.Supported
    , labelled : M3e.Value.Supported
    , max : M3e.Value.Supported
    , min : M3e.Value.Supported
    , step : M3e.Value.Supported
    , size : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | slider : M3e.Value.Supported } msg
slider req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Slider.slider (List.map M3e.Cem.Attr.forget erased) ch
            )
            (List.append
                []
                (List.append
                    [ M3e.Cem.Attr.forget
                        (M3e.Cem.Attr.attribute
                            (Html.Attributes.attribute "aria-label")
                            req_.ariaLabel
                        )
                    ]
                    (List.map M3e.Cem.Attr.forget attributes)
                )
            )
            (List.append [] (List.map M3e.Content.toNode content_))
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { sliderThumb : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { sliderThumb : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els