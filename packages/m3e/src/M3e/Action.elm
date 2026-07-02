module M3e.Action exposing
    ( Action, LinkSpec
    , onClick, link, linkWith, remove
    , toAttrs
    )

{-| A shared capability-typed behavioural value: a component's "what happens"
(click / link / remove) as one field, so href-XOR-onClick is structural. The
`capability` row pins which actions a binding site admits (R5).

@docs Action, LinkSpec
@docs onClick, link, linkWith, remove
@docs toAttrs

-}

import Html.Attributes
import Html.Events
import Json.Decode
import M3e.Cem.Attr as Attr exposing (Attr)
import M3e.Value exposing (Supported)


{-| An opaque behavioural value: exactly one of a click, a link, or a remove.
The `capability` row records which of those a binding site is allowed to carry,
so an action a component does not admit is a type error rather than a no-op.
-}
type Action capability msg
    = Action (Payload msg)


type Payload msg
    = OnClick msg
    | Link LinkSpec
    | Remove msg


{-| The parts of a link action — the `href`, plus the optional `target`, `rel`,
and `download` attributes that qualify it. Build one with [`linkWith`](#linkWith),
or use [`link`](#link) when only the URL matters.
-}
type alias LinkSpec =
    { href : String, target : Maybe String, rel : Maybe String, download : Maybe String }


{-| A click action: emit `msg` when the element is activated.
-}
onClick : msg -> Action { c | click : Supported } msg
onClick m =
    Action (OnClick m)


{-| A link action pointing at `url` (no `target`/`rel`/`download`). For the full
set of link attributes use [`linkWith`](#linkWith).
-}
link : String -> Action { c | link : Supported } msg
link url =
    Action (Link { href = url, target = Nothing, rel = Nothing, download = Nothing })


{-| A link action from a full [`LinkSpec`](#LinkSpec) — use when you need
`target`, `rel`, or `download` alongside the `href`.
-}
linkWith : LinkSpec -> Action { c | link : Supported } msg
linkWith spec =
    Action (Link spec)


{-| A remove action: emit `msg` when the element requests removal (e.g. a
dismissible chip's close affordance).
-}
remove : msg -> Action { c | remove : Supported } msg
remove m =
    Action (Remove m)


{-| The single source of action→DOM wiring.
-}
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
