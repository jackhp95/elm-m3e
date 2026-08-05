module Good exposing (bar, view)

{-| POSITIVE probe — the composition the library exists to make possible must
keep compiling. Exercises, in one value each:

  - **List form + slot admittance the right way round.** `M3e.AppBar.leading`
    takes `LeadingSlot = { button, iconButton, sharedIcon }`, `title` takes
    `TitleSlot = { heading, sharedFlow, sharedPhrasing, sharedText }`, and
    `trailing` takes `TrailingSlot = { button, iconButton, searchBar,
    sharedFlow, sharedPhrasing }`. Each child below names a kind the slot
    lists, so each is admitted.
  - **Shared atoms.** `M3e.text` produces `sharedText` and `M3e.icon` produces
    `sharedIcon` — the two cross-library atoms — and they land in the slots
    that name them.
  - **Value narrowing.** `M3e.AppBar.size` takes `Value Size` where
    `Size = { large, medium, small }`; `M3e.Values.small` is in that set.
  - **The blessed crossing.** `M3e.Coerce.asButton` is the only sanctioned
    re-kind in the library, and it earns a Chip admission into a `button` slot.
  - **The pipe-builder.** Each singular slot capability is written exactly
    once, so every `Available` is consumed at most once.
  - **The render exit.** `M3e.toHtml`, called once, at the top.

-}

import Html exposing (Html)
import M3e
import M3e.AppBar
import M3e.Coerce
import M3e.Values


view : Html msg
view =
    M3e.toHtml
        (M3e.appBar
            [ M3e.AppBar.size M3e.Values.small
            , M3e.AppBar.centered True
            ]
            [ M3e.AppBar.leading (M3e.icon [] [])
            , M3e.AppBar.title (M3e.heading [] [ M3e.text "Inbox" ])
            , M3e.AppBar.trailing (M3e.iconButton [] [ M3e.icon [] [] ])
            , M3e.AppBar.trailing (M3e.searchBar [] [])
            , M3e.AppBar.trailing (M3e.Coerce.asButton (M3e.chip [] [ M3e.text "All" ]))
            ]
        )


bar : M3e.Element (M3e.AppBar.Is s) admittedBy msg
bar =
    M3e.AppBar.build
        |> M3e.AppBar.withCentered True
        |> M3e.AppBar.withTitle (M3e.heading [] [ M3e.text "Inbox" ])
        |> M3e.AppBar.withSubtitle (M3e.text "12 unread")
        |> M3e.AppBar.withLeadingIcon (M3e.icon [] [])
        |> M3e.AppBar.toElement
