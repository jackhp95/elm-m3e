module M3e.Internal.Types.Tooltip exposing (..)

{-| Internal type definitions for Tooltip — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | tooltip : Brand }


type alias Attrs =
    { class : Supported
    , disabled : Supported
    , for : Supported
    , hideDelay : Supported
    , id : Supported
    , position : Supported
    , showDelay : Supported
    , slot : Supported
    , style : Supported
    , touchGestures : Supported
    }


type alias Content =
    { heading : Brand
    , sharedText : Shared
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | tooltip : Ctx }


type alias Position =
    { above : Supported
    , after : Supported
    , before : Supported
    , below : Supported
    }


type alias TouchGestures =
    { auto : Supported
    , off : Supported
    , on : Supported
    }
