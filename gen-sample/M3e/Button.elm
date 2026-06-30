module M3e.Button exposing (disabled, disabledInteractive, download, href, name, rel, selected, shape, size, target, toggle, type_, value, variant, view)

{-| 

-}


import Json.Encode
import M3e.Element
import M3e.Internal
import M3e.Node


type alias Config =
    { disabled : Bool
    , disabledInteractive : Bool
    , selected : Bool
    , toggle : Bool
    , download : Maybe String
    , href : Maybe String
    , name : Maybe String
    , rel : Maybe String
    , shape : Maybe String
    , size : Maybe String
    , target : Maybe String
    , type_ : Maybe String
    , value : Maybe String
    , variant : Maybe String
    }


type alias Option msg =
    M3e.Internal.Option Config msg


defaultConfig : Config
defaultConfig =
    { disabled = False
    , disabledInteractive = False
    , selected = False
    , toggle = False
    , download = Nothing
    , href = Nothing
    , name = Nothing
    , rel = Nothing
    , shape = Nothing
    , size = Nothing
    , target = Nothing
    , type_ = Nothing
    , value = Nothing
    , variant = Nothing
    }


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Option msg
disabled val_ =
    M3e.Internal.option (\cfg_ -> { cfg_ | disabled = val_ })


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive : Bool -> Option msg
disabledInteractive val_ =
    M3e.Internal.option (\cfg_ -> { cfg_ | disabledInteractive = val_ })


{-| Whether the toggle button is selected. (default: `false`) -}
selected : Bool -> Option msg
selected val_ =
    M3e.Internal.option (\cfg_ -> { cfg_ | selected = val_ })


{-| Whether the button will toggle between selected and unselected states. (default: `false`) -}
toggle : Bool -> Option msg
toggle val_ =
    M3e.Internal.option (\cfg_ -> { cfg_ | toggle = val_ })


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download : String -> Option msg
download val_ =
    M3e.Internal.option (\cfg_ -> { cfg_ | download = Just val_ })


{-| The URL to which the link button points. (default: `""`) -}
href : String -> Option msg
href val_ =
    M3e.Internal.option (\cfg_ -> { cfg_ | href = Just val_ })


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name : String -> Option msg
name val_ =
    M3e.Internal.option (\cfg_ -> { cfg_ | name = Just val_ })


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> Option msg
rel val_ =
    M3e.Internal.option (\cfg_ -> { cfg_ | rel = Just val_ })


{-| The shape of the button. (default: `"rounded"`) -}
shape : String -> Option msg
shape val_ =
    M3e.Internal.option (\cfg_ -> { cfg_ | shape = Just val_ })


{-| The size of the button. (default: `"small"`) -}
size : String -> Option msg
size val_ =
    M3e.Internal.option (\cfg_ -> { cfg_ | size = Just val_ })


{-| The target of the link button. (default: `""`) -}
target : String -> Option msg
target val_ =
    M3e.Internal.option (\cfg_ -> { cfg_ | target = Just val_ })


{-| The type of the element. (default: `"button"`) -}
type_ : String -> Option msg
type_ val_ =
    M3e.Internal.option (\cfg_ -> { cfg_ | type_ = Just val_ })


{-| The value associated with the element's name when it's submitted with form data. -}
value : String -> Option msg
value val_ =
    M3e.Internal.option (\cfg_ -> { cfg_ | value = Just val_ })


{-| The appearance variant of the button. (default: `"text"`) -}
variant : String -> Option msg
variant val_ =
    M3e.Internal.option (\cfg_ -> { cfg_ | variant = Just val_ })


{-| Build the `<m3e-button>` element. -}
view :
    List (Option msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | button : M3e.Internal.Supported } msg
view options children =
    (\c ->
        M3e.Internal.fromNode
            (M3e.Node.element
                "m3e-button"
                (List.filterMap
                    identity
                    [ Just
                        (M3e.Node.property
                            "disabled"
                            (Json.Encode.bool c.disabled)
                        )
                    , Just
                        (M3e.Node.property
                            "disabledInteractive"
                            (Json.Encode.bool c.disabledInteractive)
                        )
                    , Just
                        (M3e.Node.property
                            "selected"
                            (Json.Encode.bool c.selected)
                        )
                    , Just
                        (M3e.Node.property "toggle" (Json.Encode.bool c.toggle))
                    , Maybe.map (M3e.Node.attribute "download") c.download
                    , Maybe.map (M3e.Node.attribute "href") c.href
                    , Maybe.map (M3e.Node.attribute "name") c.name
                    , Maybe.map (M3e.Node.attribute "rel") c.rel
                    , Maybe.map (M3e.Node.attribute "shape") c.shape
                    , Maybe.map (M3e.Node.attribute "size") c.size
                    , Maybe.map (M3e.Node.attribute "target") c.target
                    , Maybe.map (M3e.Node.attribute "type") c.type_
                    , Maybe.map (M3e.Node.attribute "value") c.value
                    , Maybe.map (M3e.Node.attribute "variant") c.variant
                    ]
                )
                (List.map M3e.Internal.toNode children)
            )
    )
        (M3e.Internal.applyOptions options defaultConfig)