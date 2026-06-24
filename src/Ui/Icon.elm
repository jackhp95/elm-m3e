module Ui.Icon exposing
    ( Icon
    , material
    , withAttributes
    , Weight(..), Grade(..)
    , withA11y, withFilled, withOpticalSize, withWeight, withGrade
    , a11y, view
    )

{-| Icon primitive for `Ui.*`, backed by m3e's Material Symbols element
(`<m3e-icon>`). The symbol name is a [Material Symbols][ms] identifier
(e.g. `"menu"`, `"save"`, `"check"`) rendered as the element's text
ligature.

Carries an optional accessible label (rendered as `sr-only` by containers
that present the icon as a standalone interactive) plus the M3 Icon
attribute axes — optical size, weight, grade, fill — so callers reach the
full Material Symbols surface without a separate wrapper.

    Ui.Icon.material "menu"
        |> Ui.Icon.withWeight Ui.Icon.Medium
        |> Ui.Icon.withA11y (Html.text "Open menu")
        |> Ui.Icon.view

[ms]: https://fonts.google.com/icons


# Type

@docs Icon


# Construction

@docs material


# Host attributes

@docs withAttributes


# Weight and grade

@docs Weight, Grade


# Modifiers

@docs withA11y, withFilled, withOpticalSize, withWeight, withGrade


# Access and render

@docs a11y, view

-}

import Html exposing (Attribute, Html)
import M3e.Icon


{-| An m3e Material Symbols icon.
-}
type Icon msg
    = Icon (Config msg)


type alias Config msg =
    { name : String
    , attributes : List (Attribute msg)
    , filled : Bool
    , a11y : Maybe (Html msg)
    , opticalSize : Maybe Int
    , weight : Maybe Weight
    , grade : Maybe Grade
    }


{-| Material Symbols weight axis (100..700).
-}
type Weight
    = Thin
    | Light
    | Regular
    | Medium
    | Bold


{-| Material Symbols grade axis (low/normal/high emphasis).
-}
type Grade
    = LowGrade
    | NormalGrade
    | HighGrade


{-| Construct an icon from a Material Symbols name (e.g. `"check"`).
-}
material : String -> Icon msg
material name =
    Icon
        { name = name
        , attributes = []
        , filled = False
        , a11y = Nothing
        , opticalSize = Nothing
        , weight = Nothing
        , grade = Nothing
        }


{-| Append attributes to the underlying `<m3e-icon>` host element — the
escape hatch for styling the component itself. Structural attributes are
emitted after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Icon msg -> Icon msg
withAttributes attributes (Icon cfg) =
    Icon { cfg | attributes = cfg.attributes ++ attributes }


{-| Attach an accessible label. Containers that render the icon as a
standalone interactive surface this as an `sr-only` element; when absent,
those containers can flag the icon visually as missing a label.
-}
withA11y : Html msg -> Icon msg -> Icon msg
withA11y label (Icon cfg) =
    Icon { cfg | a11y = Just label }


{-| Use the filled grade of the symbol.
-}
withFilled : Bool -> Icon msg -> Icon msg
withFilled f (Icon cfg) =
    Icon { cfg | filled = f }


{-| Set the optical size (20..48).
-}
withOpticalSize : Int -> Icon msg -> Icon msg
withOpticalSize n (Icon cfg) =
    Icon { cfg | opticalSize = Just n }


{-| Set the icon weight.
-}
withWeight : Weight -> Icon msg -> Icon msg
withWeight w (Icon cfg) =
    Icon { cfg | weight = Just w }


{-| Set the icon grade.
-}
withGrade : Grade -> Icon msg -> Icon msg
withGrade g (Icon cfg) =
    Icon { cfg | grade = Just g }


{-| Accessor used by `Ui.*` containers to render an `sr-only` label
or flag a missing one.
-}
a11y : Icon msg -> Maybe (Html msg)
a11y (Icon cfg) =
    cfg.a11y


{-| Render the icon. Does not render the a11y label — containers that need
it call `a11y` and project it themselves.
-}
view : Icon msg -> Html msg
view (Icon cfg) =
    M3e.Icon.component
        (cfg.attributes
            ++ (M3e.Icon.name cfg.name
                    :: List.filterMap identity
                        [ Maybe.map (toFloat >> M3e.Icon.opticalSize) cfg.opticalSize
                        , Maybe.map (weightToString >> M3e.Icon.weight) cfg.weight
                        , Maybe.map (gradeToM3e >> M3e.Icon.grade) cfg.grade
                        , if cfg.filled then
                            Just (M3e.Icon.filled True)

                          else
                            Nothing
                        ]
               )
        )
        []


weightToString : Weight -> String
weightToString w =
    case w of
        Thin ->
            "100"

        Light ->
            "300"

        Regular ->
            "400"

        Medium ->
            "500"

        Bold ->
            "700"


gradeToM3e : Grade -> M3e.Icon.Grade
gradeToM3e g =
    case g of
        LowGrade ->
            M3e.Icon.Low

        NormalGrade ->
            M3e.Icon.Medium

        HighGrade ->
            M3e.Icon.High
