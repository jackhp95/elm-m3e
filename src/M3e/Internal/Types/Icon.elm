module M3e.Internal.Types.Icon exposing (..)

{-| Internal type definitions for Icon — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Ctx, Used)


type alias Is s =
    { s | sharedIcon : Shared }


type alias Attrs =
    { class : Supported
    , filled : Supported
    , grade : Supported
    , id : Supported
    , name : Supported
    , opticalSize : Supported
    , slot : Supported
    , style : Supported
    , variant : Supported
    , weight : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | icon : Ctx }


type alias Grade =
    { high : Supported
    , low : Supported
    , medium : Supported
    }


type alias Variant =
    { outlined : Supported
    , rounded : Supported
    , sharp : Supported
    }
