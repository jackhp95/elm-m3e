module M3e.Build.Heading exposing ( Builder, AttrCaps, SlotCaps, heading )

{-|
The ⑤ Build shape for `<m3e-heading>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Heading as Heading`.

@docs Builder, AttrCaps, SlotCaps, heading
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-heading>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
    , emphasized : Maybe Bool
    , level : Maybe String
    , size :
        Maybe (M3e.Value.Value { large : M3e.Value.Supported
        , medium : M3e.Value.Supported
        , small : M3e.Value.Supported
        })
    , variant :
        Maybe (M3e.Value.Value { display : M3e.Value.Supported
        , headline : M3e.Value.Supported
        , label : M3e.Value.Supported
        , title : M3e.Value.Supported
        })
    }


{-| Seed a `Builder` for `<m3e-heading>` with the required fields. -}
heading :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg
heading req_ =
    Builder
        { content = req_.content
        , emphasized = Nothing
        , level = Nothing
        , size = Nothing
        , variant = Nothing
        }