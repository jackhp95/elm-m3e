module M3e.Badge exposing
    ( Option
    , Position(..)
    , count
    , dot
    , forId
    , label
    , position
    , view
    )

{-| `<m3e-badge>` — a compact count, dot, or status label attached to a control.

Spec (per docs/CONVENTIONS.md):

  - Required: none — a badge has no required accessible name; its anchor
    (`forId`) is optional and its content is chosen via options.
  - Options: dot, count, label (content type — last-write-wins), position, forId
  - Slots: default slot ← text content (for count / label variants)
  - Properties: none (badge has no boolean DOM properties)
  - Attrs: size (string enum, RawAttr — set automatically from content type)
    position (string enum, RawAttr)
    for (introspectable Node.attribute — relational, links badge to a control)
  - Escape: none (leaf with text content)
  - Tag: m3e-badge

M3 recognises exactly two badge types:

  - **small** (dot) — shape only, no text content. `dot` option sets size="small".
  - **large** (count/label) — carries text. `count` and `label` set size="large".

The `count` option applies M3's 999+ truncation: values above 999 render as
`"999+"` (capped at 4 characters including the `+`).

-}

import Cem.M3e.Badge as Cem
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


{-| Where the badge sits relative to its anchor element (`forId`).
Mirrors the m3e-badge `position` enum. Default `AboveAfter`.
-}
type Position
    = Above
    | AboveAfter
    | AboveBefore
    | After
    | Before
    | Below
    | BelowAfter
    | BelowBefore


type alias Option msg =
    Internal.Option Config msg


{-| A small, shape-only badge (no content) — the M3 "small" type.
-}
dot : Option msg
dot =
    Internal.option (\c -> { c | content = DotContent })


{-| A large numeric badge. Applies the M3 "999+" truncation: counts above 999
render as `"999+"` (the spec caps the badge at 4 characters including the `+`).
-}
count : Int -> Option msg
count n =
    Internal.option (\c -> { c | content = CountContent n })


{-| A large badge displaying short status text — the M3 "large" type.
-}
label : String -> Option msg
label s =
    Internal.option (\c -> { c | content = LabelContent s })


{-| Set where the badge sits relative to its anchor (default `AboveAfter`).
Only meaningful when `forId` is also set.
-}
position : Position -> Option msg
position p =
    Internal.option (\c -> { c | position = Just p })


{-| Anchor the badge to the interactive control with the given id (the m3e
`for` attribute). Emitted as an introspectable `Node.attribute` so parents
can read the relational wiring.
-}
forId : String -> Option msg
forId s =
    Internal.option (\c -> { c | for = Just s })


type Content
    = NoneContent
    | DotContent
    | CountContent Int
    | LabelContent String


type alias Config =
    { content : Content
    , position : Maybe Position
    , for : Maybe String
    }


view : List (Option msg) -> Renderable { s | badge : Supported } msg
view opts =
    let
        c =
            Internal.applyOptions opts
                { content = NoneContent
                , position = Nothing
                , for = Nothing
                }

        ( sizeAttr, children ) =
            case c.content of
                NoneContent ->
                    ( Nothing, [] )

                DotContent ->
                    ( Just (Node.rawAttr (Cem.size Cem.Small)), [] )

                CountContent n ->
                    ( Just (Node.rawAttr (Cem.size Cem.Large)), [ Node.text (countLabel n) ] )

                LabelContent s ->
                    ( Just (Node.rawAttr (Cem.size Cem.Large)), [ Node.text s ] )
    in
    Internal.fromNode
        (Node.element "m3e-badge"
            (List.filterMap identity
                [ sizeAttr
                , Maybe.map (\p -> Node.rawAttr (Cem.position (toCemPosition p))) c.position
                , Maybe.map (Node.attribute "for") c.for
                ]
            )
            children
        )


countLabel : Int -> String
countLabel n =
    if n > 999 then
        "999+"

    else
        String.fromInt n


toCemPosition : Position -> Cem.Position
toCemPosition p =
    case p of
        Above ->
            Cem.Above

        AboveAfter ->
            Cem.AboveAfter

        AboveBefore ->
            Cem.AboveBefore

        After ->
            Cem.After

        Before ->
            Cem.Before

        Below ->
            Cem.Below

        BelowAfter ->
            Cem.BelowAfter

        BelowBefore ->
            Cem.BelowBefore
