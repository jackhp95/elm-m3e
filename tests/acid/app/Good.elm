module Good exposing (bar, view)

{-| POSITIVE probe — the composition the library exists to make possible must
keep compiling. Exercises, in one value each:

  - **List form + slot admittance the right way round.** `M3e.Component.AppBar.leading`
    takes `LeadingSlot = { button, iconButton, sharedIcon }`, `title` takes
    `TitleSlot = { heading, sharedFlow, sharedPhrasing, sharedText }`, and
    `trailing` takes `TrailingSlot = { button, iconButton, searchBar,
    sharedFlow, sharedPhrasing }`. Each child below names a kind the slot
    lists, so each is admitted.
  - **Shared atoms.** `M3e.text` produces `sharedText` and `M3e.icon` produces
    `sharedIcon` — the two cross-library atoms — and they land in the slots
    that name them.
  - **Value narrowing.** `M3e.Component.AppBar.size` takes `Value Size` where
    `Size = { large, medium, small }`; `M3e.Values.small` is in that set.
  - **The explicit crossing.** `M3e.Unsafe.recast` frees the kind row so a
    Chip is admitted into a `button` slot.
  - **Attr-list composition.** Ordinary `List.concat`/`++` on `Attr` lists
    composes cleanly ahead of `el` — post-unification there is no separate
    pipe-builder surface (`M3e.Build.*` was deleted wholesale; every
    component is a single two-arity `el`, required-record when it has
    required fields).
  - **The render exit.** `M3e.toHtml`, called once, at the top.

-}

import Html exposing (Html)
import M3e
import M3e.Action
import M3e.Component.AppBar
import M3e.Component.SearchBar
import M3e.Unsafe
import M3e.Values
import TypedHtml


view : Html msg
view =
    M3e.toHtml
        (M3e.appBar
            [ M3e.Component.AppBar.size M3e.Values.small
            , M3e.Component.AppBar.centered True
            ]
            [ M3e.Component.AppBar.leading (M3e.icon [] [])
            , M3e.Component.AppBar.title (M3e.heading { content = M3e.text "Inbox" } [] [])
            , M3e.Component.AppBar.trailing
                (M3e.iconButton
                    { content = M3e.icon [] [], ariaLabel = "Search", action = M3e.Action.none }
                    []
                    []
                )
            , M3e.Component.AppBar.trailing
                (M3e.searchBar
                    { input = M3e.Component.SearchBar.input (TypedHtml.input [] []) }
                    []
                    []
                )
            , M3e.Component.AppBar.trailing
                (M3e.Unsafe.recast (M3e.chip { content = M3e.text "All" } [] []))
            ]
        )


bar : M3e.Element (M3e.Component.AppBar.Is s) admittedBy msg
bar =
    M3e.appBar
        (List.concat
            [ [ M3e.Component.AppBar.centered True ]
            , [ M3e.Component.AppBar.size M3e.Values.small ]
            ]
        )
        []
