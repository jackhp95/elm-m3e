module M3e.Internal.Types.MonthView exposing (..)

{-| Internal type definitions for MonthView — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | monthView : Brand }


type alias Attrs =
    { active : Supported
    , activeDate : Supported
    , class : Supported
    , date : Supported
    , id : Supported
    , maxDate : Supported
    , minDate : Supported
    , onActiveChange : Supported
    , onChange : Supported
    , rangeEnd : Supported
    , rangeStart : Supported
    , slot : Supported
    , style : Supported
    , today : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | monthView : Ctx }
