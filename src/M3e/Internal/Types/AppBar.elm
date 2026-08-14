module M3e.Internal.Types.AppBar exposing (..)

{-| Internal type definitions for AppBar — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | appBar : Brand }


type alias Attrs =
    { centered : Supported
    , class : Supported
    , for : Supported
    , id : Supported
    , size : Supported
    , slot : Supported
    , style : Supported
    }


type alias LeadingSlot =
    { button : Brand
    , iconButton : Brand
    , sharedIcon : Shared
    }


type alias SubtitleSlot =
    { heading : Brand
    , sharedFlow : Shared
    , sharedPhrasing : Shared
    , sharedText : Shared
    }


type alias TitleSlot =
    { heading : Brand
    , sharedFlow : Shared
    , sharedPhrasing : Shared
    , sharedText : Shared
    }


type alias TrailingSlot =
    { button : Brand
    , iconButton : Brand
    , searchBar : Brand
    , sharedFlow : Shared
    , sharedPhrasing : Shared
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | appBar : Ctx }


type alias Size =
    { large : Supported
    , medium : Supported
    , small : Supported
    }
