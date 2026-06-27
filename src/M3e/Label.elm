module M3e.Label exposing (Label, fromHtml, toHtml)

{-| Unopinionated newtype over `Html msg` (no String sugar) — a governance seam
a consumer can lock to their translation codegen via elm-review.

@docs Label, fromHtml, toHtml

-}

import Html exposing (Html)


type Label msg
    = Label (Html msg)


fromHtml : Html msg -> Label msg
fromHtml =
    Label


toHtml : Label msg -> Html msg
toHtml (Label h) =
    h
