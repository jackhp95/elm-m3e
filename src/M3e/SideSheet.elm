module M3e.SideSheet exposing
    ( Option
    , Side(..)
    , actions
    , body
    , modal
    , onClose
    , open
    , side
    , view
    )

{-| `<m3e-drawer-container>` used as a side sheet — a panel anchored to the
start or end edge of the viewport holding supplementary content (Material 3
Side sheets).

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Renderable any msg) }
    The host's main page content, projected into the drawer
    container's default slot so the element manages open/close
    layout transitions.
  - Options: open, side, modal, onClose, body, actions
  - Slots: start/end (panel body + actions), default (page content)
  - Properties: start or end (Bool DOM property, name depends on `side` option)
    start-mode / end-mode (attribute, "over"|"side")
  - Events: change → onClose (only on the CLOSED transition; see Fix A8)
  - Tag: sideSheet

Note: m3e ships side-sheets via `<m3e-drawer-container>`. There is no
dedicated `<m3e-side-sheet>` element.

**Fix A8** — `onClose` fires only when the drawer CLOSES, not on every
`change` event. The `change` event fires for both opening and closing; the
decoder reads `event.target.end` (or `event.target.start`) and only fires the
message when the relevant property transitions to `false`.

-}

import Cem.M3e.DrawerContainer as Cem
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


{-| Which edge the panel anchors to. Default `End`.
-}
type Side
    = Start
    | End


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


{-| Modal mode (scrim + dismisses on click-outside) vs non-modal (occupies
layout). Modal → `end-mode="over"` (or `start-mode="over"`); non-modal →
`"side"`. Default false (non-modal).
-}
modal : Bool -> Option msg
modal b =
    Internal.option (\c -> { c | modal = b })


{-| Handler fired when the sheet closes (Fix A8: only on the closed
transition, not on every `change` event).
-}
onClose : msg -> Option msg
onClose m =
    Internal.option (\c -> { c | onClose = Just m })


{-| Content for the sheet's panel (rendered into the start/end slot above any
action buttons).
-}
body : List (Renderable any msg) -> Option msg
body xs =
    Internal.option (\c -> { c | body = List.map Renderable.toNode xs })


{-| Action buttons rendered at the bottom of the panel.
-}
actions : List (Renderable { button : Supported } msg) -> Option msg
actions xs =
    Internal.option (\c -> { c | actions = xs })


type alias Config msg =
    { open : Bool
    , side : Side
    , modal : Bool
    , onClose : Maybe msg
    , body : List (Node.Node msg)
    , actions : List (Renderable { button : Supported } msg)
    }


defaultConfig : Config msg
defaultConfig =
    { open = False
    , side = End
    , modal = False
    , onClose = Nothing
    , body = []
    , actions = []
    }


{-| Render the side sheet as an introspectable IR node.

    M3e.SideSheet.view
        { content = [ pageBody ] }
        [ M3e.SideSheet.open state.filtersOpen
        , M3e.SideSheet.side M3e.SideSheet.End
        , M3e.SideSheet.modal True
        , M3e.SideSheet.onClose FiltersClosed
        , M3e.SideSheet.body [ filtersForm ]
        ]

-}
view :
    { content : List (Renderable any msg) }
    -> List (Option msg)
    -> Renderable { s | sideSheet : Supported } msg
view req opts =
    let
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
                :: List.map Renderable.toNode req.content
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


{-| The mode attribute for the correct side (over=modal, side=non-modal).
-}
modeAttr : Config msg -> Node.Attr msg
modeAttr c =
    case c.side of
        Start ->
            Node.rawAttr
                (Cem.startMode
                    (if c.modal then
                        Cem.StartModeOver

                     else
                        Cem.StartModeSide
                    )
                )

        End ->
            Node.rawAttr
                (Cem.endMode
                    (if c.modal then
                        Cem.EndModeOver

                     else
                        Cem.EndModeSide
                    )
                )


{-| Fix A8: decode the `change` event and only fire `msg` when the drawer
just CLOSED (the relevant DOM property is now false). A generic
`Decode.succeed msg` would also fire on opening, which is wrong.
-}
closedDecoder : Side -> msg -> Node.Attr msg
closedDecoder s msg =
    let
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
panelNode : Config msg -> Node.Node msg
panelNode c =
    let
        slotName =
            case c.side of
                Start ->
                    "start"

                End ->
                    "end"
    in
    Node.element "div"
        [ Node.attribute "slot" slotName ]
        (c.body ++ List.map Renderable.toNode c.actions)
