module M3e.Build.TextareaAutosize exposing ( Builder, AttrCaps, SlotCaps, textareaAutosize )

{-|
The ⑤ Build shape for `<m3e-textarea-autosize>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TextareaAutosize as TextareaAutosize`.

@docs Builder, AttrCaps, SlotCaps, textareaAutosize
-}



{-| Opaque builder for `<m3e-textarea-autosize>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { disabled : Maybe Bool
    , for : Maybe String
    , maxRows : Maybe Float
    , minRows : Maybe Float
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-textarea-autosize>`. -}
textareaAutosize : Builder AttrCaps SlotCaps msg
textareaAutosize =
    Builder
        { disabled = Nothing
        , for = Nothing
        , maxRows = Nothing
        , minRows = Nothing
        , phantomMsg_ = Nothing
        }