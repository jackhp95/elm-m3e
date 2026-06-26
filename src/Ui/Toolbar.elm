module Ui.Toolbar exposing
    ( Toolbar
    , new
    , withAttributes
    , withId, withElevated, withVertical
    , withIconButtons, withExtraContent
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


# Extra content

`new` takes labeled `Ui.Button`s. To add the common dense case —
**icon buttons** — or anything else (dividers, custom controls), append
them with the builders below. Render order in the default slot is:
buttons (from `new`) ++ icon buttons ++ extra content.

@docs withIconButtons, withExtraContent


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import M3e.Toolbar
import Ui.Button
import Ui.IconButton



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
    , iconButtons : List (Ui.IconButton.IconButton msg)
    , extraContent : List (Html msg)
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
        , iconButtons = []
        , extraContent = []
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


{-| Append icon buttons (in order) into the toolbar's default slot, after
the buttons from `new`. Calls accumulate.
-}
withIconButtons : List (Ui.IconButton.IconButton msg) -> Toolbar msg -> Toolbar msg
withIconButtons iconButtons (Toolbar cfg) =
    Toolbar { cfg | iconButtons = cfg.iconButtons ++ iconButtons }


{-| Append arbitrary `Html` (dividers, custom controls) into the toolbar's
default slot, after the buttons and icon buttons. The escape hatch for content
the typed builders don't cover. Calls accumulate.
-}
withExtraContent : List (Html msg) -> Toolbar msg -> Toolbar msg
withExtraContent extraContent (Toolbar cfg) =
    Toolbar { cfg | extraContent = cfg.extraContent ++ extraContent }



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
        (List.concat
            [ List.map Ui.Button.view cfg.actions
            , List.map Ui.IconButton.view cfg.iconButtons
            , cfg.extraContent
            ]
        )
