module M3e.Internal.Types.FocusTrap exposing (..)

{-| Internal type definitions for FocusTrap — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | focusTrap : Brand }


type alias Attrs =
    { class : Supported
    , disabled : Supported
    , id : Supported
    , slot : Supported
    , style : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | focusTrap : Ctx }
