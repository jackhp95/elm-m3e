module M3e.Build.Snackbar exposing ( Builder, AttrCaps, SlotCaps, snackbar )

{-|
The ⑤ Build shape for `<m3e-snackbar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Snackbar as Snackbar`.

@docs Builder, AttrCaps, SlotCaps, snackbar
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-snackbar>`; see `.build` for the terminal. -}
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
    , action : Maybe String
    , closeLabel : Maybe String
    , dismissible : Maybe Bool
    , duration : Maybe Float
    , onBeforetoggle : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    , closeIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-snackbar>` with the required fields. -}
snackbar :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg
snackbar req_ =
    Builder
        { content = req_.content
        , action = Nothing
        , closeLabel = Nothing
        , dismissible = Nothing
        , duration = Nothing
        , onBeforetoggle = Nothing
        , onToggle = Nothing
        , closeIcon = Nothing
        , phantomMsg_ = Nothing
        }