module M3e.Breadcrumb exposing
    ( ItemOption, BreadcrumbOption
    , item, view
    , itemHref, itemCurrent, itemDisabled, itemOnClick, itemTarget, itemRel, itemDownload
    , wrap
    )

{-| `<m3e-breadcrumb>` + `<m3e-breadcrumb-item>` — a hierarchical
navigation trail (Material 3 Breadcrumb).

Spec (per docs/CONVENTIONS.md):

  - Required (parent): { items : List (Renderable { breadcrumbItem : Supported } msg) }
  - Required (child):  { label : String }
               (label = both the visible text child AND the `item-label` attr
               for the internal button's accessible name)
  - Options (parent):  wrap
  - Options (child):   itemHref, itemCurrent, itemDisabled, itemOnClick,
                      itemTarget, itemRel, itemDownload
  - Slots (parent):    default slot ← `m3e-breadcrumb-item` children (strict)
  - Properties:        disabled per item (Node.property); wrap on parent (property)
  - Attrs:             item-label, href, current, target, rel, download
                      (Node.attribute — relational/string attrs, non-property)
  - Tag:               breadcrumb / breadcrumbItem

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


-- ITEM (child) ------------------------------------------------------------

type ItemOption msg
    = ItemHref String
    | ItemCurrent Bool
    | ItemDisabled Bool
    | ItemOnClick msg
    | ItemTarget String
    | ItemRel String
    | ItemDownload String


{-| Set the URL this breadcrumb crumb links to. -}
itemHref : String -> ItemOption msg
itemHref =
    ItemHref


{-| Mark this as the current (active, non-clickable) crumb. Sets
`current="true"` on the element. -}
itemCurrent : Bool -> ItemOption msg
itemCurrent =
    ItemCurrent


{-| Disable this crumb — renders but its internal button is inert. -}
itemDisabled : Bool -> ItemOption msg
itemDisabled =
    ItemDisabled


{-| Wire a click handler for this crumb. -}
itemOnClick : msg -> ItemOption msg
itemOnClick =
    ItemOnClick


{-| Set the link `target` (e.g. `"_blank"`). -}
itemTarget : String -> ItemOption msg
itemTarget =
    ItemTarget


{-| Set the link `rel` (e.g. `"noreferrer noopener"`). -}
itemRel : String -> ItemOption msg
itemRel =
    ItemRel


{-| Request the link target be downloaded; optionally sets the filename. -}
itemDownload : String -> ItemOption msg
itemDownload =
    ItemDownload


type alias ItemConfig msg =
    { href : Maybe String
    , current : Bool
    , disabled : Bool
    , onClick : Maybe msg
    , target : Maybe String
    , rel : Maybe String
    , download : Maybe String
    }


applyItem : ItemOption msg -> ItemConfig msg -> ItemConfig msg
applyItem opt c =
    case opt of
        ItemHref v ->
            { c | href = Just v }

        ItemCurrent b ->
            { c | current = b }

        ItemDisabled b ->
            { c | disabled = b }

        ItemOnClick m ->
            { c | onClick = Just m }

        ItemTarget v ->
            { c | target = Just v }

        ItemRel v ->
            { c | rel = Just v }

        ItemDownload v ->
            { c | download = Just v }


{-| A single `<m3e-breadcrumb-item>`. The `label` is rendered as text
content (the visible crumb label) and also set as the `item-label`
attribute (the internal button's accessible name).
-}
item :
    { label : String }
    -> List (ItemOption msg)
    -> Renderable { s | breadcrumbItem : Supported } msg
item req opts =
    let
        c =
            List.foldl applyItem
                { href = Nothing
                , current = False
                , disabled = False
                , onClick = Nothing
                , target = Nothing
                , rel = Nothing
                , download = Nothing
                }
                opts
    in
    Renderable.fromNode
        (Node.element "m3e-breadcrumb-item"
            (List.filterMap identity
                [ Just (Node.attribute "item-label" req.label)
                , Maybe.map (Node.attribute "href") c.href
                , Maybe.map (Node.attribute "target") c.target
                , Maybe.map (Node.attribute "rel") c.rel
                , Maybe.map (Node.attribute "download") c.download
                , if c.current then
                    Just (Node.attribute "current" "true")

                  else
                    Nothing
                , if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map
                    (\m -> Node.on "click" (Decode.succeed m))
                    c.onClick
                ]
            )
            [ Node.text req.label ]
        )


-- PARENT ------------------------------------------------------------------

type BreadcrumbOption msg
    = Wrap Bool


{-| Allow crumbs to wrap onto a new line when the trail is too wide
(m3e `wrap` property, default false). -}
wrap : Bool -> BreadcrumbOption msg
wrap =
    Wrap


type alias BreadcrumbConfig =
    { wrap : Bool }


applyBreadcrumb : BreadcrumbOption msg -> BreadcrumbConfig -> BreadcrumbConfig
applyBreadcrumb opt c =
    case opt of
        Wrap b ->
            { c | wrap = b }


view :
    { items : List (Renderable { breadcrumbItem : Supported } msg) }
    -> List (BreadcrumbOption msg)
    -> Renderable { s | breadcrumb : Supported } msg
view req opts =
    let
        c =
            List.foldl applyBreadcrumb { wrap = False } opts
    in
    Renderable.fromNode
        (Node.element "m3e-breadcrumb"
            (List.filterMap identity
                [ if c.wrap then
                    Just (Node.property "wrap" (Encode.bool True))

                  else
                    Nothing
                ]
            )
            (List.map Renderable.toNode req.items)
        )
