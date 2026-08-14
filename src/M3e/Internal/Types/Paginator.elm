module M3e.Internal.Types.Paginator exposing (..)

{-| Internal type definitions for Paginator — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | paginator : Brand }


type alias Attrs =
    { class : Supported
    , disabled : Supported
    , firstPageLabel : Supported
    , hidePageSize : Supported
    , id : Supported
    , itemsPerPageLabel : Supported
    , lastPageLabel : Supported
    , length : Supported
    , nextPageLabel : Supported
    , onPage : Supported
    , pageIndex : Supported
    , pageSize : Supported
    , pageSizeVariant : Supported
    , pageSizes : Supported
    , previousPageLabel : Supported
    , showFirstLastButtons : Supported
    , slot : Supported
    , style : Supported
    }


type alias FirstPageIconSlot =
    { sharedIcon : Shared }


type alias LastPageIconSlot =
    { sharedIcon : Shared }


type alias NextPageIconSlot =
    { sharedIcon : Shared }


type alias PreviousPageIconSlot =
    { sharedIcon : Shared }


type alias ChildAdmittedBy childAdm =
    { childAdm | paginator : Ctx }


type alias PageSizeVariant =
    { filled : Supported
    , outlined : Supported
    }
