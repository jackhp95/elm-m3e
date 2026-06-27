module M3e.Search exposing
    ( Option
    , clearLabel
    , clearable
    , leadingIcon
    , onClear
    , onInput
    , trailingIcon
    , value
    , view
    )

{-| `<m3e-search-bar>` — a Material 3 Search bar.

Spec (per docs/CONVENTIONS.md):

  - Required: { placeholder : String }
  - Options: onInput, value, clearable, clearLabel, onClear,
    leadingIcon, trailingIcon
  - Slots:
    leading : Renderable { icon : Supported } (via leadingIcon option)
    input : always rendered as <input type=search slot=input>
    trailing : Renderable { icon : Supported } (via trailingIcon option)
  - Properties: clearable (DOM property)
  - Attrs: clear-label
  - Events: input (onInput), clear (onClear)
  - Escape: none (leaf — slots are option-driven, not caller-supplied nodes)
  - Tag: search

Note: `placeholder` goes on the `<input>` child, not the bar root, per the CEM
slot contract. The root element is still `m3e-search-bar`, so a parent
`Node.setAttribute "id"` (e.g. `M3e.Field`) continues to work.

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)
import M3e.Renderable as Renderable exposing (Renderable, Supported)



-- OPTIONS ----------------------------------------------------------------


type alias Option msg =
    Internal.Option (Config msg) msg


onInput : (String -> msg) -> Option msg
onInput f =
    Internal.option (\c -> { c | onInput = Just f })


value : String -> Option msg
value v =
    Internal.option (\c -> { c | value = Just v })


clearable : Bool -> Option msg
clearable b =
    Internal.option (\c -> { c | clearable = b })


clearLabel : String -> Option msg
clearLabel v =
    Internal.option (\c -> { c | clearLabel = Just v })


onClear : msg -> Option msg
onClear m =
    Internal.option (\c -> { c | onClear = Just m })


leadingIcon : Renderable { icon : Supported } msg -> Option msg
leadingIcon i =
    Internal.option (\c -> { c | leadingIcon = Just i })


trailingIcon : Renderable { icon : Supported } msg -> Option msg
trailingIcon i =
    Internal.option (\c -> { c | trailingIcon = Just i })



-- CONFIG -----------------------------------------------------------------


type alias Config msg =
    { onInput : Maybe (String -> msg)
    , value : Maybe String
    , clearable : Bool
    , clearLabel : Maybe String
    , onClear : Maybe msg
    , leadingIcon : Maybe (Renderable { icon : Supported } msg)
    , trailingIcon : Maybe (Renderable { icon : Supported } msg)
    }


defaults : Config msg
defaults =
    { onInput = Nothing
    , value = Nothing
    , clearable = False
    , clearLabel = Nothing
    , onClear = Nothing
    , leadingIcon = Nothing
    , trailingIcon = Nothing
    }



-- VIEW -------------------------------------------------------------------


view : { placeholder : String } -> List (Option msg) -> Renderable { s | search : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts defaults
    in
    Internal.fromNode
        (Node.element "m3e-search-bar"
            (List.filterMap identity
                [ if c.clearable then
                    Just (Node.property "clearable" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map (Node.attribute "clear-label") c.clearLabel
                , Maybe.map (\m -> Node.on "clear" (Decode.succeed m)) c.onClear
                ]
            )
            (List.filterMap identity
                [ Maybe.map (\i -> Node.withSlot "leading" (Renderable.toNode i)) c.leadingIcon
                , Just (inputElement req.placeholder c)
                , Maybe.map (\i -> Node.withSlot "trailing" (Renderable.toNode i)) c.trailingIcon
                ]
            )
        )


inputElement : String -> Config msg -> Node msg
inputElement placeholder c =
    Node.element "input"
        (List.filterMap identity
            [ Just (Node.attribute "slot" "input")
            , Just (Node.attribute "type" "search")
            , Just (Node.attribute "placeholder" placeholder)
            , Maybe.map (Node.attribute "value") c.value
            , Maybe.map
                (\f ->
                    Node.on "input"
                        (Decode.at [ "target", "value" ] Decode.string
                            |> Decode.map f
                        )
                )
                c.onInput
            ]
        )
        []
