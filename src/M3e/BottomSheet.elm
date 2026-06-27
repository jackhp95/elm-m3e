module M3e.BottomSheet exposing
    ( Option
    , view
    , open, onClose
    , handle, hideable, modal
    , header, actions
    )

{-| `<m3e-bottom-sheet>` — a surface that slides up from the bottom of the
viewport (Material 3 Bottom sheets).

Spec (per docs/CONVENTIONS.md):

  - Required:   { content : List (Renderable any msg) }
                (default slot body region — free row, may include html escape)
  - Options:    open, onClose, handle, hideable, modal, header, actions
  - Slots:      header (<div slot="header"> wrapping the header content)
                default (content region, no slot injection)
                actions (each action button has m3e-bottom-sheet-action nested
                INSIDE it — see Fix F12 below)
  - Properties: open, handle, hideable, modal (all Bool DOM properties)
  - Events:     closed → onClose; cancel → onClose
  - Tag:        bottomSheet

**Fix F12** — The `m3e-bottom-sheet-action` sentinel element goes INSIDE each
action button (the button closes the parent sheet when activated). Ui.BottomSheet
previously had a bug where the action was positioned outside/wrapping the button.
Here each action `Renderable { button }` has the sentinel injected as a child of
its rendered element node before it lands in the DOM.

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.Internal as Internal


type alias Option msg =
    Internal.Option (Config msg) msg


{-| Whether the bottom sheet is open. Sets the `open` DOM property. Default false. -}
open : Bool -> Option msg
open b =
    Internal.option (\c -> { c | open = b })


{-| Handler for user-initiated dismiss. Wired to both the `closed` and `cancel`
events.
-}
onClose : msg -> Option msg
onClose m =
    Internal.option (\c -> { c | onClose = Just m })


{-| Show the drag handle at the top of the sheet. Default false. -}
handle : Bool -> Option msg
handle b =
    Internal.option (\c -> { c | handle = b })


{-| Allow the user to dismiss the sheet by dragging it down. Default false. -}
hideable : Bool -> Option msg
hideable b =
    Internal.option (\c -> { c | hideable = b })


{-| Make the sheet modal (shows a scrim behind it). Default false. -}
modal : Bool -> Option msg
modal b =
    Internal.option (\c -> { c | modal = b })


{-| Content for the sheet's `header` slot — rendered above the body region. -}
header : List (Renderable any msg) -> Option msg
header xs =
    Internal.option (\c -> { c | header = List.map Renderable.toNode xs })


{-| Action buttons. Each button will have `<m3e-bottom-sheet-action>` nested
inside it (Fix F12), so activating the button closes the parent sheet.
-}
actions : List (Renderable { button : Supported } msg) -> Option msg
actions xs =
    Internal.option (\c -> { c | actions = xs })


type alias Config msg =
    { open : Bool
    , onClose : Maybe msg
    , handle : Bool
    , hideable : Bool
    , modal : Bool
    , header : List (Node.Node msg)
    , actions : List (Renderable { button : Supported } msg)
    }


defaultConfig : Config msg
defaultConfig =
    { open = False
    , onClose = Nothing
    , handle = False
    , hideable = False
    , modal = False
    , header = []
    , actions = []
    }


{-| Render the bottom sheet as an introspectable IR node.

    M3e.BottomSheet.view
        { content = [ detailsContent ] }
        [ M3e.BottomSheet.open state.open
        , M3e.BottomSheet.onClose SheetClosed
        , M3e.BottomSheet.modal True
        , M3e.BottomSheet.actions
            [ M3e.Button.view { label = "Share", variant = M3e.Button.Tonal } [] ]
        ]

-}
view :
    { content : List (Renderable any msg) }
    -> List (Option msg)
    -> Renderable { s | bottomSheet : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-bottom-sheet"
            (List.filterMap identity
                [ Just (Node.property "open" (Encode.bool c.open))
                , if c.handle then
                    Just (Node.property "handle" (Encode.bool True))

                  else
                    Nothing
                , if c.hideable then
                    Just (Node.property "hideable" (Encode.bool True))

                  else
                    Nothing
                , if c.modal then
                    Just (Node.property "modal" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map (\m -> Node.on "closed" (Decode.succeed m)) c.onClose
                , Maybe.map (\m -> Node.on "cancel" (Decode.succeed m)) c.onClose
                ]
            )
            (List.concat
                [ case c.header of
                    [] ->
                        []

                    hs ->
                        [ Node.element "div" [ Node.attribute "slot" "header" ] hs ]
                , List.map Renderable.toNode req.content
                , List.map (injectSheetAction << Renderable.toNode) c.actions
                ]
            )
        )


{-| Fix F12: inject `<m3e-bottom-sheet-action>` as a child of the button's
rendered node, so it lives INSIDE the button element. The sentinel tells the
parent `m3e-bottom-sheet` to close when the button is activated. Handles only
`Element` nodes; Text/Raw nodes pass through unchanged (degenerate but safe).
-}
injectSheetAction : Node.Node msg -> Node.Node msg
injectSheetAction node =
    case node of
        Node.Element el ->
            Node.Element
                { el
                    | children =
                        el.children
                            ++ [ Node.element "m3e-bottom-sheet-action" [] [] ]
                }

        _ ->
            node
