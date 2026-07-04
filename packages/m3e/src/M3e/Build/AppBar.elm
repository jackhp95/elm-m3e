module M3e.Build.AppBar exposing ( Builder, AttrCaps, SlotCaps, appBar )

{-|
The ⑤ Build shape for `<m3e-app-bar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.AppBar as AppBar`.

@docs Builder, AttrCaps, SlotCaps, appBar
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-app-bar>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { centered : Maybe Bool
    , for : Maybe String
    , size :
        Maybe (M3e.Value.Value { large : M3e.Value.Supported
        , medium : M3e.Value.Supported
        , small : M3e.Value.Supported
        })
    , leading :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        , button : M3e.Value.Supported
        } msg)
    , title :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , subtitle :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , leadingIcon : Maybe (M3e.Element.Element any_ msg)
    , trailingIcon : Maybe (M3e.Element.Element any_ msg)
    , trailing :
        List (M3e.Element.Element { iconButton : M3e.Value.Supported
        , button : M3e.Value.Supported
        , searchBar : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    }


{-| Seed a `Builder` for `<m3e-app-bar>`. -}
appBar : Builder AttrCaps SlotCaps msg
appBar =
    Builder
        { centered = Nothing
        , for = Nothing
        , size = Nothing
        , leading = Nothing
        , title = Nothing
        , subtitle = Nothing
        , leadingIcon = Nothing
        , trailingIcon = Nothing
        , trailing = []
        }