module Ui.Divider exposing
    ( Divider
    , Orientation(..)
    , new
    , withAttributes
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


# Host attributes

@docs withAttributes


# Modifiers

@docs withOrientation, withInset, withInsetStart, withInsetEnd


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import M3e.Divider


{-| A divider.
-}
type Divider msg
    = Divider (Config msg)


type alias Config msg =
    { orientation : Orientation
    , attributes : List (Attribute msg)
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
        , attributes = []
        , inset = False
        , insetStart = False
        , insetEnd = False
        }


{-| Append attributes to the underlying `<m3e-divider>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Divider msg -> Divider msg
withAttributes attributes (Divider cfg) =
    Divider { cfg | attributes = cfg.attributes ++ attributes }


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
        (cfg.attributes
            ++ [ M3e.Divider.vertical (cfg.orientation == Vertical)
               , M3e.Divider.inset cfg.inset
               , M3e.Divider.insetStart cfg.insetStart
               , M3e.Divider.insetEnd cfg.insetEnd
               ]
        )
        []
