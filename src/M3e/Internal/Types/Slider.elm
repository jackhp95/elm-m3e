module M3e.Internal.Types.Slider exposing (..)

{-| Internal type definitions for Slider — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | slider : Brand }


type alias Attrs =
    { class : Supported
    , disabled : Supported
    , discrete : Supported
    , id : Supported
    , labelled : Supported
    , max : Supported
    , min : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onInput : Supported
    , size : Supported
    , slot : Supported
    , step : Supported
    , style : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | slider : Ctx }


type alias Size =
    { extraLarge : Supported
    , extraSmall : Supported
    , large : Supported
    , medium : Supported
    , small : Supported
    }
