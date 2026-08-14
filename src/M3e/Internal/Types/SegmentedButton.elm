module M3e.Internal.Types.SegmentedButton exposing (..)

{-| Internal type definitions for SegmentedButton — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | segmentedButton : Brand }


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
    }


type alias Content =
    { buttonSegment : Brand }


type alias ChildAdmittedBy childAdm =
    { childAdm | segmentedButton : Ctx }
