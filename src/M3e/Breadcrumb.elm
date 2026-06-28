module M3e.Breadcrumb exposing
    ( BreadcrumbOption, ItemOption, Current(..)
    , view, wrap
    , item, itemHref, itemCurrent, itemDisabled, itemOnClick, itemTarget, itemRel, itemDownload
    )

{-| `<m3e-breadcrumb>` + `<m3e-breadcrumb-item>` — a hierarchical
navigation trail (Material 3 Breadcrumb).

Spec (per docs/CONVENTIONS.md):

  - Required (parent): { items : List (Element { breadcrumbItem : Supported } msg) }
  - Required (child): { label : String }
    (label = both the visible text child AND the `item-label` attr
    for the internal button's accessible name)
  - Options (parent): wrap
  - Options (child): itemHref, itemCurrent, itemDisabled, itemOnClick,
    itemTarget, itemRel, itemDownload
  - Slots (parent): default slot ← `m3e-breadcrumb-item` children (strict)
  - Properties: disabled per item (Node.property); wrap on parent (property)
  - Attrs: item-label, href, current, target, rel, download
    (Node.attribute — relational/string attrs, non-property)
  - Tag: breadcrumb / breadcrumbItem

Upstream reference: `custom-elements.json` — `m3e-breadcrumb-item`, property
`current`, parsedType `'page' | 'step' | 'location' | 'date' | 'time' | 'true' | undefined`,
default `undefined`.


# Types

@docs BreadcrumbOption, ItemOption, Current


# Parent

@docs view, wrap


# Items

@docs item, itemHref, itemCurrent, itemDisabled, itemOnClick, itemTarget, itemRel, itemDownload

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node



-- ITEM (child) ------------------------------------------------------------


type alias ItemConfig msg =
    { href : Maybe String
    , current : Maybe Current
    , disabled : Bool
    , onClick : Maybe msg
    , target : Maybe String
    , rel : Maybe String
    , download : Maybe String
    }


{-| The aria-current value for a breadcrumb item (upstream `BreadcrumbItemCurrent`).

  - `Page` — marks the current page (`"page"`)
  - `Step` — marks the current step in a multi-step flow (`"step"`)
  - `Location` — marks the current location in a tree or map (`"location"`)
  - `Date` — marks the current date (`"date"`)
  - `Time` — marks the current time (`"time"`)
  - `AriaTrue` — generic "this is current" without a semantic type (`"true"`)

Default: no `current` attribute (matching upstream `undefined`).

-}
type Current
    = Page
    | Step
    | Location
    | Date
    | Time
    | AriaTrue


{-| A configuration option for a single breadcrumb [`item`](#item).
-}
type alias ItemOption msg =
    Internal.Option (ItemConfig msg) msg


{-| Set the URL this breadcrumb crumb links to.
-}
itemHref : String -> ItemOption msg
itemHref v =
    Internal.option (\c -> { c | href = Just v })


{-| Set the aria-current value for this crumb (marks it as the active item in
the trail). Pass one of the [`Current`](#Current) constructors.
Omitting this option leaves the `current` attribute absent (upstream default).
-}
itemCurrent : Current -> ItemOption msg
itemCurrent v =
    Internal.option (\c -> { c | current = Just v })


{-| Disable this crumb — renders but its internal button is inert.
-}
itemDisabled : Bool -> ItemOption msg
itemDisabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Wire a click handler for this crumb.
-}
itemOnClick : msg -> ItemOption msg
itemOnClick m =
    Internal.option (\c -> { c | onClick = Just m })


{-| Set the link `target` (e.g. `"_blank"`).
-}
itemTarget : String -> ItemOption msg
itemTarget v =
    Internal.option (\c -> { c | target = Just v })


{-| Set the link `rel` (e.g. `"noreferrer noopener"`).
-}
itemRel : String -> ItemOption msg
itemRel v =
    Internal.option (\c -> { c | rel = Just v })


{-| Request the link target be downloaded; optionally sets the filename.
-}
itemDownload : String -> ItemOption msg
itemDownload v =
    Internal.option (\c -> { c | download = Just v })


currentToString : Current -> String
currentToString v =
    case v of
        Page ->
            "page"

        Step ->
            "step"

        Location ->
            "location"

        Date ->
            "date"

        Time ->
            "time"

        AriaTrue ->
            "true"


{-| A single `<m3e-breadcrumb-item>`. The `label` is rendered as text
content (the visible crumb label) and also set as the `item-label`
attribute (the internal button's accessible name).
-}
item :
    { label : String }
    -> List (ItemOption msg)
    -> Element { s | breadcrumbItem : Supported } msg
item req opts =
    let
        c : ItemConfig msg
        c =
            Internal.applyOptions opts
                { href = Nothing
                , current = Nothing
                , disabled = False
                , onClick = Nothing
                , target = Nothing
                , rel = Nothing
                , download = Nothing
                }
    in
    Internal.fromNode
        (Node.element "m3e-breadcrumb-item"
            (List.filterMap identity
                [ Just (Node.attribute "item-label" req.label)
                , Maybe.map (Node.attribute "href") c.href
                , Maybe.map (Node.attribute "target") c.target
                , Maybe.map (Node.attribute "rel") c.rel
                , Maybe.map (Node.attribute "download") c.download
                , Maybe.map (\v -> Node.attribute "current" (currentToString v)) c.current
                , Just (Node.property "disabled" (Encode.bool c.disabled))
                , Maybe.map
                    (\m -> Node.on "click" (Decode.succeed m))
                    c.onClick
                ]
            )
            [ Node.text req.label ]
        )



-- PARENT ------------------------------------------------------------------


type alias BreadcrumbConfig =
    { wrap : Bool }


{-| A configuration option for the breadcrumb trail ([`view`](#view)).
-}
type alias BreadcrumbOption msg =
    Internal.Option BreadcrumbConfig msg


{-| Allow crumbs to wrap onto a new line when the trail is too wide
(m3e `wrap` property, default false).
-}
wrap : Bool -> BreadcrumbOption msg
wrap b =
    Internal.option (\c -> { c | wrap = b })


{-| Render the breadcrumb trail wrapping the required `items` (each built with
[`item`](#item)).
-}
view :
    { items : List (Element { breadcrumbItem : Supported } msg) }
    -> List (BreadcrumbOption msg)
    -> Element { s | breadcrumb : Supported } msg
view req opts =
    let
        c : BreadcrumbConfig
        c =
            Internal.applyOptions opts { wrap = False }
    in
    Internal.fromNode
        (Node.element "m3e-breadcrumb"
            [ Node.property "wrap" (Encode.bool c.wrap)
            ]
            (List.map Element.toNode req.items)
        )
