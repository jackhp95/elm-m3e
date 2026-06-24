module Ui.Paginator exposing
    ( Paginator, new
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


# Identity and size

@docs withId, withLength


# Modifiers

@docs withFirstLastButtons, withHidePageSize, withPageSizes, withDisabled


# Page state (hybrid)

@docs withDefaultPage, withExplicitPageState


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import M3e.Paginator


type Paginator msg
    = Paginator (Config msg)


type PageState msg
    = NoPage
    | DefaultPage Int
    | ExplicitPage (Int -> msg) Int


type alias Config msg =
    { id : Maybe String
    , length : Int
    , state : PageState msg
    , firstLast : Bool
    , hidePageSize : Bool
    , pageSizes : Maybe String
    , disabled : Bool
    }


new : Paginator msg
new =
    Paginator
        { id = Nothing
        , length = 0
        , state = NoPage
        , firstLast = False
        , hidePageSize = False
        , pageSizes = Nothing
        , disabled = False
        }


withId : String -> Paginator msg -> Paginator msg
withId id (Paginator cfg) =
    Paginator { cfg | id = Just id }


withLength : Int -> Paginator msg -> Paginator msg
withLength length (Paginator cfg) =
    Paginator { cfg | length = length }


withFirstLastButtons : Bool -> Paginator msg -> Paginator msg
withFirstLastButtons flag (Paginator cfg) =
    Paginator { cfg | firstLast = flag }


withHidePageSize : Bool -> Paginator msg -> Paginator msg
withHidePageSize flag (Paginator cfg) =
    Paginator { cfg | hidePageSize = flag }


withPageSizes : String -> Paginator msg -> Paginator msg
withPageSizes sizes (Paginator cfg) =
    Paginator { cfg | pageSizes = Just sizes }


withDisabled : Bool -> Paginator msg -> Paginator msg
withDisabled flag (Paginator cfg) =
    Paginator { cfg | disabled = flag }


withDefaultPage : Int -> Paginator msg -> Paginator msg
withDefaultPage pageIndex (Paginator cfg) =
    Paginator { cfg | state = DefaultPage pageIndex }


withExplicitPageState : (Int -> msg) -> Int -> Paginator msg -> Paginator msg
withExplicitPageState onPage pageIndex (Paginator cfg) =
    Paginator { cfg | state = ExplicitPage onPage pageIndex }


view : Paginator msg -> Html msg
view (Paginator cfg) =
    M3e.Paginator.component
        (List.filterMap identity
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
