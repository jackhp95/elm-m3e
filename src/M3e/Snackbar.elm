module M3e.Snackbar exposing
    ( Option
    , view
    , withId, action, dismissible, closeLabel, duration
    )

{-| `<m3e-snackbar>` — a transient feedback surface at the bottom of the
screen (Material 3 Snackbar).

Spec (per docs/CONVENTIONS.md):

  - Required: `{ message }` — the feedback text (default slot)
  - Options: id, action, dismissible, closeLabel, duration
  - Properties: dismissible, duration (DOM properties; introspectable)
  - Attrs: action, close-label (rawAttr via Cem)
  - Tag: snackbar

---

**Imperative caveat — flag**

`<m3e-snackbar>` has NO `open` / `show` attribute and is opened imperatively
via `M3eSnackbar.open(message, action?, dismissible?, options?)` in JavaScript.
This module ports only the **declarative attribute/property surface** (the shape
of the element): it gives you an IR node whose tag, slots, and properties are
fully introspectable and testable.

To actually *show* a snackbar in a running app you need one of:

  - The `avt-snackbar` declarative wrapper (`js/avt-snackbar.js`), which reads
    these attributes and calls `M3eSnackbar.open(…)` on connect / attribute
    change. Render it conditionally from Elm state (see `Ui.Snackbar.view`).
  - A port: encode the config to JSON and call `M3eSnackbar.open(…)` from JS
    directly (see `Ui.Snackbar.encode`).

Both imperative paths are **out of scope** for the view-style IR layer.

-}

import Cem.M3e.Snackbar as CemSnackbar
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.Internal as Internal


-- OPTION TYPE -------------------------------------------------------------


type Option msg
    = WithId String
    | Action String
    | Dismissible Bool
    | CloseLabel String
    | Duration Int


-- SMART CONSTRUCTORS (OPTIONS) --------------------------------------------


{-| Set the `id` attribute on the `<m3e-snackbar>` element. -}
withId : String -> Option msg
withId =
    WithId


{-| Set the snackbar's action button label (the `action` attribute; no action
button rendered when absent). -}
action : String -> Option msg
action =
    Action


{-| Show a close button (the `dismissible` DOM property; default `false`). -}
dismissible : Bool -> Option msg
dismissible =
    Dismissible


{-| Set the close button's accessible label (the `close-label` attribute;
element default `"Close"`). Only rendered with `dismissible True`. -}
closeLabel : String -> Option msg
closeLabel =
    CloseLabel


{-| Set the auto-dismiss duration in milliseconds (the `duration` DOM property;
element default 3000 ms). -}
duration : Int -> Option msg
duration =
    Duration


-- VIEW --------------------------------------------------------------------


{-| Build the `<m3e-snackbar>` IR node.

    M3e.Snackbar.view { message = "Profile saved." }
        [ M3e.Snackbar.action "Undo"
        , M3e.Snackbar.duration 5000
        ]

The message text goes in the default slot. **See the module header for the
imperative-opening caveat** — this node cannot show itself; it needs the
`avt-snackbar` wrapper or a port to call `M3eSnackbar.open(…)`.

-}
view :
    { message : String }
    -> List (Option msg)
    -> Renderable { s | snackbar : Supported } msg
view req opts =
    let
        c =
            List.foldl applyOption defaultConfig opts
    in
    Internal.fromNode
        (Node.element "m3e-snackbar"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                , Maybe.map (\a -> Node.rawAttr (CemSnackbar.action a)) c.action
                , if c.dismissible then
                    Just (Node.property "dismissible" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map (\l -> Node.rawAttr (CemSnackbar.closeLabel l)) c.closeLabel
                , Maybe.map (\ms -> Node.property "duration" (Encode.float (toFloat ms))) c.duration
                ]
            )
            [ Node.text req.message ]
        )


-- INTERNAL ----------------------------------------------------------------


type alias Config =
    { id : Maybe String
    , action : Maybe String
    , dismissible : Bool
    , closeLabel : Maybe String
    , duration : Maybe Int
    }


defaultConfig : Config
defaultConfig =
    { id = Nothing
    , action = Nothing
    , dismissible = False
    , closeLabel = Nothing
    , duration = Nothing
    }


applyOption : Option msg -> Config -> Config
applyOption opt c =
    case opt of
        WithId s ->
            { c | id = Just s }

        Action s ->
            { c | action = Just s }

        Dismissible b ->
            { c | dismissible = b }

        CloseLabel s ->
            { c | closeLabel = Just s }

        Duration ms ->
            { c | duration = Just ms }
