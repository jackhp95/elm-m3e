module M3e.Tooltip exposing
    ( plain, rich
    , PlainOption, RichOption
    , PlainPosition(..), RichPosition(..)
    , plainId, plainPosition, plainHideDelay
    , richId, richPosition, richHideDelay, richSubhead, richActions
    )

{-| `<m3e-tooltip>` / `<m3e-rich-tooltip>` — short contextual labels anchored
to a control by id (Material 3 Tooltips).

Spec (per docs/CONVENTIONS.md):

  - Two constructors, same `tooltip` tag:
    `plain : { anchorId, label } → List PlainOption → Element { tooltip }`
    → `<m3e-tooltip>`
    `rich  : { anchorId, content } → List RichOption → Element { tooltip }`
    → `<m3e-rich-tooltip>`
  - Required (plain): anchorId (wired via `for` attribute), label text
  - Required (rich): anchorId, content (default-slot children; free row)
  - Options (plain): id, position, hideDelay
  - Options (rich): id, position, hideDelay, subhead (element slot), actions (element slot)
  - Properties: hide-delay (Node.property on both elements)
  - Attrs: for (relational, Node.attribute), position (rawAttr enum)
  - Slots: subhead / actions on rich tooltip (named → element)
  - Tag: tooltip

Relational wiring — the caller gives the anchor control an `id` attribute and
passes the same string to `plain { anchorId = "…" }` / `rich { anchorId = "…" }`.
No Elm state is required for visibility; the element manages show/hide.

@docs plain, rich
@docs PlainOption, RichOption
@docs PlainPosition, RichPosition
@docs plainId, plainPosition, plainHideDelay
@docs richId, richPosition, richHideDelay, richSubhead, richActions

-}

import Cem.M3e.RichTooltip as CemRich
import Cem.M3e.Tooltip as CemPlain
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)



-- TYPES -------------------------------------------------------------------


{-| Tooltip position relative to the anchor element (plain tooltips).
-}
type PlainPosition
    = PlainAbove
    | PlainBelow
    | PlainBefore
    | PlainAfter


{-| Tooltip position relative to the anchor element (rich tooltips; includes
diagonal variants supported by `<m3e-rich-tooltip>`).
-}
type RichPosition
    = RichAbove
    | RichAboveAfter
    | RichAboveBefore
    | RichAfter
    | RichBefore
    | RichBelow
    | RichBelowAfter
    | RichBelowBefore



-- OPTION TYPES ------------------------------------------------------------


{-| An option configuring a plain `<m3e-tooltip>` (build with `plainId`,
`plainPosition`, `plainHideDelay`).
-}
type PlainOption msg
    = PlainId String
    | PlainPosition PlainPosition
    | PlainHideDelay Int


{-| An option configuring a rich `<m3e-rich-tooltip>` (build with `richId`,
`richPosition`, `richHideDelay`, `richSubhead`, `richActions`).
-}
type RichOption msg
    = RichId String
    | RichPosition RichPosition
    | RichHideDelay Int
    | RichSubhead (Element { element : Supported } msg)
    | RichActions (List (Element { element : Supported } msg))



-- SMART CONSTRUCTORS (PLAIN OPTIONS) --------------------------------------


{-| Set the `id` attribute on the `<m3e-tooltip>` element.
-}
plainId : String -> PlainOption msg
plainId =
    PlainId


{-| Set where the plain tooltip appears relative to its anchor.
-}
plainPosition : PlainPosition -> PlainOption msg
plainPosition =
    PlainPosition


{-| Set the hide delay in milliseconds (the `hide-delay` DOM property;
element default 200 ms).
-}
plainHideDelay : Int -> PlainOption msg
plainHideDelay =
    PlainHideDelay



-- SMART CONSTRUCTORS (RICH OPTIONS) ---------------------------------------


{-| Set the `id` attribute on the `<m3e-rich-tooltip>` element.
-}
richId : String -> RichOption msg
richId =
    RichId


{-| Set where the rich tooltip appears relative to its anchor.
-}
richPosition : RichPosition -> RichOption msg
richPosition =
    RichPosition


{-| Set the hide delay in milliseconds (the `hide-delay` DOM property;
element default 200 ms).
-}
richHideDelay : Int -> RichOption msg
richHideDelay =
    RichHideDelay


{-| Set the `subhead` slot content of a rich tooltip (optional header line
above the supporting text).
-}
richSubhead : Element { element : Supported } msg -> RichOption msg
richSubhead =
    RichSubhead


{-| Set the `actions` slot content of a rich tooltip (buttons at the bottom).
-}
richActions : List (Element { element : Supported } msg) -> RichOption msg
richActions =
    RichActions



-- CONSTRUCTORS ------------------------------------------------------------


{-| Construct a plain (single-line text) tooltip (`<m3e-tooltip>`). Anchored
to the element whose `id` matches `anchorId`.

    M3e.Tooltip.plain
        { anchorId = "delete-btn", label = "Delete this row" }
        []

-}
plain :
    { anchorId : String, label : String }
    -> List (PlainOption msg)
    -> Element { s | tooltip : Supported } msg
plain req opts =
    let
        c : PlainConfig
        c =
            List.foldl applyPlain defaultPlainConfig opts
    in
    Internal.fromNode
        (Node.element "m3e-tooltip"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                , Just (Node.attribute "for" req.anchorId)
                , Maybe.map (\p -> Node.rawAttr (CemPlain.position (toCemPlainPosition p))) c.position
                , Maybe.map (\ms -> Node.property "hideDelay" (Encode.float (toFloat ms))) c.hideDelay
                ]
            )
            [ Node.text req.label ]
        )


{-| Construct a rich (multi-line + optional actions) tooltip
(`<m3e-rich-tooltip>`). Anchored to the element whose `id` matches `anchorId`.
The `content` list goes in the default slot; use `richSubhead` and `richActions`
for the named slots.

    M3e.Tooltip.rich
        { anchorId = "status-icon"
        , content = [ Element.html (Html.p [] [ Html.text "More detail here." ]) ]
        }
        [ M3e.Tooltip.richSubhead myTitleElement
        , M3e.Tooltip.richActions [ learnMoreButton ]
        ]

-}
rich :
    { anchorId : String, content : List (Element any msg) }
    -> List (RichOption msg)
    -> Element { s | tooltip : Supported } msg
rich req opts =
    let
        c : RichConfig msg
        c =
            List.foldl applyRich defaultRichConfig opts

        subheadNodes : List (Node msg)
        subheadNodes =
            case c.subhead of
                Nothing ->
                    []

                Just r ->
                    [ Node.withSlot "subhead" (Element.toNode r) ]

        contentNodes : List (Node msg)
        contentNodes =
            List.map Element.toNode req.content

        actionNodes : List (Node msg)
        actionNodes =
            case c.actions of
                [] ->
                    []

                rs ->
                    [ Node.element "div"
                        [ Node.attribute "slot" "actions" ]
                        (List.map Element.toNode rs)
                    ]
    in
    Internal.fromNode
        (Node.element "m3e-rich-tooltip"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                , Just (Node.attribute "for" req.anchorId)
                , Maybe.map (\p -> Node.rawAttr (CemRich.position (toCemRichPosition p))) c.position
                , Maybe.map (\ms -> Node.property "hideDelay" (Encode.float (toFloat ms))) c.hideDelay
                ]
            )
            (subheadNodes ++ contentNodes ++ actionNodes)
        )



-- INTERNAL ----------------------------------------------------------------


type alias PlainConfig =
    { id : Maybe String
    , position : Maybe PlainPosition
    , hideDelay : Maybe Int
    }


defaultPlainConfig : PlainConfig
defaultPlainConfig =
    { id = Nothing, position = Nothing, hideDelay = Nothing }


applyPlain : PlainOption msg -> PlainConfig -> PlainConfig
applyPlain opt c =
    case opt of
        PlainId s ->
            { c | id = Just s }

        PlainPosition p ->
            { c | position = Just p }

        PlainHideDelay ms ->
            { c | hideDelay = Just ms }


type alias RichConfig msg =
    { id : Maybe String
    , position : Maybe RichPosition
    , hideDelay : Maybe Int
    , subhead : Maybe (Element { element : Supported } msg)
    , actions : List (Element { element : Supported } msg)
    }


defaultRichConfig : RichConfig msg
defaultRichConfig =
    { id = Nothing, position = Nothing, hideDelay = Nothing, subhead = Nothing, actions = [] }


applyRich : RichOption msg -> RichConfig msg -> RichConfig msg
applyRich opt c =
    case opt of
        RichId s ->
            { c | id = Just s }

        RichPosition p ->
            { c | position = Just p }

        RichHideDelay ms ->
            { c | hideDelay = Just ms }

        RichSubhead r ->
            { c | subhead = Just r }

        RichActions rs ->
            { c | actions = rs }


toCemPlainPosition : PlainPosition -> CemPlain.Position
toCemPlainPosition p =
    case p of
        PlainAbove ->
            CemPlain.Above

        PlainBelow ->
            CemPlain.Below

        PlainBefore ->
            CemPlain.Before

        PlainAfter ->
            CemPlain.After


toCemRichPosition : RichPosition -> CemRich.Position
toCemRichPosition p =
    case p of
        RichAbove ->
            CemRich.Above

        RichAboveAfter ->
            CemRich.AboveAfter

        RichAboveBefore ->
            CemRich.AboveBefore

        RichAfter ->
            CemRich.After

        RichBefore ->
            CemRich.Before

        RichBelow ->
            CemRich.Below

        RichBelowAfter ->
            CemRich.BelowAfter

        RichBelowBefore ->
            CemRich.BelowBefore
