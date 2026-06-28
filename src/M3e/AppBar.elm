module M3e.AppBar exposing
    ( Option, Size(..), Leading, Title, Trailing
    , view
    , id, for, size, centered, leading, title, subtitle, trailing
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

@docs view


# Options

@docs id, for, size, centered, leading, title, subtitle, trailing

-}

import Cem.M3e.AppBar as Cem
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)



-- SLOT PHANTOM TYPES -----------------------------------------------------


{-| Valid children for the `trailing` slot.
-}
type alias Trailing msg =
    Element
        { iconButton : Supported
        , search : Supported
        , avatar : Supported
        , element : Supported
        }
        msg


{-| Valid children for the `leading` slot.
-}
type alias Leading msg =
    Element
        { iconButton : Supported
        , element : Supported
        }
        msg


{-| Valid children for the `title` and `subtitle` slots.
-}
type alias Title msg =
    Element
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
    , for : Maybe String
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
    , for = Nothing
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


{-| Attach the app bar to a scrollable container. The `for` value is the `id`
of the element to observe; as it scrolls, the bar gains elevation.

Upstream: `for` attribute on `<m3e-app-bar>`. CEM field: `htmlFor`.

-}
for : String -> Option msg
for v =
    Internal.option (\c -> { c | for = Just v })


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
    Internal.option (\c -> { c | leading = Just (Node.withSlot "leading" (Element.toNode item)) })


{-| Content for the `title` slot (a heading or element).
-}
title : Title msg -> Option msg
title item =
    Internal.option (\c -> { c | title = Just (Node.withSlot "title" (Element.toNode item)) })


{-| Content for the `subtitle` slot (a heading or element).
-}
subtitle : Title msg -> Option msg
subtitle item =
    Internal.option (\c -> { c | subtitle = Just (Node.withSlot "subtitle" (Element.toNode item)) })


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
                        ++ List.map (Element.toNode >> Node.withSlot "trailing") items
            }
        )



-- VIEW -------------------------------------------------------------------


{-| Render the app bar as an introspectable IR node from a list of options.
-}
view : List (Option msg) -> Element { s | appBar : Supported } msg
view opts =
    let
        cfg : Config msg
        cfg =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-app-bar"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") cfg.id
                , Maybe.map (Node.attribute "for") cfg.for
                , Just (Node.attribute "size" (Cem.sizeToString (toCemSize cfg.size)))
                , Just (Node.property "centered" (Encode.bool cfg.centered))
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


toCemSize : Size -> Cem.Size
toCemSize s =
    case s of
        Small ->
            Cem.Small

        Medium ->
            Cem.Medium

        Large ->
            Cem.Large
