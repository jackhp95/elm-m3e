module M3e.Build.Badge exposing
    ( Builder, AttrCaps, SlotCaps, badge, size, position
    , for, default
    )

{-|
The ⑤ Build shape for `<m3e-badge>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Badge as Badge`.

@docs Builder, AttrCaps, SlotCaps, badge, size, position
@docs for, default
-}


import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-badge>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { size : M3e.Build.Internal.Available
    , position : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


type alias Fields msg =
    { size :
        Maybe (M3e.Value.Value { large : M3e.Value.Supported
        , medium : M3e.Value.Supported
        , small : M3e.Value.Supported
        })
    , position :
        Maybe (M3e.Value.Value { above : M3e.Value.Supported
        , aboveAfter : M3e.Value.Supported
        , aboveBefore : M3e.Value.Supported
        , after : M3e.Value.Supported
        , before : M3e.Value.Supported
        , below : M3e.Value.Supported
        , belowAfter : M3e.Value.Supported
        , belowBefore : M3e.Value.Supported
        })
    , for : Maybe String
    , default : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-badge>`. -}
badge : Builder AttrCaps SlotCaps msg
badge =
    Builder
        { size = Nothing
        , position = Nothing
        , for = Nothing
        , default = Nothing
        , phantomMsg_ = Nothing
        }


{-| The size of the badge. (default: `"medium"`) -}
size :
    M3e.Value.Value { large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg
    -> Builder { a | size : M3e.Build.Internal.Used } s msg
size v_ (Builder f_) =
    Builder { f_ | size = Just v_ }


{-| The position of the badge, when attached to another element. (default: `"above-after"`) -}
position :
    M3e.Value.Value { above : M3e.Value.Supported
    , aboveAfter : M3e.Value.Supported
    , aboveBefore : M3e.Value.Supported
    , after : M3e.Value.Supported
    , before : M3e.Value.Supported
    , below : M3e.Value.Supported
    , belowAfter : M3e.Value.Supported
    , belowBefore : M3e.Value.Supported
    }
    -> Builder { a | position : M3e.Build.Internal.Available } s msg
    -> Builder { a | position : M3e.Build.Internal.Used } s msg
position v_ (Builder f_) =
    Builder { f_ | position = Just v_ }


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg
    -> Builder { a | for : M3e.Build.Internal.Used } s msg
for v_ (Builder f_) =
    Builder { f_ | for = Just v_ }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }