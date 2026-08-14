module M3e.Internal.Types.Calendar exposing (..)

{-| Internal type definitions for Calendar — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | calendar : Brand }


type alias Attrs =
    { class : Supported
    , date : Supported
    , id : Supported
    , maxDate : Supported
    , minDate : Supported
    , nextMonthLabel : Supported
    , nextMultiYearLabel : Supported
    , nextYearLabel : Supported
    , onChange : Supported
    , previousMonthLabel : Supported
    , previousMultiYearLabel : Supported
    , previousYearLabel : Supported
    , rangeEnd : Supported
    , rangeStart : Supported
    , slot : Supported
    , startAt : Supported
    , startView : Supported
    , style : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | calendar : Ctx }


type alias StartView =
    { month : Supported
    , multiYear : Supported
    , year : Supported
    }
