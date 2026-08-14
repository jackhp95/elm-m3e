module M3e.Internal.Types.CircularProgressIndicator exposing (..)

{-| Internal type definitions for CircularProgressIndicator — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | circularProgressIndicator : Brand }


type alias Attrs =
    { class : Supported
    , id : Supported
    , indeterminate : Supported
    , max : Supported
    , slot : Supported
    , style : Supported
    , value : Supported
    , variant : Supported
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | circularProgressIndicator : Ctx }


type alias Variant =
    { flat : Supported
    , wavy : Supported
    }
