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


{-| Phantom-typed opaque builder for `<m3e-split-button>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | splitButton : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { variant : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-split-button>` with the required fields. -}
splitButton :
    { leadingButton : M3e.Element.Element { button : M3e.Value.Supported } msg
    , trailingButton :
        M3e.Element.Element { iconButton : M3e.Value.Supported } msg
    }
    -> Builder AttrCaps SlotCaps msg kind
splitButton req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.SplitButton.splitButton
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             [ M3e.Element.toNode
                 (M3e.Element.withSlot "leading-button" req_.leadingButton)
             , M3e.Element.toNode
                 (M3e.Element.withSlot "trailing-button" req_.trailingButton)
             ]
        )


{-| The appearance variant of the button. (default: `"filled"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    , tonal : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SplitButton.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The size of the button. (default: `"small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | size : M3e.Build.Internal.Used } s msg kind
size v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SplitButton.size v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-split-button>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { splitButton : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)