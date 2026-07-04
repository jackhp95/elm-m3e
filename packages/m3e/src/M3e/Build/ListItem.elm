module M3e.Build.ListItem exposing
    ( Builder, AttrCaps, SlotCaps, listItem, default, leading
    , overline, supportingText, trailing
    )

{-|
The ⑤ Build shape for `<m3e-list-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ListItem as ListItem`.

@docs Builder, AttrCaps, SlotCaps, listItem, default, leading
@docs overline, supportingText, trailing
-}


import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-list-item>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , leading : M3e.Build.Internal.Available
    , overline : M3e.Build.Internal.Available
    , supportingText : M3e.Build.Internal.Available
    , trailing : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { default :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , leading :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported
        , avatar : M3e.Value.Supported
        , text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , overline :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , supportingText :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , trailing :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported
        , avatar : M3e.Value.Supported
        , text : M3e.Value.Supported
        , html : M3e.Value.Supported
        , switch : M3e.Value.Supported
        , radio : M3e.Value.Supported
        , checkbox : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-list-item>`. -}
listItem : Builder AttrCaps SlotCaps msg
listItem =
    Builder
        { default = Nothing
        , leading = Nothing
        , overline = Nothing
        , supportingText = Nothing
        , trailing = Nothing
        , phantomMsg_ = Nothing
        }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }


{-| Set the `leading` slot. Consumes the `leading` slot capability. -}
leading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | leading : M3e.Build.Internal.Available } msg
    -> Builder a { s | leading : M3e.Build.Internal.Used } msg
leading v_ (Builder f_) =
    Builder { f_ | leading = Just v_ }


{-| Set the `overline` slot. Consumes the `overline` slot capability. -}
overline :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | overline : M3e.Build.Internal.Available } msg
    -> Builder a { s | overline : M3e.Build.Internal.Used } msg
overline v_ (Builder f_) =
    Builder { f_ | overline = Just v_ }


{-| Set the `supporting-text` slot. Consumes the `supportingText` slot capability. -}
supportingText :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | supportingText : M3e.Build.Internal.Available } msg
    -> Builder a { s | supportingText : M3e.Build.Internal.Used } msg
supportingText v_ (Builder f_) =
    Builder { f_ | supportingText = Just v_ }


{-| Set the `trailing` slot. Consumes the `trailing` slot capability. -}
trailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    , switch : M3e.Value.Supported
    , radio : M3e.Value.Supported
    , checkbox : M3e.Value.Supported
    } msg
    -> Builder a { s | trailing : M3e.Build.Internal.Available } msg
    -> Builder a { s | trailing : M3e.Build.Internal.Used } msg
trailing v_ (Builder f_) =
    Builder { f_ | trailing = Just v_ }