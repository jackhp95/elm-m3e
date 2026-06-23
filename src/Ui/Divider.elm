module Ui.Divider exposing
    ( Divider
    , Orientation(..)
    , new
    , withOrientation, withInset, withInsetStart, withInsetEnd
    , view
    )

{-| Typed builder for `<m3e-divider>` — a thin rule that separates
content. Mirrors the Material 3 [Divider][m3] surface.

[m3]: https://m3.material.io/components/divider/overview


# Type

@docs Divider


# Configuration

@docs Orientation


# Constructor

@docs new


# Modifiers

@docs withOrientation, withInset, withInsetStart, withInsetEnd


# Render

@docs view

-}

import Html exposing (Html)
import M3e.Divider


{-| A divider.
-}
type Divider msg
    = Divider Config


type alias Config =
    { orientation : Orientation
    , inset : Bool
    , insetStart : Bool
    , insetEnd : Bool
    }


{-| Divider orientation.
-}
type Orientation
    = Horizontal
    | Vertical


{-| A divider. Defaults to horizontal, full-width.
-}
new : Divider msg
new =
    Divider
        { orientation = Horizontal
        , inset = False
        , insetStart = False
        , insetEnd = False
        }


{-| Set the divider orientation.
-}
withOrientation : Orientation -> Divider msg -> Divider msg
withOrientation o (Divider cfg) =
    Divider { cfg | orientation = o }


{-| Inset both ends (m3 "inset divider").
-}
withInset : Bool -> Divider msg -> Divider msg
withInset b (Divider cfg) =
    Divider { cfg | inset = b }


{-| Inset the start edge only.
-}
withInsetStart : Bool -> Divider msg -> Divider msg
withInsetStart b (Divider cfg) =
    Divider { cfg | insetStart = b }


{-| Inset the end edge only.
-}
withInsetEnd : Bool -> Divider msg -> Divider msg
withInsetEnd b (Divider cfg) =
    Divider { cfg | insetEnd = b }


{-| Render the divider.
-}
view : Divider msg -> Html msg
view (Divider cfg) =
    M3e.Divider.component
        [ M3e.Divider.vertical (cfg.orientation == Vertical)
        , M3e.Divider.inset cfg.inset
        , M3e.Divider.insetStart cfg.insetStart
        , M3e.Divider.insetEnd cfg.insetEnd
        ]
        []
