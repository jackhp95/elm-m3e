module M3e.Internal.Types.RadioGroup exposing (..)

{-| Internal type definitions for RadioGroup — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | radioGroup : Brand }


type alias Attrs =
    { ariaInvalid : Supported
    , class : Supported
    , disabled : Supported
    , id : Supported
    , name : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onInput : Supported
    , required : Supported
    , slot : Supported
    , style : Supported
    , validationmessages : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | radioGroup : Ctx }
