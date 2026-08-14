module M3e.Internal.Types.Ripple exposing (..)

{-| Internal type definitions for Ripple — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | ripple : Brand }


type alias Attrs =
    { centered : Supported
    , class : Supported
    , disabled : Supported
    , for : Supported
    , id : Supported
    , radius : Supported
    , slot : Supported
    , style : Supported
    , unbounded : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | ripple : Ctx }
