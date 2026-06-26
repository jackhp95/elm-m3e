module M3e.AppBar exposing
    ( AppBar, Trailing, Leading, Title
    , Size(..)
    , new
    , withId, withSize, withCentered
    , withLeading, withTitle, withSubtitle
    , withTrailing
    , toNode
    )

{-| `<m3e-app-bar>` — top-of-screen chrome (Material 3 App bars).

Spec (per docs/CONVENTIONS.md):

  - Required:   (none — all slots optional)
  - Options:    id, size (Small/Medium/Large), centered
  - Slots:
      leading  : Leading  (iconButton | element)
      title    : Title    (heading | element)
      subtitle : Title    (heading | element)
      trailing : Trailing (iconButton | search | avatar | element) — list
  - Properties: centered (DOM property)
  - Attrs:      size, id
  - Escape:     element (all named slots)
  - Tag:        appBar

`Trailing`/`Leading`/`Title` accept the spec kinds plus the slot-capable
`element` escape — NOT the raw `html` escape, because a parent must stamp the
`slot=` attribute onto each child, which it can only do to an element. So the
slot can never be silently dropped.

-}

import Json.Encode as Encode
import M3e.Node as Node exposing (Node)
import M3e.Renderable as Renderable exposing (Renderable, Supported)



-- SLOT PHANTOM TYPES -----------------------------------------------------


{-| Valid children for the `trailing` slot.
-}
type alias Trailing msg =
    Renderable
        { iconButton : Supported
        , search : Supported
        , avatar : Supported
        , element : Supported
        }
        msg


{-| Valid children for the `leading` slot.
-}
type alias Leading msg =
    Renderable
        { iconButton : Supported
        , element : Supported
        }
        msg


{-| Valid children for the `title` and `subtitle` slots.
-}
type alias Title msg =
    Renderable
        { heading : Supported
        , element : Supported
        }
        msg



-- SIZE -------------------------------------------------------------------


{-| App bar size — the `size` attribute (default `Small`).
-}
type Size
    = Small
    | Medium
    | Large



-- BUILDER ----------------------------------------------------------------


type AppBar msg
    = AppBar (Config msg)


type alias Config msg =
    { id : Maybe String
    , size : Size
    , centered : Bool
    , leading : Maybe (Node msg)
    , title : Maybe (Node msg)
    , subtitle : Maybe (Node msg)
    , trailing : List (Node msg)
    }


new : AppBar msg
new =
    AppBar
        { id = Nothing
        , size = Small
        , centered = False
        , leading = Nothing
        , title = Nothing
        , subtitle = Nothing
        , trailing = []
        }


withId : String -> AppBar msg -> AppBar msg
withId id (AppBar cfg) =
    AppBar { cfg | id = Just id }


withSize : Size -> AppBar msg -> AppBar msg
withSize s (AppBar cfg) =
    AppBar { cfg | size = s }


withCentered : Bool -> AppBar msg -> AppBar msg
withCentered b (AppBar cfg) =
    AppBar { cfg | centered = b }


withLeading : Leading msg -> AppBar msg -> AppBar msg
withLeading item (AppBar cfg) =
    AppBar { cfg | leading = Just (Node.withSlot "leading" (Renderable.toNode item)) }


withTitle : Title msg -> AppBar msg -> AppBar msg
withTitle item (AppBar cfg) =
    AppBar { cfg | title = Just (Node.withSlot "title" (Renderable.toNode item)) }


withSubtitle : Title msg -> AppBar msg -> AppBar msg
withSubtitle item (AppBar cfg) =
    AppBar { cfg | subtitle = Just (Node.withSlot "subtitle" (Renderable.toNode item)) }


withTrailing : List (Trailing msg) -> AppBar msg -> AppBar msg
withTrailing items (AppBar cfg) =
    AppBar
        { cfg
            | trailing =
                cfg.trailing
                    ++ List.map (Renderable.toNode >> Node.withSlot "trailing") items
        }


toNode : AppBar msg -> Node msg
toNode (AppBar cfg) =
    Node.element "m3e-app-bar"
        (List.filterMap identity
            [ Maybe.map (Node.attribute "id") cfg.id
            , Just (Node.attribute "size" (sizeString cfg.size))
            , if cfg.centered then
                Just (Node.property "centered" (Encode.bool True))

              else
                Nothing
            ]
        )
        (List.filterMap identity
            [ cfg.leading
            , cfg.title
            , cfg.subtitle
            ]
            ++ cfg.trailing
        )


sizeString : Size -> String
sizeString s =
    case s of
        Small ->
            "small"

        Medium ->
            "medium"

        Large ->
            "large"
