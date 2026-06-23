module Ui.Icon exposing
    ( Icon
    , fontAwesome
    , Weight(..), Grade(..)
    , withA11y, withOpticalSize, withWeight, withGrade
    , a11y, view
    )

{-| Extended icon primitive for `Ui.*`.

Carries an optional accessible label (rendered as sr-only by containers
that present the icon as a standalone interactive) plus the M3 Icon
attribute trio (optical size, weight, grade) so callers can reach the
full M3 Material Symbols surface without a separate wrapper.


# Type

@docs Icon


# Construction

@docs fontAwesome


# Weight and grade

@docs Weight, Grade


# Modifiers

@docs withA11y, withOpticalSize, withWeight, withGrade


# Access and render

@docs a11y, view

-}

import Html exposing (Html)
import Icon


type Icon msg
    = Icon (Config msg)


type alias Config msg =
    { source : Source
    , a11y : Maybe (Html msg)
    , opticalSize : Maybe Int
    , weight : Maybe Weight
    , grade : Maybe Grade
    }


type Source
    = FontAwesomeSource (Icon.Icon Icon.FontAwesome)


type Weight
    = Thin
    | Light
    | Regular
    | Medium
    | Bold


type Grade
    = LowGrade
    | NormalGrade
    | HighGrade


{-| Construct an icon from a FontAwesome glyph.
-}
fontAwesome : Icon.Icon Icon.FontAwesome -> Icon msg
fontAwesome icon =
    Icon
        { source = FontAwesomeSource icon
        , a11y = Nothing
        , opticalSize = Nothing
        , weight = Nothing
        , grade = Nothing
        }


{-| Attach an accessible label. Containers that render the icon as a
standalone interactive surface this as `<span class="tw-sr-only">`. When
absent, those containers flag the icon visually as missing a label.
-}
withA11y : Html msg -> Icon msg -> Icon msg
withA11y label (Icon cfg) =
    Icon { cfg | a11y = Just label }


{-| Set the optical size (20..48). Only honored when the underlying
source is a Material Symbol; FontAwesome icons ignore it.
-}
withOpticalSize : Int -> Icon msg -> Icon msg
withOpticalSize n (Icon cfg) =
    Icon { cfg | opticalSize = Just n }


{-| Set the icon weight. Material-Symbols-only.
-}
withWeight : Weight -> Icon msg -> Icon msg
withWeight w (Icon cfg) =
    Icon { cfg | weight = Just w }


{-| Set the icon grade. Material-Symbols-only.
-}
withGrade : Grade -> Icon msg -> Icon msg
withGrade g (Icon cfg) =
    Icon { cfg | grade = Just g }


{-| Accessor used by `Ui.*` containers to render an sr-only label
or flag a missing one.
-}
a11y : Icon msg -> Maybe (Html msg)
a11y (Icon cfg) =
    cfg.a11y


{-| Render the icon glyph. Does not render the a11y label — containers
that need it call `a11y` and project it themselves.
-}
view : Icon msg -> Html msg
view (Icon cfg) =
    case cfg.source of
        FontAwesomeSource fa ->
            Icon.element fa [] []
