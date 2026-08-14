module M3e.Internal.Types.SearchBar exposing (..)

{-| Internal type definitions for SearchBar — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | searchBar : Brand }


type alias Attrs =
    { class : Supported
    , clearLabel : Supported
    , clearable : Supported
    , id : Supported
    , onClear : Supported
    , slot : Supported
    , style : Supported
    }


type alias ClearIconSlot =
    { sharedIcon : Shared }


type alias LeadingSlot =
    { iconButton : Brand
    , sharedIcon : Shared
    }


type alias TrailingSlot =
    { iconButton : Brand
    , sharedIcon : Shared
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | searchBar : Ctx }
