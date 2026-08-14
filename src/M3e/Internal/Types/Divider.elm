module M3e.Internal.Types.Divider exposing (..)

{-| Internal type definitions for Divider — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | divider : Brand }


type alias Attrs =
    { class : Supported
    , id : Supported
    , inset : Supported
    , insetEnd : Supported
    , insetStart : Supported
    , slot : Supported
    , style : Supported
    , vertical : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | divider : Ctx }
