module Ui.Snackbar exposing
    ( Snackbar
    , new
    , withId, withAction, withDismissible, withCloseLabel, withDuration
    , view
    , encode
    )

{-| Typed builder for `<m3e-snackbar>` — a transient feedback surface
that appears at the bottom of the screen. Mirrors the Material 3
[Snackbar][m3] surface.

[m3]: https://m3.material.io/components/snackbar/overview


# Important caveat — m3e-snackbar is imperative

Unlike most M3e custom elements, `<m3e-snackbar>` is fundamentally
**imperative**: it has no `open`/`show` attribute, only a static
`M3eSnackbar.open(message, action?, dismissible?, options?)` method,
a singleton `current` (only one snackbar visible at a time), and a
default 3000 ms auto-dismiss. This module bridges to that imperative
API in two presentations, sharing one builder:


# Two presentations

  - **Declarative** (`view`) — renders an `<avt-snackbar>` custom
    element wrapper that reads the builder's config from attributes
    and drives `M3eSnackbar.open(…)` on connect / attribute change.
    Elm owns visibility via `Maybe` state and renders this
    conditionally.

  - **Imperative** (`encode`) — produces a JSON encoding of the
    builder that callers can pipe through their app's port to JS,
    which then calls `M3eSnackbar.open(…)` directly. The caller wires
    a `port snackbarShow : Value -> Cmd msg`. Best for fire-and-forget
    toasts ("Saved", "Undo").

Both presentations consume the same `Snackbar msg` value, so callers
choose at the use site without re-specifying the snackbar's content.


# Action callback round-trip (declarative)

The `<avt-snackbar>` wrapper element dispatches a bubbling
`avt-snackbar-action` custom event when the action button is pressed.
Its `event.detail.id` carries the wrapper's `id` attribute. Consumer
pattern:

  - Set an `id` on each snackbar via `withId`.
  - Listen on `document` (or a higher anchor) via a subscription:
    `Browser.Events.onClick`-style port that decodes the custom event
    and dispatches a `Msg` based on `event.detail.id`.


# Imperative action callback (encode path)

For the `encode` path, the caller's outbound port should pass the
config to JS, which calls `M3eSnackbar.open(message, action, dismissible,
{ duration, closeLabel, actionCallback })`. Wire `actionCallback` to
fire an inbound port event carrying the `id`; the Elm consumer pattern-
matches the id in their subscription to dispatch a `Msg`.


# Caveats

  - **Singleton conflicts:** m3e enforces one snackbar visible at a
    time; if two `<avt-snackbar>` wrappers render simultaneously, the
    last `.open(…)` wins. Documented; not enforced by the type system.
  - The imperative `encode` path requires per-app port wiring. See
    each app's `Ports` module for examples.


# Required-by-design

`new` requires only the `message` text. Everything else is optional.


# Quick examples

Declarative (state-driven):

    -- model
    type alias State = { snackbar : Maybe (Ui.Snackbar.Snackbar Msg) }

    -- view (conditional render)
    case state.snackbar of
        Nothing ->
            text ""

        Just s ->
            Ui.Snackbar.view s

    -- builder
    Ui.Snackbar.new "Profile saved."
        |> Ui.Snackbar.withAction "Undo"
        |> Ui.Snackbar.withDuration 5000

Imperative (fire-and-forget; caller-owned port):

    -- in your app's Ports module
    port snackbarShow : Value -> Cmd msg

    -- in update
    Ui.Snackbar.new "Profile saved."
        |> Ui.Snackbar.withAction "Undo"
        |> Ui.Snackbar.encode
        |> snackbarShow


# Type

@docs Snackbar


# Constructor

@docs new


# Modifiers

@docs withId, withAction, withDismissible, withCloseLabel, withDuration


# Render

@docs view


# Imperative encoding

@docs encode

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Json.Encode as Encode


{-| A snackbar.
-}
type Snackbar msg
    = Snackbar Config


type alias Config =
    { id : Maybe String
    , message : String
    , action : Maybe String
    , dismissible : Bool
    , closeLabel : Maybe String
    , duration : Maybe Int
    }


{-| Construct a snackbar with the given message text.
-}
new : String -> Snackbar msg
new message =
    Snackbar
        { id = Nothing
        , message = message
        , action = Nothing
        , dismissible = False
        , closeLabel = Nothing
        , duration = Nothing
        }


{-| Set the `id` attribute. Useful when wiring an `actionId` for the
inbound action-callback port (the id round-trips back to the consumer's
subscription handler).
-}
withId : String -> Snackbar msg -> Snackbar msg
withId id (Snackbar cfg) =
    Snackbar { cfg | id = Just id }


{-| Add an action button with the given label.
-}
withAction : String -> Snackbar msg -> Snackbar msg
withAction label (Snackbar cfg) =
    Snackbar { cfg | action = Just label }


{-| Make the snackbar dismissible (shows a close affordance).
-}
withDismissible : Bool -> Snackbar msg -> Snackbar msg
withDismissible b (Snackbar cfg) =
    Snackbar { cfg | dismissible = b }


{-| Set the close-button accessible label (only meaningful with
`withDismissible True`).
-}
withCloseLabel : String -> Snackbar msg -> Snackbar msg
withCloseLabel label (Snackbar cfg) =
    Snackbar { cfg | closeLabel = Just label }


{-| Set the auto-dismiss duration in milliseconds. Default m3e behavior
is 3000 ms.
-}
withDuration : Int -> Snackbar msg -> Snackbar msg
withDuration ms (Snackbar cfg) =
    Snackbar { cfg | duration = Just ms }


{-| Render the snackbar as an `<avt-snackbar>` custom element. The
wrapper element calls `M3eSnackbar.open(…)` on connect, so render it
(via `Maybe` state) when you want a snackbar shown.

The wrapper ships with the library at `js/avt-snackbar.js` — include it
in your bundle after `@m3e/web` (it needs the global `M3eSnackbar` the
snackbar element registers). Action presses dispatch a bubbling
`avt-snackbar-action` event carrying `detail.id` (see the module header).

-}
view : Snackbar msg -> Html msg
view (Snackbar cfg) =
    Html.node "avt-snackbar"
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Just (Attr.attribute "message" cfg.message)
            , Maybe.map (Attr.attribute "action") cfg.action
            , if cfg.dismissible then
                Just (Attr.attribute "dismissible" "true")

              else
                Nothing
            , Maybe.map (Attr.attribute "close-label") cfg.closeLabel
            , Maybe.map (Attr.attribute "duration" << String.fromInt) cfg.duration
            ]
        )
        []


{-| Encode the snackbar as a JSON value for piping through an
outbound port to JS.

The JS side should call `M3eSnackbar.open(message, action, dismissible,
{ duration, closeLabel, id })` with the decoded fields. Action clicks
should fire an inbound port event carrying the `id` (or a synthesized
`actionId`); the Elm consumer pattern-matches that string in their
subscription handler to dispatch a `Msg`.

-}
encode : Snackbar msg -> Encode.Value
encode (Snackbar cfg) =
    Encode.object
        (List.filterMap identity
            [ Maybe.map (\v -> ( "id", Encode.string v )) cfg.id
            , Just ( "message", Encode.string cfg.message )
            , Maybe.map (\v -> ( "action", Encode.string v )) cfg.action
            , Just ( "dismissible", Encode.bool cfg.dismissible )
            , Maybe.map (\v -> ( "closeLabel", Encode.string v )) cfg.closeLabel
            , Maybe.map (\v -> ( "duration", Encode.int v )) cfg.duration
            ]
        )
