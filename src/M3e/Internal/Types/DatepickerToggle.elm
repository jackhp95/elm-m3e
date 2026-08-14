module M3e.Internal.Types.DatepickerToggle exposing (..)

{-| Internal type definitions for DatepickerToggle — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | datepickerToggle : Brand }


type alias Attrs =
    { class : Supported
    , id : Supported
    , slot : Supported
    , style : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | datepickerToggle : Ctx }
