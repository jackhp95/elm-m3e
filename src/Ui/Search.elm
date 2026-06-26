module Ui.Search exposing
    ( Search, Bar, Results
    , bar, results
    , withAttributes
    , withId, withQuery, withPlaceholder
    , withClearable
    , withDefaultOpen, withExplicitOpenState
    , view
    )

{-| Typed builder for the M3 [Search][m3] surfaces — `<m3e-search-bar>` and
`<m3e-search-view>`. Mirrors the m3-doc-page 1:1 (two surfaces, one module).

[m3]: https://m3.material.io/components/search/overview

Two explicit constructors pick the surface, and the phantom `kind`
parameter makes each surface's modifiers type-checked rather than silently
ignored:

  - [`bar`](#bar) → `Cem.M3e.SearchBar`. Always-visible chrome. Accepts
    [`withClearable`](#withClearable); has no open state.
  - [`results`](#results) → `Cem.M3e.SearchView` (bar + results panel rendered
    via `Ui.List`). Accepts [`withDefaultOpen`](#withDefaultOpen) /
    [`withExplicitOpenState`](#withExplicitOpenState); has no clearable
    button (the input's native `x` clears the value).

The default leading slot is the m3e search icon — neither form requires
caller-side wiring for the magnifying glass. `withQuery` wires the input's
`value` and `onInput` so callers drive the search term from Elm state.


# Spec deviations

  - **Results are typed `Ui.List.Item msg`.** The default M3 search-view
    layout renders a vertical list, so the strict-split `Ui.List` is the
    natural shape. If a caller needs non-list result chrome (a "no results"
    placeholder, a "did you mean…?" banner, a rich grid of cards), a
    future `withResultPanel : Html msg` could land — kept narrow for now.
  - **Leading/trailing slot overrides aren't exposed.** The SearchBar
    auto-injects a Material `search` icon into the leading slot
    (`Cem.M3e.SearchBar` itself doesn't render one). The SearchView
    auto-renders its own search icon unless
    `hideSearchIcon` is set, so we skip the injection there. A future
    `withLeading` / `withTrailing` can land if callers need overrides.
  - **The `<input>` carries `type="search"`.** Browsers render rounded
    chrome and an `x`-to-clear affordance for free; we don't suppress
    them. `withQuery`'s `onInput` is the source of truth for the value.


# Type

@docs Search, Bar, Results


# Constructors

@docs bar, results


# Host attributes

@docs withAttributes


# Identity, query, placeholder

@docs withId, withQuery, withPlaceholder


# SearchBar modifiers

@docs withClearable


# SearchView open state

@docs withDefaultOpen, withExplicitOpenState


# Render

@docs view

-}

import Html exposing (Attribute, Html, span)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import Json.Decode as Decode
import Cem.M3e.SearchBar
import Cem.M3e.SearchView
import Ui.Icon
import Ui.List



-- TYPES ------------------------------------------------------------------


{-| A search surface. The phantom `kind` is [`Bar`](#Bar) or
[`Results`](#Results), gating which modifiers apply.
-}
type Search kind msg
    = Search (Config msg)


{-| Phantom tag for the [`bar`](#bar) surface (`Cem.M3e.SearchBar`).
-}
type Bar
    = Bar Never


{-| Phantom tag for the [`results`](#results) surface (`Cem.M3e.SearchView`).
-}
type Results
    = Results Never


type Mode
    = BarMode
    | ResultsMode


type OpenState msg
    = NoOpen
    | DefaultOpen Bool
    | ExplicitOpen (Bool -> msg) Bool


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , mode : Mode
    , query : Maybe ( String, String -> msg )
    , items : List (Ui.List.Item msg)
    , clearable : Bool
    , placeholder : Maybe String
    , openState : OpenState msg
    }



-- CONSTRUCTORS -----------------------------------------------------------


{-| A SearchBar: always-visible search chrome, no results panel.

    Ui.Search.bar
        |> Ui.Search.withId "header-search"
        |> Ui.Search.withQuery state.q QueryChanged
        |> Ui.Search.withPlaceholder "Search suppliers"
        |> Ui.Search.view

-}
bar : Search Bar msg
bar =
    Search
        { id = Nothing
        , attributes = []
        , mode = BarMode
        , query = Nothing
        , items = []
        , clearable = False
        , placeholder = Nothing
        , openState = NoOpen
        }


{-| A SearchView: a bar plus a results panel rendered from the given
`Ui.List.Item`s via `Ui.List`.

    Ui.Search.results
        [ Ui.List.actionItem "Acme Supplies"
            |> Ui.List.withItemOnClick (ResultClicked "acme")
        , Ui.List.actionItem "Acme West"
            |> Ui.List.withItemOnClick (ResultClicked "acmewest")
        ]
        |> Ui.Search.withId "global-search"
        |> Ui.Search.withQuery state.q QueryChanged
        |> Ui.Search.withPlaceholder "Search suppliers"
        |> Ui.Search.view

-}
results : List (Ui.List.Item msg) -> Search Results msg
results items =
    Search
        { id = Nothing
        , attributes = []
        , mode = ResultsMode
        , query = Nothing
        , items = items
        , clearable = False
        , placeholder = Nothing
        , openState = NoOpen
        }



-- MODIFIERS --------------------------------------------------------------


{-| Append attributes to the rendered surface host — `<m3e-search-bar>` for
[`bar`](#bar), `<m3e-search-view>` for [`results`](#results). Structural
attributes are emitted after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Search kind msg -> Search kind msg
withAttributes attributes (Search cfg) =
    Search { cfg | attributes = cfg.attributes ++ attributes }


{-| Attach a DOM id to the rendered surface. Required for testing and for
external triggers that need to address the bar/view by id.
-}
withId : String -> Search kind msg -> Search kind msg
withId id_ (Search cfg) =
    Search { cfg | id = Just id_ }


{-| Drive the search term from Elm. The first argument is the current
value; the second is invoked with the new value on every `input` event.
-}
withQuery : String -> (String -> msg) -> Search kind msg -> Search kind msg
withQuery value onChange (Search cfg) =
    Search { cfg | query = Just ( value, onChange ) }


{-| Placeholder text for the input. Renders identically on SearchBar and
SearchView.
-}
withPlaceholder : String -> Search kind msg -> Search kind msg
withPlaceholder placeholder (Search cfg) =
    Search { cfg | placeholder = Just placeholder }


{-| Toggle the SearchBar's inline clear (`x`) button — sets `clearable` on
`<m3e-search-bar>` (default `false`). Only available on [`bar`](#bar);
SearchView manages its own clear button via the input's value.
-}
withClearable : Bool -> Search Bar msg -> Search Bar msg
withClearable flag (Search cfg) =
    Search { cfg | clearable = flag }


{-| Set the SearchView's initial `open` state (the `<m3e-search-view>`
`open` attribute, default `false`), then let the DOM own subsequent
toggling. Only available on [`results`](#results). For caller-owned state,
use [`withExplicitOpenState`](#withExplicitOpenState) instead.
-}
withDefaultOpen : Bool -> Search Results msg -> Search Results msg
withDefaultOpen flag (Search cfg) =
    Search { cfg | openState = DefaultOpen flag }


{-| Caller-owned open state. Only available on [`results`](#results). The
first argument is invoked with the new flag whenever the M3e element
dispatches a `toggle` event.
-}
withExplicitOpenState : (Bool -> msg) -> Bool -> Search Results msg -> Search Results msg
withExplicitOpenState onChange flag (Search cfg) =
    Search { cfg | openState = ExplicitOpen onChange flag }



-- RENDER -----------------------------------------------------------------


{-| Render the configured surface to `Html` — `<m3e-search-bar>` for
[`bar`](#bar), `<m3e-search-view>` for [`results`](#results).
-}
view : Search kind msg -> Html msg
view (Search cfg) =
    case cfg.mode of
        BarMode ->
            viewSearchBar cfg

        ResultsMode ->
            viewSearchView cfg



-- SEARCH BAR


viewSearchBar : Config msg -> Html msg
viewSearchBar cfg =
    Cem.M3e.SearchBar.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (Cem.M3e.SearchBar.clearable cfg.clearable)
                ]
        )
        [ defaultLeading, inputElement cfg ]


defaultLeading : Html msg
defaultLeading =
    span [ Cem.M3e.SearchBar.leadingSlot ]
        [ Ui.Icon.view (Ui.Icon.material "search") ]



-- SEARCH VIEW


viewSearchView : Config msg -> Html msg
viewSearchView cfg =
    Cem.M3e.SearchView.component
        (cfg.attributes
            ++ List.filterMap identity
                (Maybe.map Attr.id cfg.id
                    :: searchViewOpenAttrs cfg.openState
                )
        )
        [ inputElement cfg
        , resultsList cfg.items
        ]


searchViewOpenAttrs : OpenState msg -> List (Maybe (Html.Attribute msg))
searchViewOpenAttrs state =
    case state of
        NoOpen ->
            []

        DefaultOpen True ->
            [ Just (Cem.M3e.SearchView.open True) ]

        DefaultOpen False ->
            []

        ExplicitOpen onChange flag ->
            [ Just (Cem.M3e.SearchView.open flag)
            , Just (Cem.M3e.SearchView.onToggle (toggleDecoder onChange))
            ]


{-| Decode the actual new open state from the `toggle` (ToggleEvent)
payload rather than blindly negating the last-known flag. `ToggleEvent`
carries `newState`, which is `"open"` when expanded and `"closed"`
otherwise.
-}
toggleDecoder : (Bool -> msg) -> Decode.Decoder msg
toggleDecoder onChange =
    Decode.at [ "newState" ] Decode.string
        |> Decode.map (\state -> onChange (state == "open"))


resultsList : List (Ui.List.Item msg) -> Html msg
resultsList items =
    Ui.List.new items
        |> Ui.List.view



-- INPUT (shared by both surfaces)


inputElement : Config msg -> Html msg
inputElement cfg =
    Html.input
        (List.filterMap identity
            [ Just Cem.M3e.SearchView.inputSlot
            , Just (Attr.type_ "search")
            , Maybe.map (Tuple.first >> Attr.value) cfg.query
            , Maybe.map (Tuple.second >> HtmlEvents.onInput) cfg.query
            , Maybe.map Attr.placeholder cfg.placeholder
            ]
        )
        []
