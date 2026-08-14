module M3e.Internal.Types.Autocomplete exposing (..)

{-| Internal type definitions for Autocomplete — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | autocomplete : Brand }


type alias Attrs =
    { autoActivate : Supported
    , caseSensitive : Supported
    , class : Supported
    , filter : Supported
    , for : Supported
    , hideLoading : Supported
    , hideNoData : Supported
    , hideSelectionIndicator : Supported
    , id : Supported
    , loading : Supported
    , loadingLabel : Supported
    , noDataLabel : Supported
    , onChange : Supported
    , onQuery : Supported
    , onToggle : Supported
    , panelClass : Supported
    , required : Supported
    , resultsLabel : Supported
    , slot : Supported
    , style : Supported
    }


type alias Content =
    { optgroup : Brand
    , option : Brand
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | autocomplete : Ctx }


type alias Filter =
    { contains : Supported
    , endsWith : Supported
    , none : Supported
    , startsWith : Supported
    }
