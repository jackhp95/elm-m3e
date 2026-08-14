module M3e.Internal.Types.Tree exposing (..)

{-| Internal type definitions for Tree — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | tree : Brand }


type alias Attrs =
    { cascade : Supported
    , class : Supported
    , id : Supported
    , multi : Supported
    , onChange : Supported
    , slot : Supported
    , style : Supported
    }


type alias Content =
    { treeItem : Brand }


type alias ChildAdmittedBy childAdm =
    { childAdm | tree : Ctx }
