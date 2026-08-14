module M3e.Internal.Types.Timepicker exposing (..)

{-| Internal type definitions for Timepicker — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | timepicker : Brand }


type alias Attrs =
    { class : Supported
    , confirmLabel : Supported
    , date : Supported
    , dialLabel : Supported
    , dismissLabel : Supported
    , for : Supported
    , format : Supported
    , hideModeToggle : Supported
    , hourLabel : Supported
    , id : Supported
    , inputLabel : Supported
    , maxTime : Supported
    , minTime : Supported
    , minuteLabel : Supported
    , mode : Supported
    , modeToggleLabel : Supported
    , onBeforetoggle : Supported
    , onChange : Supported
    , onToggle : Supported
    , orientation : Supported
    , periodToggleLabel : Supported
    , secondLabel : Supported
    , showSeconds : Supported
    , slot : Supported
    , style : Supported
    , variant : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | timepicker : Ctx }


type alias Format =
    { value12 : Supported
    , value24 : Supported
    , auto : Supported
    }


type alias Mode =
    { dial : Supported
    , input : Supported
    }


type alias Orientation =
    { auto : Supported
    , horizontal : Supported
    , vertical : Supported
    }


type alias Variant =
    { auto : Supported
    , docked : Supported
    , modal : Supported
    }
