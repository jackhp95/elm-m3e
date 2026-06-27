module M3e.Slide exposing
    ( view, slideGroup
    , Option, SlideGroupOption
    , selectedIndex
    , disabled, vertical, threshold, nextPageLabel, previousPageLabel, nextIcon, prevIcon
    )

{-| `<m3e-slide>` standalone carousel and `<m3e-slide-group>` scroll wrapper.

These are independent elements:

  - `<m3e-slide>` is a **carousel** — it cycles through slotted items and the
    visible one is controlled by `selected-index`. Use `view` to render it.
  - `<m3e-slide-group>` is a **scroll wrapper** with directional pagination
    controls that appear when content overflows. Use `slideGroup` to render it.
    Its default slot accepts arbitrary content — there is no parent-child typing
    constraint between `<m3e-slide>` and `<m3e-slide-group>`.

Spec (per docs/CONVENTIONS.md):

  - `view` — `<m3e-slide>` carousel; `selectedIndex` is the primary control
  - `slideGroup` — `<m3e-slide-group>` scroll wrapper; content is untyped
  - Slots: `view` default ← carousel items; `slideGroup` default ← content,
    `next-icon` / `prev-icon` ← icon elements via `nextIcon`/`prevIcon`
  - Properties: all configurable state via DOM property (introspectable)
  - Tag: slide (module tag for `view`); slideGroup for `slideGroup`


## Views

@docs view, slideGroup


## Types

@docs Option, SlideGroupOption


## Carousel options (`view` / `m3e-slide`)

@docs selectedIndex


## Scroll-group options (`slideGroup` / `m3e-slide-group`)

@docs disabled, vertical, threshold, nextPageLabel, previousPageLabel, nextIcon, prevIcon

-}

import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| Configuration option for the `<m3e-slide>` carousel (built by `selectedIndex`).
-}
type alias Option msg =
    Internal.Option SlideConfig msg


{-| Configuration option for the `<m3e-slide-group>` wrapper.
-}
type alias SlideGroupOption msg =
    Internal.Option (SlideGroupConfig msg) msg


{-| Set the zero-based index of the visible carousel item (`selected-index`
DOM property).

This is the primary control for `<m3e-slide>`. Without it the carousel renders
but does not advance — `selected-index` defaults to `null` in the element, which
leaves it inert.

-}
selectedIndex : Int -> Option msg
selectedIndex i =
    Internal.option (\c -> { c | selectedIndex = Just i })


{-| Disable the pagination buttons of a `<m3e-slide-group>` (content still
renders, controls go inert).
-}
disabled : Bool -> SlideGroupOption msg
disabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Set vertical orientation for a `<m3e-slide-group>` — content flows
top-to-bottom (default: false).
-}
vertical : Bool -> SlideGroupOption msg
vertical b =
    Internal.option (\c -> { c | vertical = b })


{-| Scroll threshold in pixels for a `<m3e-slide-group>` at which the
pagination controls begin to show (default: 0).
-}
threshold : Float -> SlideGroupOption msg
threshold px =
    Internal.option (\c -> { c | threshold = Just px })


{-| Set the accessible label for the "next page" button in a `<m3e-slide-group>`
(default: `"Next page"`).
-}
nextPageLabel : String -> SlideGroupOption msg
nextPageLabel s =
    Internal.option (\c -> { c | nextPageLabel = Just s })


{-| Set the accessible label for the "previous page" button in a
`<m3e-slide-group>` (default: `"Previous page"`).
-}
previousPageLabel : String -> SlideGroupOption msg
previousPageLabel s =
    Internal.option (\c -> { c | previousPageLabel = Just s })


{-| Provide a custom icon element for the "next" button in a `<m3e-slide-group>`.
The element is injected into the `next-icon` slot.
-}
nextIcon : Element { element : Supported } msg -> SlideGroupOption msg
nextIcon el =
    Internal.option (\c -> { c | nextIcon = Just el })


{-| Provide a custom icon element for the "previous" button in a
`<m3e-slide-group>`. The element is injected into the `prev-icon` slot.
-}
prevIcon : Element { element : Supported } msg -> SlideGroupOption msg
prevIcon el =
    Internal.option (\c -> { c | prevIcon = Just el })



-- VIEWS -------------------------------------------------------------------


{-| Render an `<m3e-slide>` standalone carousel. Items in the list become the
carousel's slotted content; `selectedIndex` controls which one is visible.

    M3e.Slide.view
        { items =
            [ myCard1
            , myCard2
            , myCard3
            ]
        }
        [ M3e.Slide.selectedIndex model.slideIndex ]

-}
view :
    { items : List (Element any msg) }
    -> List (Option msg)
    -> Element { s | slide : Supported } msg
view req opts =
    let
        c : SlideConfig
        c =
            Internal.applyOptions opts { selectedIndex = Nothing }
    in
    Internal.fromNode
        (Node.element "m3e-slide"
            (List.filterMap identity
                [ Maybe.map
                    (\i -> Node.property "selected-index" (Encode.float (toFloat i)))
                    c.selectedIndex
                ]
            )
            (List.map Element.toNode req.items)
        )


{-| Render an `<m3e-slide-group>` scroll wrapper with directional pagination
controls. The group's default slot accepts arbitrary content — no parent-child
typing is imposed. Pagination buttons appear once content overflows past the
`threshold`.

    M3e.Slide.slideGroup
        { content = myScrollableItems }
        [ M3e.Slide.threshold 48
        , M3e.Slide.nextPageLabel "Scroll right"
        , M3e.Slide.previousPageLabel "Scroll left"
        ]

-}
slideGroup :
    { content : List (Element any msg) }
    -> List (SlideGroupOption msg)
    -> Element { s | slideGroup : Supported } msg
slideGroup req opts =
    let
        c : SlideGroupConfig msg
        c =
            Internal.applyOptions opts defaultSlideGroupConfig
    in
    Internal.fromNode
        (Node.element "m3e-slide-group"
            (List.filterMap identity
                [ Just (Node.property "disabled" (Encode.bool c.disabled))
                , Just (Node.property "vertical" (Encode.bool c.vertical))
                , Maybe.map (\px -> Node.property "threshold" (Encode.float px)) c.threshold
                , Maybe.map (Node.attribute "next-page-label") c.nextPageLabel
                , Maybe.map (Node.attribute "previous-page-label") c.previousPageLabel
                ]
            )
            (List.filterMap identity
                [ Maybe.map
                    (\el -> Node.withSlot "next-icon" (Element.toNode el))
                    c.nextIcon
                , Maybe.map
                    (\el -> Node.withSlot "prev-icon" (Element.toNode el))
                    c.prevIcon
                ]
                ++ List.map Element.toNode req.content
            )
        )



-- INTERNAL ----------------------------------------------------------------


type alias SlideConfig =
    { selectedIndex : Maybe Int
    }


type alias SlideGroupConfig msg =
    { disabled : Bool
    , vertical : Bool
    , threshold : Maybe Float
    , nextPageLabel : Maybe String
    , previousPageLabel : Maybe String
    , nextIcon : Maybe (Element { element : Supported } msg)
    , prevIcon : Maybe (Element { element : Supported } msg)
    }


defaultSlideGroupConfig : SlideGroupConfig msg
defaultSlideGroupConfig =
    { disabled = False
    , vertical = False
    , threshold = Nothing
    , nextPageLabel = Nothing
    , previousPageLabel = Nothing
    , nextIcon = Nothing
    , prevIcon = Nothing
    }
