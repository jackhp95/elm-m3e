module M3e.Internal.Types.PseudoCheckbox exposing (..)

{-| Internal type definitions for PseudoCheckbox — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | pseudoCheckbox : Brand }


type alias Attrs =
    { checked : Supported
    , class : Supported
    , disabled : Supported
    , id : Supported
    , indeterminate : Supported
    , slot : Supported
    , style : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | pseudoCheckbox : Ctx }
