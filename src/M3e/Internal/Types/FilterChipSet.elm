module M3e.Internal.Types.FilterChipSet exposing (..)

{-| Internal type definitions for FilterChipSet — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | filterChipSet : Brand }


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
    , vertical : Supported
    }


type alias Content =
    { filterChip : Brand }


type alias ChildAdmittedBy childAdm =
    { childAdm | filterChipSet : Ctx }
