module M3e.Internal.Types.Toc exposing (..)

{-| Internal type definitions for Toc — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | toc : Brand }


type alias Attrs =
    { class : Supported
    , for : Supported
    , id : Supported
    , maxDepth : Supported
    , slot : Supported
    , style : Supported
    }


type alias OverlineSlot =
    { heading : Brand
    , sharedText : Shared
    }


type alias TitleSlot =
    { heading : Brand
    , sharedText : Shared
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | toc : Ctx }
