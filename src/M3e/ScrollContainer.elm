module M3e.ScrollContainer exposing
    ( view
    , Dividers, Option
    , dividers, thin, attributes
    )

{-| `<m3e-scroll-container>` — a vertically scrollable content region
that shows dividers above/below when scrolled (utility element).

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Element any msg) }
    (arbitrary content region — the free row var means this
    cannot live in an Option, so it's in the required record)
  - Options: dividers, thin
  - Slots: default slot ← arbitrary content (free row; `html` escape valid)
  - Properties: thin (Node.property — introspectable/testable)
  - Attrs: dividers (Node.attribute — enum string, non-property)
  - Escape: html (default-slot region)
  - Tag: scrollContainer

@docs view
@docs Dividers, Option
@docs dividers, thin, attributes

-}

import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Value as Value exposing (Value)


{-| Which dividers to show when content is scrolled.
-}
type alias Dividers =
    Value
        { aboveBelow : Supported
        , above : Supported
        , below : Supported
        , none : Supported
        }


{-| An option configuring a scroll container.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Set which dividers appear when content is scrolled
(default `AboveBelow`).
-}
dividers : Dividers -> Option msg
dividers d =
    Internal.option (\c -> { c | dividers = d })


{-| Use thin scrollbars (default false).
-}
thin : Bool -> Option msg
thin b =
    Internal.option (\c -> { c | thin = b })


{-| Escape hatch: add raw attributes to the host element. The host
(`:host { display: block }`) does not stretch on its own, so this is how a
caller gives it a height (`Node.rawAttr (class "h-full")`) or any other
host-level styling.
-}
attributes : List (Node.Attr msg) -> Option msg
attributes attrs =
    Internal.option (\c -> { c | attributes = c.attributes ++ attrs })


type alias Config msg =
    { dividers : Dividers
    , thin : Bool
    , attributes : List (Node.Attr msg)
    }


{-| Render a scroll container wrapping `content` in a vertically scrollable
region that shows dividers above/below when scrolled.
-}
view :
    { content : List (Element any msg) }
    -> List (Option msg)
    -> Element { s | scrollContainer : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts { dividers = Value.aboveBelow, thin = False, attributes = [] }
    in
    Internal.fromNode
        (Node.element "m3e-scroll-container"
            ([ Node.attribute "dividers" (Value.toString c.dividers)
             , Node.property "thin" (Encode.bool c.thin)
             ]
                ++ c.attributes
            )
            (List.map Element.toNode req.content)
        )
