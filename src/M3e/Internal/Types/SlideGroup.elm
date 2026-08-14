module M3e.Internal.Types.SlideGroup exposing (..)

{-| Internal type definitions for SlideGroup — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | slideGroup : Brand }


type alias Attrs =
    { class : Supported
    , disabled : Supported
    , id : Supported
    , nextPageLabel : Supported
    , previousPageLabel : Supported
    , slot : Supported
    , style : Supported
    , threshold : Supported
    , vertical : Supported
    }


type alias NextIconSlot =
    { sharedIcon : Shared }


type alias PrevIconSlot =
    { sharedIcon : Shared }


type alias ChildAdmittedBy childAdm =
    { childAdm | slideGroup : Ctx }
