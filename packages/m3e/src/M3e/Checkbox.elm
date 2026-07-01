module M3e.Checkbox exposing (checkbox)

{-| 
@docs checkbox
-}


import Html.Attributes
import M3e.Cem.Attr
import M3e.Cem.Checkbox
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-checkbox>` element (lazy IR). -}
checkbox :
    { ariaLabel : String }
    -> List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , indeterminate : M3e.Value.Supported
    , name : M3e.Value.Supported
    , required : M3e.Value.Supported
    , value : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onInvalid : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | checkbox : M3e.Value.Supported } msg
checkbox req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Checkbox.checkbox
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
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