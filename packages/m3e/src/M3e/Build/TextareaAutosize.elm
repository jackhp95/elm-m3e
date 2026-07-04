module M3e.Build.TextareaAutosize exposing
    ( Builder, AttrCaps, SlotCaps, textareaAutosize, disabled, for
    , maxRows, minRows
    )

{-|
The ⑤ Build shape for `<m3e-textarea-autosize>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TextareaAutosize as TextareaAutosize`.

@docs Builder, AttrCaps, SlotCaps, textareaAutosize, disabled, for
@docs maxRows, minRows
-}


import M3e.Build.Internal


{-| Opaque builder for `<m3e-textarea-autosize>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , maxRows : M3e.Build.Internal.Available
    , minRows : M3e.Build.Internal.Available
    }


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


{-| Whether auto-sizing is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg
    -> Builder { a | for : M3e.Build.Internal.Used } s msg
for v_ (Builder f_) =
    Builder { f_ | for = Just v_ }


{-| The maximum amount of rows in the `textarea`. (default: `0`) -}
maxRows :
    Float
    -> Builder { a | maxRows : M3e.Build.Internal.Available } s msg
    -> Builder { a | maxRows : M3e.Build.Internal.Used } s msg
maxRows v_ (Builder f_) =
    Builder { f_ | maxRows = Just v_ }


{-| The minimum amount of rows in the `textarea`. (default: `0`) -}
minRows :
    Float
    -> Builder { a | minRows : M3e.Build.Internal.Available } s msg
    -> Builder { a | minRows : M3e.Build.Internal.Used } s msg
minRows v_ (Builder f_) =
    Builder { f_ | minRows = Just v_ }