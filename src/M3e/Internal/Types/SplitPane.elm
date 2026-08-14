module M3e.Internal.Types.SplitPane exposing (..)

{-| Internal type definitions for SplitPane — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | splitPane : Brand }


type alias Attrs =
    { class : Supported
    , detents : Supported
    , disabled : Supported
    , id : Supported
    , label : Supported
    , max : Supported
    , min : Supported
    , name : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onInput : Supported
    , orientation : Supported
    , overshootLimit : Supported
    , slot : Supported
    , step : Supported
    , style : Supported
    , value : Supported
    , wrapDetents : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | splitPane : Ctx }


type alias Orientation =
    { auto : Supported
    , horizontal : Supported
    , vertical : Supported
    }
