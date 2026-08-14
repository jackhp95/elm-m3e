module M3e.Internal.Types.TimepickerInputPeriodToggle exposing (..)

{-| Internal type definitions for TimepickerInputPeriodToggle — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | timepickerInputPeriodToggle : Brand }


type alias Attrs =
    { class : Supported
    , id : Supported
    , onChange : Supported
    , orientation : Supported
    , period : Supported
    , slot : Supported
    , style : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | timepickerInputPeriodToggle : Ctx }


type alias Period =
    { am : Supported
    , pm : Supported
    }
