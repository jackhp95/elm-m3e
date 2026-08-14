module M3e.Internal.Types.ExpandableListItem exposing (..)

{-| Internal type definitions for ExpandableListItem — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | expandableListItem : Brand }


type alias Attrs =
    { class : Supported
    , disabled : Supported
    , id : Supported
    , onClosed : Supported
    , onClosing : Supported
    , onOpened : Supported
    , onOpening : Supported
    , open : Supported
    , slot : Supported
    , style : Supported
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


type alias ToggleIconSlot =
    { sharedIcon : Shared }


type alias ChildAdmittedBy childAdm =
    { childAdm | expandableListItem : Ctx }
