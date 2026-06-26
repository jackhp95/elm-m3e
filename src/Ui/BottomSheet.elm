module Ui.BottomSheet exposing
    ( BottomSheet
    , new
    , withAttributes
    , withId, withHeader, withBody, withActions, withHandle, withHideable, withModal
    , withDetents, withHideFriction, withOvershootLimit
    , view
    )

{-| Typed builder for `<m3e-bottom-sheet>` — a surface that slides up
from the bottom of the viewport. Mirrors the Material 3
[Bottom sheets][m3] surface.

[m3]: https://m3.material.io/components/bottom-sheets/overview

Bottom sheets are most useful on small viewports for action menus,
detail panes, or task workflows. Use a `Ui.Dialog` for desktop-centric
modal flows.


# Open state is caller-owned

Same shape as `Ui.Dialog`: pass `open : Bool`, supply an `onClose`
handler. Rendering is pure — the `open` attribute drives the element,
and the element's `closed`/`cancel` events are wired back to `onClose`.


# Required-by-design

  - `open` — current visibility.
  - `onClose` — handler for user dismiss.


# Quick example

    Ui.BottomSheet.new { open = state.detailsOpen, onClose = DetailsClosed }
        |> Ui.BottomSheet.withBody supplierDetails
        |> Ui.BottomSheet.view


# Type

@docs BottomSheet


# Constructor

@docs new


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withHeader, withBody, withActions, withHandle, withHideable, withModal


# Detents and gesture tuning

@docs withDetents, withHideFriction, withOvershootLimit


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import Cem.M3e.BottomSheet
import Cem.M3e.BottomSheetAction
import Ui.Button



-- TYPES ------------------------------------------------------------------


{-| A bottom sheet.
-}
type BottomSheet msg
    = BottomSheet (Config msg)


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , open : Bool
    , onClose : msg
    , header : Maybe (Html msg)
    , body : Maybe (Html msg)
    , actions : List (Ui.Button.Button msg)
    , handle : Bool
    , hideable : Bool
    , modal : Bool
    , detents : List String
    , hideFriction : Maybe Float
    , overshootLimit : Maybe Float
    }



-- CONSTRUCTOR ------------------------------------------------------------


{-| Construct a bottom sheet. Requires the current `open` state and an
`onClose` handler (fired on dismiss); see _Open state is caller-owned_
above. Defaults to a non-modal sheet with a drag handle that can be
swiped down to dismiss.
-}
new : { open : Bool, onClose : msg } -> BottomSheet msg
new c =
    BottomSheet
        { id = Nothing
        , attributes = []
        , open = c.open
        , onClose = c.onClose
        , header = Nothing
        , body = Nothing
        , actions = []
        , handle = True
        , hideable = True
        , modal = False
        , detents = []
        , hideFriction = Nothing
        , overshootLimit = Nothing
        }



-- MODIFIERS --------------------------------------------------------------


{-| Append attributes to the underlying `<m3e-bottom-sheet>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> BottomSheet msg -> BottomSheet msg
withAttributes attributes (BottomSheet cfg) =
    BottomSheet { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute — e.g. so an external `<m3e-bottom-sheet-trigger
for="…">` can target this sheet by id.
-}
withId : String -> BottomSheet msg -> BottomSheet msg
withId id (BottomSheet cfg) =
    BottomSheet { cfg | id = Just id }


{-| Set the sheet's header content — a title region rendered in the
`header` slot, above the body.
-}
withHeader : Html msg -> BottomSheet msg -> BottomSheet msg
withHeader header (BottomSheet cfg) =
    BottomSheet { cfg | header = Just header }


{-| Set the sheet's body content (rendered in the default slot).
-}
withBody : Html msg -> BottomSheet msg -> BottomSheet msg
withBody body (BottomSheet cfg) =
    BottomSheet { cfg | body = Just body }


{-| Set the actions. Each is rendered as its `<m3e-button>` with an
`<m3e-bottom-sheet-action>` marker nested _inside_ it, so that activating
the button closes the parent sheet.
-}
withActions :
    List (Ui.Button.Button msg)
    -> BottomSheet msg
    -> BottomSheet msg
withActions actions (BottomSheet cfg) =
    BottomSheet { cfg | actions = actions }


{-| Show the drag handle (the small bar at the top of the sheet that
indicates draggability). Default `True`.
-}
withHandle : Bool -> BottomSheet msg -> BottomSheet msg
withHandle b (BottomSheet cfg) =
    BottomSheet { cfg | handle = b }


{-| Allow the user to dismiss the sheet by dragging it down. Default `True`.
-}
withHideable : Bool -> BottomSheet msg -> BottomSheet msg
withHideable b (BottomSheet cfg) =
    BottomSheet { cfg | hideable = b }


{-| Make the sheet modal (overlays content with a scrim). Default `False`.
-}
withModal : Bool -> BottomSheet msg -> BottomSheet msg
withModal b (BottomSheet cfg) =
    BottomSheet { cfg | modal = b }


{-| Set the detents — the discrete height states the sheet can snap to. The
element's `detents` property is a `string[]`; its HTML attribute form (see the
m3e example `detents="fit half full"`) is a space-delimited list, so this takes
a `List String` and joins it with spaces. Each entry is a CSS-ish height token
understood by the element (e.g. `"fit"`, `"half"`, `"full"`, or an explicit
length).

Defaults to `[]` (no detents), in which case the sheet behaves as a simple
open/hidden surface. When detents are set the sheet snaps to the nearest one on
release. Note: the `string[]` setter is omitted from the `Cem.M3e.BottomSheet`
binding (Elm can't pass it as a property), so this writes the space-delimited
attribute directly.

-}
withDetents : List String -> BottomSheet msg -> BottomSheet msg
withDetents detents (BottomSheet cfg) =
    BottomSheet { cfg | detents = detents }


{-| Set the hide-friction coefficient (`hide-friction`, the element's default is
`0.5`) — the friction applied to a downward dismiss gesture. Higher values make
the sheet harder to fling away. Only emitted when set, so the element default
is preserved otherwise.
-}
withHideFriction : Float -> BottomSheet msg -> BottomSheet msg
withHideFriction friction (BottomSheet cfg) =
    BottomSheet { cfg | hideFriction = Just friction }


{-| Set the overshoot limit (`overshoot-limit`, the element's default is `4`) —
a fractional value between 0 and 100 capping the visual overshoot allowed when
dragging past the minimum or maximum height. Only emitted when set, so the
element default is preserved otherwise.
-}
withOvershootLimit : Float -> BottomSheet msg -> BottomSheet msg
withOvershootLimit limit (BottomSheet cfg) =
    BottomSheet { cfg | overshootLimit = Just limit }



-- RENDER -----------------------------------------------------------------


{-| Render the bottom sheet. Empty node when `open = False`.
-}
view : BottomSheet msg -> Html msg
view (BottomSheet cfg) =
    if not cfg.open then
        Html.text ""

    else
        Cem.M3e.BottomSheet.component
            (cfg.attributes
                ++ List.filterMap identity
                    [ Maybe.map Attr.id cfg.id
                    , Just (Cem.M3e.BottomSheet.open True)
                    , Just (Cem.M3e.BottomSheet.handle cfg.handle)
                    , Just (Cem.M3e.BottomSheet.hideable cfg.hideable)
                    , Just (Cem.M3e.BottomSheet.modal cfg.modal)
                    , if List.isEmpty cfg.detents then
                        Nothing

                      else
                        Just (Attr.attribute "detents" (String.join " " cfg.detents))
                    , Maybe.map Cem.M3e.BottomSheet.hideFriction cfg.hideFriction
                    , Maybe.map Cem.M3e.BottomSheet.overshootLimit cfg.overshootLimit
                    , Just (Cem.M3e.BottomSheet.onClosed (Decode.succeed cfg.onClose))
                    , Just (Cem.M3e.BottomSheet.onCancel (Decode.succeed cfg.onClose))
                    ]
            )
            (List.concat
                [ headerElement cfg.header
                , bodyElement cfg.body
                , actionsElement cfg.actions
                ]
            )


headerElement : Maybe (Html msg) -> List (Html msg)
headerElement header =
    case header of
        Nothing ->
            []

        Just h ->
            [ Html.div [ Cem.M3e.BottomSheet.headerSlot ] [ h ] ]


bodyElement : Maybe (Html msg) -> List (Html msg)
bodyElement body =
    case body of
        Nothing ->
            []

        Just b ->
            [ b ]


actionsElement :
    List (Ui.Button.Button msg)
    -> List (Html msg)
actionsElement actions =
    List.map
        (\button ->
            button
                |> Ui.Button.withExtraContent
                    [ Cem.M3e.BottomSheetAction.component [] [] ]
                |> Ui.Button.view
        )
        actions
