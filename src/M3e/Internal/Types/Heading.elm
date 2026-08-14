module M3e.Internal.Types.Heading exposing (..)

{-| Internal type definitions for Heading — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | heading : Brand }


type alias Attrs =
    { class : Supported
    , emphasized : Supported
    , id : Supported
    , level : Supported
    , size : Supported
    , slot : Supported
    , style : Supported
    , tocIgnore : Supported
    , variant : Supported
    }


type alias Content =
    { heading : Brand
    , sharedText : Shared
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | heading : Ctx }


type alias Size =
    { large : Supported
    , medium : Supported
    , small : Supported
    }


type alias Variant =
    { display : Supported
    , headline : Supported
    , label : Supported
    , title : Supported
    }
