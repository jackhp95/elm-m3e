module M3e.Internal.Types.Step exposing (..)

{-| Internal type definitions for Step — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | step : Brand }


type alias Attrs =
    { class : Supported
    , completed : Supported
    , disabled : Supported
    , editable : Supported
    , for : Supported
    , id : Supported
    , invalid : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onClick : Supported
    , onInput : Supported
    , optional : Supported
    , selected : Supported
    , slot : Supported
    , style : Supported
    }


type alias Content =
    { heading : Brand
    , sharedText : Shared
    }


type alias DoneIconSlot =
    { sharedIcon : Shared }


type alias EditIconSlot =
    { sharedIcon : Shared }


type alias ErrorSlot =
    { heading : Brand
    , sharedText : Shared
    }


type alias ErrorIconSlot =
    { sharedIcon : Shared }


type alias HintSlot =
    { heading : Brand
    , sharedText : Shared
    }


type alias IconSlot =
    { sharedIcon : Shared }


type alias ChildAdmittedBy childAdm =
    { childAdm | step : Ctx }
