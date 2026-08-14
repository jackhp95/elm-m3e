module M3e.Internal.Types.Breadcrumb exposing (..)

{-| Internal type definitions for Breadcrumb — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | breadcrumb : Brand }


type alias Attrs =
    { class : Supported
    , id : Supported
    , slot : Supported
    , style : Supported
    , wrap : Supported
    }


type alias Content =
    { breadcrumbItem : Brand }


type alias ChildAdmittedBy childAdm =
    { childAdm | breadcrumb : Ctx }
