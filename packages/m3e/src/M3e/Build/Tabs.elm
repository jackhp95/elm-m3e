module M3e.Build.Tabs exposing ( Builder, AttrCaps, SlotCaps, tabs )

{-|
The ⑤ Build shape for `<m3e-tabs>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Tabs as Tabs`.

@docs Builder, AttrCaps, SlotCaps, tabs
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-tabs>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { disablePagination : Maybe String
    , headerPosition :
        Maybe (M3e.Value.Value { after : M3e.Value.Supported
        , before : M3e.Value.Supported
        })
    , nextPageLabel : Maybe String
    , previousPageLabel : Maybe String
    , stretch : Maybe Bool
    , variant :
        Maybe (M3e.Value.Value { primary : M3e.Value.Supported
        , secondary : M3e.Value.Supported
        })
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , nextIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , prevIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , default : List (M3e.Element.Element { tab : M3e.Value.Supported } msg)
    , panel : List (M3e.Element.Element { tabPanel : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-tabs>`. -}
tabs : Builder AttrCaps SlotCaps msg
tabs =
    Builder
        { disablePagination = Nothing
        , headerPosition = Nothing
        , nextPageLabel = Nothing
        , previousPageLabel = Nothing
        , stretch = Nothing
        , variant = Nothing
        , onChange = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , nextIcon = Nothing
        , prevIcon = Nothing
        , default = []
        , panel = []
        , phantomMsg_ = Nothing
        }