module M3e.Internal.Types.NavRailToggle exposing (..)

{-| Internal type definitions for NavRailToggle — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | navRailToggle : Brand }


type alias Attrs =
    { class : Supported
    , for : Supported
    , id : Supported
    , slot : Supported
    , style : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | navRailToggle : Ctx }
