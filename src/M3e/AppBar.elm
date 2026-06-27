module M3e.AppBar exposing
    ( Option, Size(..), Leading, Title, Trailing
    , view
    , id, size, centered, leading, title, subtitle, trailing
    )

{-| `<m3e-app-bar>` — top-of-screen chrome (Material 3 App bars).

Spec (per docs/CONVENTIONS.md):

  - Required: (none — all slots optional)
  - Options: id, size (Small/Medium/Large), centered,
    leading, title, subtitle, trailing
  - Slots:
    leading : Leading (iconButton | element)
    title : Title (heading | element)
    subtitle : Title (heading | element)
    trailing : Trailing (iconButton | search | avatar | element) — list
  - Properties: centered (DOM property)
  - Attrs: size, id
  - Escape: element (all named slots)
  - Tag: appBar

`Trailing`/`Leading`/`Title` accept the spec kinds plus the slot-capable
`element` escape — NOT the raw `html` escape, because a parent must stamp the
`slot=` attribute onto each child, which it can only do to an element. So the
slot can never be silently dropped.


# Types

@docs Option, Size, Leading, Title, Trailing


# View

@docs view


# Options

@docs id, size, centered, leading, title, subtitle, trailing

-}

import Json.Encode as Encode
import M3e.Internal as Internal
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



-- CONFIG -----------------------------------------------------------------


type alias Config msg =
    { id : Maybe String
    , size : Size
    , centered : Bool
    , leading : Maybe (Node msg)
    , title : Maybe (Node msg)
    , subtitle : Maybe (Node msg)
    , trailing : List (Node msg)
    }


{-| An app bar configuration option. Build with the option functions below
and pass a list to [`view`](#view).
-}
type alias Option msg =
    Internal.Option (Config msg) msg


defaultConfig : Config msg
defaultConfig =
    { id = Nothing
    , size = Small
    , centered = False
    , leading = Nothing
    , title = Nothing
    , subtitle = Nothing
    , trailing = []
    }



-- OPTIONS ----------------------------------------------------------------


{-| Set the `id` attribute on the app bar (e.g. so a badge can anchor to it).
-}
id : String -> Option msg
id v =
    Internal.option (\c -> { c | id = Just v })


{-| Set the app bar size (`Small` / `Medium` / `Large`; default `Small`).
-}
size : Size -> Option msg
size s =
    Internal.option (\c -> { c | size = s })


{-| Center the title within the app bar (the `centered` DOM property).
-}
centered : Bool -> Option msg
centered b =
    Internal.option (\c -> { c | centered = b })


{-| Content for the `leading` slot (an icon button or element).
-}
leading : Leading msg -> Option msg
leading item =
    Internal.option (\c -> { c | leading = Just (Node.withSlot "leading" (Renderable.toNode item)) })


{-| Content for the `title` slot (a heading or element).
-}
title : Title msg -> Option msg
title item =
    Internal.option (\c -> { c | title = Just (Node.withSlot "title" (Renderable.toNode item)) })


{-| Content for the `subtitle` slot (a heading or element).
-}
subtitle : Title msg -> Option msg
subtitle item =
    Internal.option (\c -> { c | subtitle = Just (Node.withSlot "subtitle" (Renderable.toNode item)) })


{-| Append items to the `trailing` slot (icon buttons, search, avatar, or
elements). Repeated calls accumulate.
-}
trailing : List (Trailing msg) -> Option msg
trailing items =
    Internal.option
        (\c ->
            { c
                | trailing =
                    c.trailing
                        ++ List.map (Renderable.toNode >> Node.withSlot "trailing") items
            }
        )



-- VIEW -------------------------------------------------------------------


{-| Render the app bar as an introspectable IR node from a list of options.
-}
view : List (Option msg) -> Renderable { s | appBar : Supported } msg
view opts =
    let
        cfg =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-app-bar"
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
