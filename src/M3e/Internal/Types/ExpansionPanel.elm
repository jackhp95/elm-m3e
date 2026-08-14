module M3e.Internal.Types.ExpansionPanel exposing (..)

{-| Internal type definitions for ExpansionPanel — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | expansionPanel : Brand }


type alias Attrs =
    { class : Supported
    , disabled : Supported
    , hideToggle : Supported
    , id : Supported
    , onClosed : Supported
    , onClosing : Supported
    , onOpened : Supported
    , onOpening : Supported
    , open : Supported
    , slot : Supported
    , style : Supported
    , toggleDirection : Supported
    , togglePosition : Supported
    }


type alias ToggleIconSlot =
    { sharedIcon : Shared }


type alias ChildAdmittedBy childAdm =
    { childAdm | expansionPanel : Ctx }


type alias ToggleDirection =
    { horizontal : Supported
    , vertical : Supported
    }


type alias TogglePosition =
    { after : Supported
    , before : Supported
    }
