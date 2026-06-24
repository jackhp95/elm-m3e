module Ui.Toolbar exposing
    ( Toolbar
    , new
    , withAttributes
    , withId, withElevated, withVertical
    , view
    )

{-| Typed builder for `<m3e-toolbar>` — an in-flow row of buttons.
Mirrors the Material 3 [Toolbars][m3] surface.

[m3]: https://m3.material.io/components/toolbars/overview

Toolbars are for contextual _actions_, distinct from `Ui.AppBar`
(top-of-screen chrome) and `Ui.NavigationBar` (page-level destinations).

The actions list is typed to `Ui.Button.Button msg` (any button kind).


# Required-by-design

`new` requires a list of buttons.


# Quick example

    Ui.Toolbar.new
        [ Ui.Button.new { label = "Save", variant = Ui.Button.Filled }
            |> Ui.Button.withOnClick Saved
        , Ui.Button.new { label = "Discard", variant = Ui.Button.Text }
            |> Ui.Button.withOnClick Discarded
        ]
        |> Ui.Toolbar.view


# Type

@docs Toolbar


# Constructor

@docs new


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withElevated, withVertical


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import M3e.Toolbar
import Ui.Button



-- TYPES ------------------------------------------------------------------


{-| A toolbar.
-}
type Toolbar msg
    = Toolbar (Config msg)


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , elevated : Bool
    , vertical : Bool
    , actions : List (Ui.Button.Button msg)
    }



-- CONSTRUCTOR ------------------------------------------------------------


{-| Construct a toolbar from a list of buttons.
-}
new : List (Ui.Button.Button msg) -> Toolbar msg
new actions =
    Toolbar
        { id = Nothing
        , attributes = []
        , elevated = False
        , vertical = False
        , actions = actions
        }



-- MODIFIERS --------------------------------------------------------------


{-| Append attributes to the underlying `<m3e-toolbar>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Toolbar msg -> Toolbar msg
withAttributes attributes (Toolbar cfg) =
    Toolbar { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> Toolbar msg -> Toolbar msg
withId id (Toolbar cfg) =
    Toolbar { cfg | id = Just id }


{-| Toggle the elevated style.
-}
withElevated : Bool -> Toolbar msg -> Toolbar msg
withElevated b (Toolbar cfg) =
    Toolbar { cfg | elevated = b }


{-| Render the toolbar vertically.
-}
withVertical : Bool -> Toolbar msg -> Toolbar msg
withVertical b (Toolbar cfg) =
    Toolbar { cfg | vertical = b }



-- RENDER -----------------------------------------------------------------


{-| Render the toolbar.
-}
view : Toolbar msg -> Html msg
view (Toolbar cfg) =
    M3e.Toolbar.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (M3e.Toolbar.elevated cfg.elevated)
                , Just (M3e.Toolbar.vertical cfg.vertical)
                ]
        )
        (List.map Ui.Button.view cfg.actions)
