module M3e.Paginator exposing
    ( view
    , Option
    , pageIndex, pageSize, pageSizes
    , disabled, showFirstLastButtons, hidePageSize, onPage
    )

{-| `<m3e-paginator>` — a compact control for moving through a paged
data set (Material 3 utility element, companion to tables).

Spec (per docs/CONVENTIONS.md):

  - Required: { length : Float }
    (total item count — what the paginator is about; drives the
    page count and which nav buttons are enabled)
  - Options: pageIndex, pageSize, pageSizes, disabled, showFirstLastButtons,
    hidePageSize, onPage
  - Slots: none (leaf element)
  - Properties: length, page-index, hide-page-size, show-first-last-buttons,
    disabled (via Node.property — introspectable/testable)
  - Events: page (CustomEvent) → Int (decoded from detail.pageIndex)
  - Escape: none (leaf)
  - Tag: paginator

@docs view
@docs Option
@docs pageIndex, pageSize, pageSizes
@docs disabled, showFirstLastButtons, hidePageSize, onPage

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable exposing (Renderable, Supported)


{-| An option configuring the `<m3e-paginator>` element.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Set the zero-based page index of the displayed list of items.
-}
pageIndex : Int -> Option msg
pageIndex v =
    Internal.option (\c -> { c | pageIndex = Just v })


{-| Set the number of items per page (e.g. `25`).
-}
pageSize : Int -> Option msg
pageSize v =
    Internal.option (\c -> { c | pageSize = Just v })


{-| Set the available page sizes (e.g. `[ 10, 25, 50 ]`). Defaults to
`[ 5, 10, 25, 50, 100 ]`.
-}
pageSizes : List Int -> Option msg
pageSizes v =
    Internal.option (\c -> { c | pageSizes = Just v })


{-| Disable all navigation and the size selector.
-}
disabled : Bool -> Option msg
disabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Show the first/last page jump buttons (default false).
-}
showFirstLastButtons : Bool -> Option msg
showFirstLastButtons b =
    Internal.option (\c -> { c | showFirstLastButtons = b })


{-| Hide the "items per page" size selector.
-}
hidePageSize : Bool -> Option msg
hidePageSize b =
    Internal.option (\c -> { c | hidePageSize = b })


{-| Wire a page-change handler. Receives the new zero-based page index
decoded from the `page` custom event's `detail.pageIndex`.
-}
onPage : (Int -> msg) -> Option msg
onPage f =
    Internal.option (\c -> { c | onPage = Just f })


type alias Config msg =
    { pageIndex : Maybe Int
    , pageSize : Maybe Int
    , pageSizes : Maybe (List Int)
    , disabled : Bool
    , showFirstLastButtons : Bool
    , hidePageSize : Bool
    , onPage : Maybe (Int -> msg)
    }


{-| Build the `<m3e-paginator>` IR node. Requires the total item count
(`length`), which drives the page count and which nav buttons are enabled.
-}
view : { length : Int } -> List (Option msg) -> Renderable { s | paginator : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts
                { pageIndex = Nothing
                , pageSize = Nothing
                , pageSizes = Nothing
                , disabled = False
                , showFirstLastButtons = False
                , hidePageSize = False
                , onPage = Nothing
                }
    in
    Internal.fromNode
        (Node.element "m3e-paginator"
            (List.filterMap identity
                [ Just (Node.property "length" (Encode.int req.length))
                , Maybe.map (\v -> Node.property "page-index" (Encode.int v)) c.pageIndex
                , Maybe.map (\v -> Node.attribute "page-size" (String.fromInt v)) c.pageSize
                , Maybe.map (\v -> Node.attribute "page-sizes" (String.join "," (List.map String.fromInt v))) c.pageSizes
                , if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , if c.showFirstLastButtons then
                    Just (Node.property "show-first-last-buttons" (Encode.bool True))

                  else
                    Nothing
                , if c.hidePageSize then
                    Just (Node.property "hide-page-size" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map
                    (\f ->
                        Node.on "page"
                            (Decode.at [ "detail", "pageIndex" ] Decode.int
                                |> Decode.map f
                            )
                    )
                    c.onPage
                ]
            )
            []
        )
