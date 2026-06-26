module Ui.Divider exposing
    ( Divider
    , Orientation(..)
    , new
    , withAttributes
    , withOrientation, withInset, withInsetStart, withInsetEnd
    , view
    )

{-| Typed builder for `<m3e-divider>` — a thin, unobtrusive line that
separates content within lists, layouts, or containers. Mirrors the
Material 3 [Divider][m3] surface.

[m3]: https://m3.material.io/components/divider/overview

A divider is the lightest grouping cue — it reinforces a spatial boundary
without drawing attention. To separate two _resizable_ regions use
`Ui.SplitPane`; to show or hide a whole section in place, `Ui.Disclosure`.
By default the rule spans the full width; the `inset*` modifiers indent it
so it lines up with adjacent content (e.g. list text past a leading icon).


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
import Cem.M3e.Divider


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

  - **Horizontal** — a full-width rule between stacked content (default).
  - **Vertical** — a rule between side-by-side content; sets the element's
    `vertical` attribute.

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


{-| Indent the rule with equal padding on both sides — the m3 "inset
divider" (the `inset` attribute). Default `False`.
-}
withInset : Bool -> Divider msg -> Divider msg
withInset b (Divider cfg) =
    Divider { cfg | inset = b }


{-| Indent the leading (start) edge only (the `inset-start` attribute).
Default `False`.
-}
withInsetStart : Bool -> Divider msg -> Divider msg
withInsetStart b (Divider cfg) =
    Divider { cfg | insetStart = b }


{-| Indent the trailing (end) edge only (the `inset-end` attribute).
Default `False`.
-}
withInsetEnd : Bool -> Divider msg -> Divider msg
withInsetEnd b (Divider cfg) =
    Divider { cfg | insetEnd = b }


{-| Render the divider.
-}
view : Divider msg -> Html msg
view (Divider cfg) =
    Cem.M3e.Divider.component
        (cfg.attributes
            ++ [ Cem.M3e.Divider.vertical (cfg.orientation == Vertical)
               , Cem.M3e.Divider.inset cfg.inset
               , Cem.M3e.Divider.insetStart cfg.insetStart
               , Cem.M3e.Divider.insetEnd cfg.insetEnd
               ]
        )
        []
