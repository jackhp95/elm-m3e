module M3e.Internal.Types.FabMenuItem exposing (..)

{-| Internal type definitions for FabMenuItem — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | fabMenuItem : Brand }


type alias Attrs =
    { class : Supported
    , disabled : Supported
    , download : Supported
    , href : Supported
    , id : Supported
    , onClick : Supported
    , rel : Supported
    , slot : Supported
    , style : Supported
    , target : Supported
    }


type alias IconSlot =
    { sharedIcon : Shared }


type alias ChildAdmittedBy childAdm =
    { childAdm | fabMenuItem : Ctx }
