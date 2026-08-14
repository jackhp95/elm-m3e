module M3e.Internal.Types.Collapsible exposing (..)

{-| Internal type definitions for Collapsible — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | collapsible : Brand }


type alias Attrs =
    { class : Supported
    , id : Supported
    , noAnimate : Supported
    , onClosed : Supported
    , onClosing : Supported
    , onOpened : Supported
    , onOpening : Supported
    , open : Supported
    , orientation : Supported
    , slot : Supported
    , style : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | collapsible : Ctx }


type alias Orientation =
    { both : Supported
    , horizontal : Supported
    , vertical : Supported
    }
