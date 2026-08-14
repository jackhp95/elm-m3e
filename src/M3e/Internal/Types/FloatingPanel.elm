module M3e.Internal.Types.FloatingPanel exposing (..)

{-| Internal type definitions for FloatingPanel — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | floatingPanel : Brand }


type alias Attrs =
    { anchorOffset : Supported
    , class : Supported
    , fitAnchorWidth : Supported
    , id : Supported
    , onBeforetoggle : Supported
    , onToggle : Supported
    , scrollStrategy : Supported
    , slot : Supported
    , style : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | floatingPanel : Ctx }


type alias ScrollStrategy =
    { hide : Supported
    , reposition : Supported
    }
