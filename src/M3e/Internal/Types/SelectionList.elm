module M3e.Internal.Types.SelectionList exposing (..)

{-| Internal type definitions for SelectionList — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | selectionList : Brand }


type alias Attrs =
    { class : Supported
    , disabled : Supported
    , hideSelectionIndicator : Supported
    , id : Supported
    , multi : Supported
    , name : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onInput : Supported
    , slot : Supported
    , style : Supported
    , variant : Supported
    }


type alias Content =
    { divider : Brand
    , expandableListItem : Brand
    , listOption : Brand
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | selectionList : Ctx }


type alias Variant =
    { segmented : Supported
    , standard : Supported
    }
