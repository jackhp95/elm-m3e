module M3e.Internal.Types.RichTooltipAction exposing (..)

{-| Internal type definitions for RichTooltipAction — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | richTooltipAction : Brand }


type alias Attrs =
    { class : Supported
    , disableRestoreFocus : Supported
    , id : Supported
    , slot : Supported
    , style : Supported
    }


type alias Content =
    { heading : Brand
    , sharedText : Shared
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | richTooltipAction : Ctx }
