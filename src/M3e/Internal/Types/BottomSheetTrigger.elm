module M3e.Internal.Types.BottomSheetTrigger exposing (..)

{-| Internal type definitions for BottomSheetTrigger — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | bottomSheetTrigger : Brand }


type alias Attrs =
    { class : Supported
    , detent : Supported
    , for : Supported
    , id : Supported
    , secondary : Supported
    , slot : Supported
    , style : Supported
    }


type alias Content =
    { heading : Brand
    , sharedText : Shared
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | bottomSheetTrigger : Ctx }
