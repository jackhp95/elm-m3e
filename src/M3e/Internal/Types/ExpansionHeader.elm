module M3e.Internal.Types.ExpansionHeader exposing (..)

{-| Internal type definitions for ExpansionHeader — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | expansionHeader : Brand }


type alias Attrs =
    { class : Supported
    , disabled : Supported
    , hideToggle : Supported
    , id : Supported
    , onClick : Supported
    , slot : Supported
    , style : Supported
    , toggleDirection : Supported
    , togglePosition : Supported
    }


type alias Content =
    { heading : Brand
    , sharedText : Shared
    }


type alias ToggleIconSlot =
    { sharedIcon : Shared }


type alias ChildAdmittedBy childAdm =
    { childAdm | expansionHeader : Ctx }


type alias ToggleDirection =
    { horizontal : Supported
    , vertical : Supported
    }


type alias TogglePosition =
    { after : Supported
    , before : Supported
    }
