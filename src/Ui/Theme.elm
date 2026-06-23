module Ui.Theme exposing (Theme(..), toAttribute)

{-| A semantic color role to apply to a subtree.

`toAttribute role` tags an element with a `t-{role}` class (e.g.
`t-primary`). Those role classes are a small CSS convention your
application provides — define them to retint the subtree (for example by
remapping the M3 `--md-sys-color-*` custom properties under each `t-*`
selector). The library only emits the class; it ships no CSS of its own.

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
