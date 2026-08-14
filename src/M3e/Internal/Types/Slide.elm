module M3e.Internal.Types.Slide exposing (..)

{-| Internal type definitions for Slide — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | slide : Brand }


type alias Attrs =
    { class : Supported
    , id : Supported
    , selectedIndex : Supported
    , slot : Supported
    , style : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | slide : Ctx }
