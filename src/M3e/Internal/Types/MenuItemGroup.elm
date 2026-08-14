module M3e.Internal.Types.MenuItemGroup exposing (..)

{-| Internal type definitions for MenuItemGroup — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | menuItemGroup : Brand }


type alias Attrs =
    { class : Supported
    , id : Supported
    , slot : Supported
    , style : Supported
    }


type alias Content =
    { menuItem : Brand
    , menuItemCheckbox : Brand
    , menuItemRadio : Brand
    }


type alias ChildAdmittedBy childAdm =
    { childAdm | menuItemGroup : Ctx }
