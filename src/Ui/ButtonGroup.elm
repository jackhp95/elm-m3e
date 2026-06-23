module Ui.ButtonGroup exposing
    ( ButtonGroup
    , Size(..)
    , new
    , withSize, withMulti
    , view
    )

{-| Typed builder for `<m3e-button-group>` — a connected row of buttons.
Mirrors the Material 3 [Button groups][m3] surface.

[m3]: https://m3.material.io/components/button-groups/overview

In M3 Expressive, button groups replace segmented buttons for most
button-row patterns. Each button keeps its own action wiring; the group
provides connected visual treatment (shared rounded ends, no gaps).


# Type

@docs ButtonGroup


# Configuration

@docs Size


# Constructor

@docs new


# Modifiers

@docs withSize, withMulti


# Render

@docs view

-}

import Html exposing (Html)
import M3e.ButtonGroup
import Ui.Button


{-| A button group.
-}
type ButtonGroup msg
    = ButtonGroup (Config msg)


type alias Config msg =
    { size : Size
    , multi : Bool
    , buttons : List (Ui.Button.Button msg)
    }


{-| Group size.
-}
type Size
    = ExtraSmall
    | Small
    | Medium
    | Large
    | ExtraLarge


{-| Construct a button group.
-}
new : List (Ui.Button.Button msg) -> ButtonGroup msg
new buttons =
    ButtonGroup { size = Medium, multi = False, buttons = buttons }


{-| Set the size for all buttons in the group.
-}
withSize : Size -> ButtonGroup msg -> ButtonGroup msg
withSize s (ButtonGroup cfg) =
    ButtonGroup { cfg | size = s }


{-| Toggle multi-select mode (buttons act as a multi-selection set).
-}
withMulti : Bool -> ButtonGroup msg -> ButtonGroup msg
withMulti b (ButtonGroup cfg) =
    ButtonGroup { cfg | multi = b }


{-| Render the button group.
-}
view : ButtonGroup msg -> Html msg
view (ButtonGroup cfg) =
    M3e.ButtonGroup.component
        [ sizeAttr cfg.size
        , M3e.ButtonGroup.multi cfg.multi
        ]
        (List.map Ui.Button.view cfg.buttons)


sizeAttr : Size -> Html.Attribute msg
sizeAttr s =
    case s of
        ExtraSmall ->
            (M3e.ButtonGroup.size M3e.ButtonGroup.ExtraSmall)

        Small ->
            (M3e.ButtonGroup.size M3e.ButtonGroup.Small)

        Medium ->
            (M3e.ButtonGroup.size M3e.ButtonGroup.Medium)

        Large ->
            (M3e.ButtonGroup.size M3e.ButtonGroup.Large)

        ExtraLarge ->
            (M3e.ButtonGroup.size M3e.ButtonGroup.ExtraLarge)
