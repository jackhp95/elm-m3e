module M3e.SideSheet exposing
    ( Option, Side(..), Mode
    , view
    , open, side, mode, onClose, body, actions
    )

{-| `<m3e-drawer-container>` used as a side sheet — a panel anchored to the
start or end edge of the viewport holding supplementary content (Material 3
Side sheets).

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Element any msg) }
    The host's main page content, projected into the drawer
    container's default slot so the element manages open/close
    layout transitions.
  - Options: open, side, mode, onClose, body, actions
  - Slots: start/end (panel body + actions), default (page content)
  - Properties: start or end (Bool DOM property, name depends on `side` option)
    start-mode / end-mode (attribute, upstream DrawerMode enum)
  - Events: change → onClose (only on the CLOSED transition; see Fix A8)
  - Tag: sideSheet

Note: m3e ships side-sheets via `<m3e-drawer-container>`. There is no
dedicated `<m3e-side-sheet>` element.

Upstream reference: `custom-elements.json` — `m3e-drawer-container`,
properties `startMode` / `endMode`, parsedType `'auto' | 'over' | 'push' | 'side'`,
default `"side"`.

**Fix A8** — `onClose` fires only when the drawer CLOSES, not on every
`change` event. The `change` event fires for both opening and closing; the
decoder reads `event.target.end` (or `event.target.start`) and only fires the
message when the relevant property transitions to `false`.

@docs Option, Side, Mode
@docs view
@docs open, side, mode, onClose, body, actions

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)
import M3e.Value as Value exposing (Value)


{-| Which edge the panel anchors to. Default `End`.
-}
type Side
    = Start
    | End


{-| Drawer behaviour mode (upstream `DrawerMode`), supplied as shared
[`M3e.Value`](M3e-Value) tokens.

  - [`side`](M3e-Value#side) — the drawer occupies layout space beside the
    content (default).
  - [`over`](M3e-Value#over) — the drawer overlays content with a scrim.
  - [`push`](M3e-Value#push) — the drawer pushes content aside without a scrim.
  - [`auto`](M3e-Value#auto) — the browser chooses `side` or `over` based on
    viewport.

-}
type alias Mode =
    Value
        { side : Supported
        , over : Supported
        , push : Supported
        , auto : Supported
        }


{-| Configuration option for the side sheet, built by the helpers below.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Whether the side sheet is open. Maps to the `start` or `end` DOM property
(depending on the `side` option). Default false.
-}
open : Bool -> Option msg
open b =
    Internal.option (\c -> { c | open = b })


{-| Which edge the sheet anchors to. Default `End`.
-}
side : Side -> Option msg
side s =
    Internal.option (\c -> { c | side = s })


{-| Drawer behaviour mode. Default [`side`](M3e-Value#side).

Use [`over`](M3e-Value#over) for a modal-style overlay with a scrim;
[`push`](M3e-Value#push) to push content aside without a scrim;
[`auto`](M3e-Value#auto) to let the browser decide.

-}
mode : Mode -> Option msg
mode m =
    Internal.option (\c -> { c | mode = m })


{-| Handler fired when the sheet closes (Fix A8: only on the closed
transition, not on every `change` event).
-}
onClose : msg -> Option msg
onClose m =
    Internal.option (\c -> { c | onClose = Just m })


{-| Content for the sheet's panel (rendered into the start/end slot above any
action buttons).
-}
body : List (Element any msg) -> Option msg
body xs =
    Internal.option (\c -> { c | body = List.map Element.toNode xs })


{-| Action buttons rendered at the bottom of the panel.
-}
actions : List (Element { button : Supported } msg) -> Option msg
actions xs =
    Internal.option (\c -> { c | actions = xs })


type alias Config msg =
    { open : Bool
    , side : Side
    , mode : Mode
    , onClose : Maybe msg
    , body : List (Node msg)
    , actions : List (Element { button : Supported } msg)
    }


defaultConfig : Config msg
defaultConfig =
    { open = False
    , side = End
    , mode = Value.side
    , onClose = Nothing
    , body = []
    , actions = []
    }


{-| Render the side sheet as an introspectable IR node.

    M3e.SideSheet.view
        { content = [ pageBody ] }
        [ M3e.SideSheet.open state.filtersOpen
        , M3e.SideSheet.side M3e.SideSheet.End
        , M3e.SideSheet.mode M3e.Value.over
        , M3e.SideSheet.onClose FiltersClosed
        , M3e.SideSheet.body [ filtersForm ]
        ]

-}
view :
    { content : List (Element any msg) }
    -> List (Option msg)
    -> Element { s | sideSheet : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-drawer-container"
            (List.filterMap identity
                [ Just (openProperty c)
                , Just (modeAttr c)
                , Maybe.map (closedDecoder c.side) c.onClose
                ]
            )
            (panelNode c
                :: List.map Element.toNode req.content
            )
        )


{-| The open/closed DOM property for the correct side.
-}
openProperty : Config msg -> Node.Attr msg
openProperty c =
    case c.side of
        Start ->
            Node.property "start" (Encode.bool c.open)

        End ->
            Node.property "end" (Encode.bool c.open)


{-| The mode attribute for the correct side.
-}
modeAttr : Config msg -> Node.Attr msg
modeAttr c =
    case c.side of
        Start ->
            Node.attribute "start-mode" (Value.toString c.mode)

        End ->
            Node.attribute "end-mode" (Value.toString c.mode)


{-| Fix A8: decode the `change` event and only fire `msg` when the drawer
just CLOSED (the relevant DOM property is now false). A generic
`Decode.succeed msg` would also fire on opening, which is wrong.
-}
closedDecoder : Side -> msg -> Node.Attr msg
closedDecoder s msg =
    let
        prop : String
        prop =
            case s of
                Start ->
                    "start"

                End ->
                    "end"
    in
    Node.on "change"
        (Decode.at [ "target", prop ] Decode.bool
            |> Decode.andThen
                (\isOpen ->
                    if isOpen then
                        Decode.fail "drawer opened — skip"

                    else
                        Decode.succeed msg
                )
        )


{-| The panel node slotted into the start or end drawer slot.
-}
panelNode : Config msg -> Node msg
panelNode c =
    let
        slotName : String
        slotName =
            case c.side of
                Start ->
                    "start"

                End ->
                    "end"
    in
    Node.element "div"
        [ Node.attribute "slot" slotName ]
        (c.body ++ List.map Element.toNode c.actions)
