module M3e.Internal.Types.TocItem exposing (..)

{-| Internal type definitions for TocItem — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | tocItem : Brand }


type alias Attrs =
    { class : Supported
    , disabled : Supported
    , id : Supported
    , onClick : Supported
    , selected : Supported
    , slot : Supported
    , style : Supported
    }


type alias Content =
    { heading : Brand
    , sharedText : Shared
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | tocItem : Ctx }
