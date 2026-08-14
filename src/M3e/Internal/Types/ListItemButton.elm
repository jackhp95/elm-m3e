module M3e.Internal.Types.ListItemButton exposing (..)

{-| Internal type definitions for ListItemButton — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | listItemButton : Brand }


type alias Attrs =
    { class : Supported
    , disabled : Supported
    , download : Supported
    , href : Supported
    , id : Supported
    , onClick : Supported
    , rel : Supported
    , slot : Supported
    , style : Supported
    , target : Supported
    }


type alias Content =
    { heading : Brand
    , sharedFlow : Shared
    , sharedPhrasing : Shared
    , sharedText : Shared
    }


type alias LeadingSlot =
    { avatar : Brand
    , heading : Brand
    , sharedFlow : Shared
    , sharedIcon : Shared
    , sharedPhrasing : Shared
    , sharedText : Shared
    }


type alias OverlineSlot =
    { heading : Brand
    , sharedFlow : Shared
    , sharedPhrasing : Shared
    , sharedText : Shared
    }


type alias SupportingTextSlot =
    { heading : Brand
    , sharedFlow : Shared
    , sharedPhrasing : Shared
    , sharedText : Shared
    }


type alias TrailingSlot =
    { avatar : Brand
    , checkbox : Brand
    , heading : Brand
    , radio : Brand
    , sharedFlow : Shared
    , sharedIcon : Shared
    , sharedPhrasing : Shared
    , sharedText : Shared
    , switch : Brand
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | listItemButton : Ctx }
