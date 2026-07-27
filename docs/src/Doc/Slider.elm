module Doc.Slider exposing (slidingPanels)

{-| A reusable **sliding-panel** helper for the docs app.

Given the 0-based index of the active panel and an ordered list of already-rendered
panels, `slidingPanels` mounts **all** panels side-by-side in a horizontal flex
track and translates the track by `activeIndex * 100%` so the active panel sits in
a clipping viewport while its neighbours are pushed off-screen. Switching the active
index re-drives the `transform`, and a CSS `transition` on the track animates the
slide (disabled under `prefers-reduced-motion` in `style.css`).

The viewport is the `<slide-panels>` custom element (`docs/../js/slide-panels.js`),
which uses a `ResizeObserver` on the active panel to keep the viewport's height in
lock-step with the active surface — so a short panel leaves no empty space and a
tall one is never clipped, and the height follows fold open/close. If
that element never upgrades, the viewport falls back to `height: auto` and still
shows the active panel correctly (the Elm-driven `transform` still applies).

The helper is deliberately generic (no knowledge of the API-surface `Layer` type),
so every tab UI in the docs can reuse the one implementation.

@docs slidingPanels

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Kind
import Native


{-| Mount `panels` in a sliding track, showing the one at `activeIndex`.

`activeIndex` is clamped to a valid position. A degenerate track (0 or 1 panel)
renders the single panel plainly — no viewport/track wrapper — so the slider only
appears when there is actually something to slide between.

-}
slidingPanels : Int -> List (Element { s | html : M3e.Kind.Brand } admittedBy msg) -> Element { r | html : M3e.Kind.Brand } freeAdm msg
slidingPanels activeIndex panels =
    case panels of
        [] ->
            Native.node "div" [] []

        [ only ] ->
            -- Plain passthrough (a bare wrapper, no viewport/track): a single panel
            -- has nothing to slide against. The wrapper re-opens the phantom row so
            -- the one panel drops into any context the slider itself would.
            Native.node "div" [] [ only ]

        _ ->
            let
                count : Int
                count =
                    List.length panels

                idx : Int
                idx =
                    clamp 0 (count - 1) activeIndex

                track : Element { k | html : M3e.Kind.Brand } trackAdm msg
                track =
                    Native.node "div"
                        [ Native.attribute "class" "sp-track"
                        , Native.style "transform" ("translateX(-" ++ String.fromInt (idx * 100) ++ "%)")
                        ]
                        (List.indexedMap (panel idx) panels)
            in
            Native.node "slide-panels"
                [ Native.attribute "class" "sp-viewport"
                , Native.attribute "active-index" (String.fromInt idx)
                ]
                [ track ]


{-| One panel wrapper: inactive panels get `aria-hidden="true"` and `inert`.
-}
panel : Int -> Int -> Element { s | html : M3e.Kind.Brand } admittedBy msg -> Element { k | html : M3e.Kind.Brand } freeAdm msg
panel activeIndex i child =
    let
        inactive : Bool
        inactive =
            i /= activeIndex

        attrs : List (Attr c msg)
        attrs =
            Native.attribute "class" "sp-panel"
                :: Native.attribute "aria-hidden"
                    (if inactive then
                        "true"

                     else
                        "false"
                    )
                :: (if inactive then
                        [ Native.attribute "inert" "" ]

                    else
                        []
                   )
    in
    Native.node "div" attrs [ child ]
