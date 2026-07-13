module ExampleNav exposing (footer)

{-| The shared footer strip for the `/examples/*` app-screen pages.

Each example is a full-viewport, immersive screen with no docs chrome, so
before this the pages were dead ends: no way back to the component reference
they were built from, and no way to step to the next example. This module adds
a single quiet footer bar that closes both gaps:

  - **Built from** — links to the `/components/:slug` reference page for each
    component the screen composes, so a reader can jump from "this is what it
    looks like assembled" to "here is the API for the piece I want".
  - **prev / next** — links to the neighbouring example, so the five screens
    read as a sequence rather than five separate tabs.

The bar is deliberately low-contrast (`surfaceContainer`, `onSurfaceVariant`)
and sits after the screen content, so it never competes with the example it
annotates.

@docs footer

-}

import Kit
import Kit.Surface as Surface
import Layout
import Markup.Element exposing (Element)
import M3e.Kind
import M3e.Token as Value
import Markup.Kind


{-| Render the footer for one example page.

  - `builtFrom` is a list of `( componentSlug, label )` pairs. Each slug must
    match a `/components/:slug` route (i.e. a slug in `data/reference.json`);
    the label is the human-facing component name.
  - `prev` / `next` are `Maybe ( href, label )` for the neighbouring examples;
    `Nothing` renders nothing on that side (first example has no prev, last has
    no next).

-}
footer :
    { builtFrom : List ( String, String )
    , prev : Maybe ( String, String )
    , next : Maybe ( String, String )
    }
    -> Element { s | html : M3e.Kind.Brand, sharedLink : Markup.Kind.Shared } msg
footer { builtFrom, prev, next } =
    Surface.view Surface.surfaceContainer
        [ Layout.class "w-full border-t border-outline-variant/40 px-4 md:px-6 py-4 flex flex-col gap-3" ]
        [ backRow
        , builtFromRow builtFrom
        , prevNextRow prev next
        ]


{-| A quiet "back to the gallery" link. The examples now open in the SAME tab (the
gallery cards no longer target `_blank`), so the browser Back button already returns
here — this is the explicit in-page affordance for it.
-}
backRow : Element { s | html : M3e.Kind.Brand, sharedLink : Markup.Kind.Shared } msg
backRow =
    Layout.div "flex"
        [ Kit.textLink "/examples" [ Kit.onSurfaceVariant ] [ Kit.text "← Back to examples" ] ]


builtFromRow : List ( String, String ) -> Element { s | html : M3e.Kind.Brand, sharedLink : Markup.Kind.Shared } msg
builtFromRow builtFrom =
    Layout.div "flex flex-wrap items-baseline gap-x-2 gap-y-1"
        (Kit.labelText Value.large
            [ Kit.onSurfaceVariant ]
            [ Kit.text "Built from" ]
            :: List.map componentLink builtFrom
        )


componentLink : ( String, String ) -> Element { s | html : M3e.Kind.Brand, sharedLink : Markup.Kind.Shared } msg
componentLink ( slug, label ) =
    Kit.body Value.medium
        []
        [ Kit.textLink ("/components/" ++ slug) [ Kit.primary ] [ Kit.text label ] ]


prevNextRow :
    Maybe ( String, String )
    -> Maybe ( String, String )
    -> Element { s | html : M3e.Kind.Brand, sharedLink : Markup.Kind.Shared } msg
prevNextRow prev next =
    Layout.div "flex items-center justify-between gap-4"
        [ pagerSlot "← " prev
        , pagerSlot "" next
        ]


{-| One side of the prev/next pager. `prefix`/absence of `arrow` keeps the
"previous" arrow leading and the "next" arrow trailing.
-}
pagerSlot : String -> Maybe ( String, String ) -> Element { s | html : M3e.Kind.Brand, sharedLink : Markup.Kind.Shared } msg
pagerSlot leadingArrow slot =
    case slot of
        Nothing ->
            -- Keep the flex row balanced when one side is absent.
            Layout.span "" []

        Just ( href, label ) ->
            let
                shownLabel : String
                shownLabel =
                    if leadingArrow == "" then
                        label ++ " →"

                    else
                        leadingArrow ++ label
            in
            Kit.body Value.medium
                []
                [ Kit.textLink href [ Kit.onSurfaceVariant ] [ Kit.text shownLabel ] ]
