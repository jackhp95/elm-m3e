module M3e.Build.SplitButton exposing
    ( Builder, AttrCaps, SlotCaps, splitButton, variant, size
    , build
    )

{-|
The ⑤ Build shape for `<m3e-split-button>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SplitButton as SplitButton`.

@docs Builder, AttrCaps, SlotCaps, splitButton, variant, size
@docs build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.SplitButton
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-split-button>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { variant : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { leadingButton : M3e.Element.Element { button : M3e.Value.Supported } msg
    , trailingButton :
        M3e.Element.Element { iconButton : M3e.Value.Supported } msg
    , variant :
        Maybe (M3e.Value.Value { elevated : M3e.Value.Supported
        , filled : M3e.Value.Supported
        , outlined : M3e.Value.Supported
        , tonal : M3e.Value.Supported
        })
    , size :
        Maybe (M3e.Value.Value { extraLarge : M3e.Value.Supported
        , extraSmall : M3e.Value.Supported
        , large : M3e.Value.Supported
        , medium : M3e.Value.Supported
        , small : M3e.Value.Supported
        })
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-split-button>` with the required fields. -}
splitButton :
    { leadingButton : M3e.Element.Element { button : M3e.Value.Supported } msg
    , trailingButton :
        M3e.Element.Element { iconButton : M3e.Value.Supported } msg
    }
    -> Builder AttrCaps SlotCaps msg
splitButton req_ =
    Builder
        { leadingButton = req_.leadingButton
        , trailingButton = req_.trailingButton
        , variant = Nothing
        , size = Nothing
        , phantomMsg_ = Nothing
        }


{-| The appearance variant of the button. (default: `"filled"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    , tonal : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }


{-| The size of the button. (default: `"small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg
    -> Builder { a | size : M3e.Build.Internal.Used } s msg
size v_ (Builder f_) =
    Builder { f_ | size = Just v_ }


{-| Build the `<m3e-split-button>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | splitButton : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.SplitButton.splitButton
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.SplitButton.variant v_)
                            ]
                         )
                         f_.variant
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.SplitButton.size v_)
                            ]
                         )
                         f_.size
                      )
                  ]
             )
             (List.concat
                  [ [ M3e.Element.toNode
                          (M3e.Element.withSlot
                               "leading-button"
                               f_.leadingButton
                          )
                    ]
                  , [ M3e.Element.toNode
                          (M3e.Element.withSlot
                               "trailing-button"
                               f_.trailingButton
                          )
                    ]
                  ]
             )
        )