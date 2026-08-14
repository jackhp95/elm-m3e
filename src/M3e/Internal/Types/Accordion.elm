module M3e.Internal.Types.Accordion exposing (..)

{-| Internal type definitions for Accordion — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | accordion : Brand }


type alias Attrs =
    { class : Supported
    , id : Supported
    , multi : Supported
    , slot : Supported
    , style : Supported
    }


type alias Content =
    { expansionPanel : Brand }


type alias ChildAdmittedBy childAdm =
    { childAdm | accordion : Ctx }
