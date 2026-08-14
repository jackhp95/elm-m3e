module M3e.Internal.Types.TreeItem exposing (..)

{-| Internal type definitions for TreeItem — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | treeItem : Brand }


type alias Attrs =
    { class : Supported
    , disabled : Supported
    , id : Supported
    , indeterminate : Supported
    , onClick : Supported
    , onClosed : Supported
    , onClosing : Supported
    , onOpened : Supported
    , onOpening : Supported
    , open : Supported
    , selected : Supported
    , slot : Supported
    , style : Supported
    }


type alias Content =
    { treeItem : Brand }


type alias IconSlot =
    { sharedIcon : Shared }


type alias LabelSlot =
    { heading : Brand
    , sharedLink : Shared
    , sharedText : Shared
    }


type alias OpenToggleIconSlot =
    { sharedIcon : Shared }


type alias SelectedIconSlot =
    { sharedIcon : Shared }


type alias ToggleIconSlot =
    { sharedIcon : Shared }


type alias ChildAdmittedBy childAdm =
    { childAdm | treeItem : Ctx }
