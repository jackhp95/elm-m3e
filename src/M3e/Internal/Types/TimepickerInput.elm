module M3e.Internal.Types.TimepickerInput exposing (..)

{-| Internal type definitions for TimepickerInput — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | timepickerInput : Brand }


type alias Attrs =
    { class : Supported
    , for : Supported
    , format : Supported
    , hideLabels : Supported
    , hour : Supported
    , hourLabel : Supported
    , id : Supported
    , maxTime : Supported
    , minTime : Supported
    , minute : Supported
    , minuteLabel : Supported
    , onChange : Supported
    , onViewChange : Supported
    , orientation : Supported
    , period : Supported
    , periodToggleLabel : Supported
    , second : Supported
    , secondLabel : Supported
    , showSeconds : Supported
    , slot : Supported
    , style : Supported
    , viewAttr : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | timepickerInput : Ctx }


type alias Format =
    { value12 : Supported
    , value24 : Supported
    , auto : Supported
    }


type alias Period =
    { am : Supported
    , pm : Supported
    }


type alias ViewAttr =
    { hour : Supported
    , minute : Supported
    , second : Supported
    }
