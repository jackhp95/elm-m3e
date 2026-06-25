module Ui.Paginator exposing
    ( Paginator, new
    , withAttributes
    , withId, withLength
    , withFirstLastButtons, withHidePageSize, withPageSizes, withDisabled
    , withDefaultPage, withExplicitPageState
    , view
    )

{-| Typed builder for M3 paginators. Wraps `M3e.Paginator`.


# State philosophy

Two ways to drive page state:

  - **Uncontrolled** (DOM owns ongoing state): `withDefaultPage`
  - **Controlled** (caller owns state): `withExplicitPageState
    onPage currentPageIndex`


# Construction

@docs Paginator, new


# Host attributes

@docs withAttributes


# Identity and size

@docs withId, withLength


# Modifiers

@docs withFirstLastButtons, withHidePageSize, withPageSizes, withDisabled


# Page state (hybrid)

@docs withDefaultPage, withExplicitPageState


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import M3e.Paginator


{-| The paginator opaque type. Build via `new`.
-}
type Paginator msg
    = Paginator (Config msg)


type PageState msg
    = NoPage
    | DefaultPage Int
    | ExplicitPage (Int -> msg) Int


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , length : Int
    , state : PageState msg
    , firstLast : Bool
    , hidePageSize : Bool
    , pageSizes : Maybe String
    , disabled : Bool
    }


{-| Construct a fresh paginator (length 0, no page state).
-}
new : Paginator msg
new =
    Paginator
        { id = Nothing
        , attributes = []
        , length = 0
        , state = NoPage
        , firstLast = False
        , hidePageSize = False
        , pageSizes = Nothing
        , disabled = False
        }


{-| Append attributes to the underlying `<m3e-…>` host element — the escape
hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Paginator msg -> Paginator msg
withAttributes attributes (Paginator cfg) =
    Paginator { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> Paginator msg -> Paginator msg
withId id (Paginator cfg) =
    Paginator { cfg | id = Just id }


{-| Set the total number of items being paginated.
-}
withLength : Int -> Paginator msg -> Paginator msg
withLength length (Paginator cfg) =
    Paginator { cfg | length = length }


{-| Toggle the first/last page jump buttons.
-}
withFirstLastButtons : Bool -> Paginator msg -> Paginator msg
withFirstLastButtons flag (Paginator cfg) =
    Paginator { cfg | firstLast = flag }


{-| Hide the page-size selector.
-}
withHidePageSize : Bool -> Paginator msg -> Paginator msg
withHidePageSize flag (Paginator cfg) =
    Paginator { cfg | hidePageSize = flag }


{-| Set the available page sizes (as the element's space-separated string).
-}
withPageSizes : String -> Paginator msg -> Paginator msg
withPageSizes sizes (Paginator cfg) =
    Paginator { cfg | pageSizes = Just sizes }


{-| Disable the paginator.
-}
withDisabled : Bool -> Paginator msg -> Paginator msg
withDisabled flag (Paginator cfg) =
    Paginator { cfg | disabled = flag }


{-| Uncontrolled: set the initial page index; the DOM owns state thereafter.
-}
withDefaultPage : Int -> Paginator msg -> Paginator msg
withDefaultPage pageIndex (Paginator cfg) =
    Paginator { cfg | state = DefaultPage pageIndex }


{-| Controlled: the caller owns the current page index and handles page changes.
-}
withExplicitPageState : (Int -> msg) -> Int -> Paginator msg -> Paginator msg
withExplicitPageState onPage pageIndex (Paginator cfg) =
    Paginator { cfg | state = ExplicitPage onPage pageIndex }


{-| Render the paginator.
-}
view : Paginator msg -> Html msg
view (Paginator cfg) =
    M3e.Paginator.component
        (cfg.attributes
            ++ List.filterMap identity
                ([ Maybe.map Attr.id cfg.id
                 , Just (M3e.Paginator.length (toFloat cfg.length))
                 , Just (M3e.Paginator.showFirstLastButtons cfg.firstLast)
                 , Just (M3e.Paginator.hidePageSize cfg.hidePageSize)
                 , Just (M3e.Paginator.disabled cfg.disabled)
                 , Maybe.map M3e.Paginator.pageSizes cfg.pageSizes
                 ]
                    ++ pageAttrs cfg.state
                )
        )
        []


pageAttrs : PageState msg -> List (Maybe (Html.Attribute msg))
pageAttrs state =
    case state of
        NoPage ->
            []

        DefaultPage pageIndex ->
            [ Just (M3e.Paginator.pageIndex (toFloat pageIndex)) ]

        ExplicitPage onPage pageIndex ->
            [ Just (M3e.Paginator.pageIndex (toFloat pageIndex))
            , Just
                (M3e.Paginator.onPage
                    (Decode.at [ "detail", "pageIndex" ] Decode.int
                        |> Decode.map onPage
                    )
                )
            ]
