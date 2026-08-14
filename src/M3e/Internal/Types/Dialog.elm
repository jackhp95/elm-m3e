module M3e.Internal.Types.Dialog exposing (..)

{-| Internal type definitions for Dialog — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | dialog : Brand }


type alias Attrs =
    { alert : Supported
    , class : Supported
    , closeLabel : Supported
    , disableClose : Supported
    , dismissible : Supported
    , id : Supported
    , noFocusTrap : Supported
    , onCancel : Supported
    , onClosed : Supported
    , onClosing : Supported
    , onOpened : Supported
    , onOpening : Supported
    , open : Supported
    , slot : Supported
    , style : Supported
    }


type alias CloseIconSlot =
    { sharedIcon : Shared }


type alias HeaderSlot =
    { heading : Brand
    , sharedText : Shared
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | dialog : Ctx }
