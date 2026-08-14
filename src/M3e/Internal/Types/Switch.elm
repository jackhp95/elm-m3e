module M3e.Internal.Types.Switch exposing (..)

{-| Internal type definitions for Switch — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | switch : Brand }


type alias Attrs =
    { checked : Supported
    , class : Supported
    , disabled : Supported
    , icons : Supported
    , id : Supported
    , name : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onClick : Supported
    , onInput : Supported
    , slot : Supported
    , style : Supported
    , validationmessages : Supported
    , value : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | switch : Ctx }


type alias Icons =
    { both : Supported
    , none : Supported
    , selected : Supported
    }
