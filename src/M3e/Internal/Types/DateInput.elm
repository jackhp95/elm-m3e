module M3e.Internal.Types.DateInput exposing (..)

{-| Internal type definitions for DateInput — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | dateInput : Brand }


type alias Attrs =
    { class : Supported
    , dayLabel : Supported
    , disabled : Supported
    , hourLabel : Supported
    , id : Supported
    , maxDate : Supported
    , maxTime : Supported
    , minDate : Supported
    , minTime : Supported
    , minuteLabel : Supported
    , monthLabel : Supported
    , name : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onInput : Supported
    , onInvalid : Supported
    , periodLabel : Supported
    , readonly : Supported
    , required : Supported
    , secondLabel : Supported
    , showSeconds : Supported
    , slot : Supported
    , style : Supported
    , timeFormat : Supported
    , type_ : Supported
    , validationmessages : Supported
    , value : Supported
    , yearLabel : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | dateInput : Ctx }


type alias TimeFormat =
    { value12 : Supported
    , value24 : Supported
    , auto : Supported
    }


type alias Type =
    { date : Supported
    , datetime : Supported
    , time : Supported
    }
