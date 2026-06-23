module Ui.Theme exposing (Theme(..), toAttribute)

{-| Shared theme tokens for `Ui.*` builders.

A `Theme` selects the color role applied to a component. Components map
the theme to the project's standard `t-*` CSS classes (the same tokens
Mercury uses), so theme propagation works the same way across libraries.

-}

import Html exposing (Attribute)
import Html.Attributes exposing (class)


type Theme
    = Primary
    | Secondary
    | Tertiary
    | Neutral
    | Danger
    | Warning


toAttribute : Theme -> Attribute msg
toAttribute theme =
    case theme of
        Primary ->
            class "t-primary"

        Secondary ->
            class "t-secondary"

        Tertiary ->
            class "t-tertiary"

        Neutral ->
            class "t-neutral"

        Danger ->
            class "t-danger"

        Warning ->
            class "t-warning"
