module M3e.Build.DrawerContainer exposing
    ( Builder, AttrCaps, SlotCaps, drawerContainer, end, endMode
    , endDivider, start, startMode, startDivider, onChange, default, startSlot
    , endSlot
    )

{-|
The ⑤ Build shape for `<m3e-drawer-container>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.DrawerContainer as DrawerContainer`.

@docs Builder, AttrCaps, SlotCaps, drawerContainer, end, endMode
@docs endDivider, start, startMode, startDivider, onChange, default
@docs startSlot, endSlot
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-drawer-container>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { end : M3e.Build.Internal.Available
    , endMode : M3e.Build.Internal.Available
    , endDivider : M3e.Build.Internal.Available
    , start : M3e.Build.Internal.Available
    , startMode : M3e.Build.Internal.Available
    , startDivider : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , startSlot : M3e.Build.Internal.Available
    , endSlot : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { end : Maybe Bool
    , endMode :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , over : M3e.Value.Supported
        , push : M3e.Value.Supported
        , side : M3e.Value.Supported
        })
    , endDivider : Maybe Bool
    , start : Maybe Bool
    , startMode :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , over : M3e.Value.Supported
        , push : M3e.Value.Supported
        , side : M3e.Value.Supported
        })
    , startDivider : Maybe Bool
    , onChange : Maybe (Json.Decode.Decoder msg)
    , default : Maybe (M3e.Element.Element {} msg)
    , startSlot : Maybe (M3e.Element.Element {} msg)
    , endSlot : Maybe (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-drawer-container>`. -}
drawerContainer : Builder AttrCaps SlotCaps msg
drawerContainer =
    Builder
        { end = Nothing
        , endMode = Nothing
        , endDivider = Nothing
        , start = Nothing
        , startMode = Nothing
        , startDivider = Nothing
        , onChange = Nothing
        , default = Nothing
        , startSlot = Nothing
        , endSlot = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether the end drawer is open. (default: `false`) -}
end :
    Bool
    -> Builder { a | end : M3e.Build.Internal.Available } s msg
    -> Builder { a | end : M3e.Build.Internal.Used } s msg
end v_ (Builder f_) =
    Builder { f_ | end = Just v_ }


{-| The behavior mode of the end drawer. (default: `"side"`) -}
endMode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , over : M3e.Value.Supported
    , push : M3e.Value.Supported
    , side : M3e.Value.Supported
    }
    -> Builder { a | endMode : M3e.Build.Internal.Available } s msg
    -> Builder { a | endMode : M3e.Build.Internal.Used } s msg
endMode v_ (Builder f_) =
    Builder { f_ | endMode = Just v_ }


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`) -}
endDivider :
    Bool
    -> Builder { a | endDivider : M3e.Build.Internal.Available } s msg
    -> Builder { a | endDivider : M3e.Build.Internal.Used } s msg
endDivider v_ (Builder f_) =
    Builder { f_ | endDivider = Just v_ }


{-| Whether the start drawer is open. (default: `false`) -}
start :
    Bool
    -> Builder { a | start : M3e.Build.Internal.Available } s msg
    -> Builder { a | start : M3e.Build.Internal.Used } s msg
start v_ (Builder f_) =
    Builder { f_ | start = Just v_ }


{-| The behavior mode of the start drawer. (default: `"side"`) -}
startMode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , over : M3e.Value.Supported
    , push : M3e.Value.Supported
    , side : M3e.Value.Supported
    }
    -> Builder { a | startMode : M3e.Build.Internal.Available } s msg
    -> Builder { a | startMode : M3e.Build.Internal.Used } s msg
startMode v_ (Builder f_) =
    Builder { f_ | startMode = Just v_ }


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`) -}
startDivider :
    Bool
    -> Builder { a | startDivider : M3e.Build.Internal.Available } s msg
    -> Builder { a | startDivider : M3e.Build.Internal.Used } s msg
startDivider v_ (Builder f_) =
    Builder { f_ | startDivider = Just v_ }


{-| Dispatched when the state of the start or end drawers change. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element {} msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }


{-| Set the `start` slot. Consumes the `startSlot` slot capability. -}
startSlot :
    M3e.Element.Element {} msg
    -> Builder a { s | startSlot : M3e.Build.Internal.Available } msg
    -> Builder a { s | startSlot : M3e.Build.Internal.Used } msg
startSlot v_ (Builder f_) =
    Builder { f_ | startSlot = Just v_ }


{-| Set the `end` slot. Consumes the `endSlot` slot capability. -}
endSlot :
    M3e.Element.Element {} msg
    -> Builder a { s | endSlot : M3e.Build.Internal.Available } msg
    -> Builder a { s | endSlot : M3e.Build.Internal.Used } msg
endSlot v_ (Builder f_) =
    Builder { f_ | endSlot = Just v_ }