module Ui.Badge exposing
    ( Badge, dot, count, label
    , withId, withFor
    , view
    )

{-| Typed builder for M3 badges. Wraps `M3e.Badge`.

M3 sanctions exactly two badge types: **small** (shape only, no text) and
**large** (text/count). These map to three constructors so the content rules
are enforced by construction rather than by settable-but-ignored modifiers:

  - [`dot`](#dot) — small; a shape-only indicator with no content slot.
  - [`count`](#count) — large; a numeric badge. Applies the M3 "999+"
    truncation (max 4 chars including `+`).
  - [`label`](#label) — large; short status text.


# Construction

@docs Badge, dot, count, label


# Modifiers

@docs withId, withFor


# Render

@docs view

@figma-code-connect node=<https://www.figma.com/design/cbhz1J779WAI7gYkjCQwS0/Avetta---ADS-Material-Rebrand?node-id=70622-99> entry=label valueProp=Label

-}

import Html exposing (Html, text)
import Html.Attributes as Attr
import Html.Extra
import M3e.Badge


type Badge msg
    = Badge (Config msg)


type alias Config msg =
    { id : Maybe String
    , content : Maybe (Html msg)
    , size : M3e.Badge.Size
    , for : Maybe String
    }


{-| A small, shape-only badge (no content) — the M3 "small" type.
-}
dot : Badge msg
dot =
    Badge { id = Nothing, content = Nothing, size = M3e.Badge.Small, for = Nothing }


{-| A large numeric badge. Applies the M3 "999+" truncation: counts above 999
render as `999+` (the spec caps the badge at 4 characters including the `+`).
-}
count : Int -> Badge msg
count n =
    Badge { id = Nothing, content = Just (text (countLabel n)), size = M3e.Badge.Large, for = Nothing }


{-| A large badge displaying short status text — the M3 "large" type.
-}
label : String -> Badge msg
label content =
    Badge { id = Nothing, content = Just (text content), size = M3e.Badge.Large, for = Nothing }


countLabel : Int -> String
countLabel n =
    if n > 999 then
        "999+"

    else
        String.fromInt n


withId : String -> Badge msg -> Badge msg
withId id (Badge cfg) =
    Badge { cfg | id = Just id }


{-| Anchor the badge to the element with the given id.
-}
withFor : String -> Badge msg -> Badge msg
withFor forId (Badge cfg) =
    Badge { cfg | for = Just forId }


view : Badge msg -> Html msg
view (Badge cfg) =
    M3e.Badge.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Just (M3e.Badge.size cfg.size)
            , Maybe.map M3e.Badge.for cfg.for
            ]
        )
        [ Html.Extra.viewMaybe identity cfg.content ]
