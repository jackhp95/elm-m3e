module M3e.Action exposing (Action, LinkSpec, onClick, link, linkWith, remove, toAttrs)

{-| A shared capability-typed behavioural value: a component's "what happens"
(click / link / remove) as one field, so href-XOR-onClick is structural. The
`capability` row pins which actions a binding site admits (R5). -}

import Html.Attributes
import Html.Events
import Json.Decode
import M3e.Cem.Attr as Attr exposing (Attr)
import M3e.Value exposing (Supported)


type Action capability msg
    = Action (Payload msg)


type Payload msg
    = OnClick msg
    | Link LinkSpec
    | Remove msg


type alias LinkSpec =
    { href : String, target : Maybe String, rel : Maybe String, download : Maybe String }


onClick : msg -> Action { c | click : Supported } msg
onClick m =
    Action (OnClick m)


link : String -> Action { c | link : Supported } msg
link url =
    Action (Link { href = url, target = Nothing, rel = Nothing, download = Nothing })


linkWith : LinkSpec -> Action { c | link : Supported } msg
linkWith spec =
    Action (Link spec)


remove : msg -> Action { c | remove : Supported } msg
remove m =
    Action (Remove m)


{-| The single source of action→DOM wiring. -}
toAttrs : Action capability msg -> List (Attr c msg)
toAttrs (Action payload) =
    case payload of
        OnClick m ->
            [ Attr.attribute (Html.Events.on "click") (Json.Decode.succeed m) ]

        Remove m ->
            [ Attr.attribute (Html.Events.on "remove") (Json.Decode.succeed m) ]

        Link spec ->
            Attr.attribute (Html.Attributes.attribute "href") spec.href
                :: List.filterMap identity
                    [ Maybe.map (Attr.attribute (Html.Attributes.attribute "target")) spec.target
                    , Maybe.map (Attr.attribute (Html.Attributes.attribute "rel")) spec.rel
                    , Maybe.map (Attr.attribute (Html.Attributes.attribute "download")) spec.download
                    ]
