module M3e.Build.TextareaAutosize exposing
    ( Builder, AttrCaps, SlotCaps, textareaAutosize, disabled, for
    , maxRows, minRows, build
    )

{-|
The ⑤ Build shape for `<m3e-textarea-autosize>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TextareaAutosize as TextareaAutosize`.

@docs Builder, AttrCaps, SlotCaps, textareaAutosize, disabled, for
@docs maxRows, minRows, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.TextareaAutosize
import M3e.Element
import M3e.Node
import M3e.Value


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


{-| Build the `<m3e-textarea-autosize>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | textareaAutosize : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.TextareaAutosize.textareaAutosize
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.TextareaAutosize.disabled v_)
                            ]
                         )
                         f_.disabled
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.TextareaAutosize.for v_)
                            ]
                         )
                         f_.for
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.TextareaAutosize.maxRows v_)
                            ]
                         )
                         f_.maxRows
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.TextareaAutosize.minRows v_)
                            ]
                         )
                         f_.minRows
                      )
                  ]
             )
             (List.concat [])
        )