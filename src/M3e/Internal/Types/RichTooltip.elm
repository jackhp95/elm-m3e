module M3e.Internal.Types.RichTooltip exposing (..)

{-| Internal type definitions for RichTooltip — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | richTooltip : Brand }


type alias Attrs =
    { class : Supported
    , disabled : Supported
    , for : Supported
    , hideDelay : Supported
    , id : Supported
    , onBeforetoggle : Supported
    , onToggle : Supported
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


type alias SubheadSlot =
    { heading : Brand
    , sharedText : Shared
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | richTooltip : Ctx }


type alias Position =
    { above : Supported
    , aboveAfter : Supported
    , aboveBefore : Supported
    , after : Supported
    , before : Supported
    , below : Supported
    , belowAfter : Supported
    , belowBefore : Supported
    }


type alias TouchGestures =
    { auto : Supported
    , off : Supported
    , on : Supported
    }
