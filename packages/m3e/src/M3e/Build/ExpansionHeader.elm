module M3e.Build.ExpansionHeader exposing
    ( Builder, AttrCaps, SlotCaps, expansionHeader, hideToggle, toggleDirection
    , togglePosition, disabled, onClick, default, toggleIcon
    )

{-|
The ⑤ Build shape for `<m3e-expansion-header>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ExpansionHeader as ExpansionHeader`.

@docs Builder, AttrCaps, SlotCaps, expansionHeader, hideToggle, toggleDirection
@docs togglePosition, disabled, onClick, default, toggleIcon
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-expansion-header>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { hideToggle : M3e.Build.Internal.Available
    , toggleDirection : M3e.Build.Internal.Available
    , togglePosition : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , toggleIcon : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { hideToggle : Maybe Bool
    , toggleDirection :
        Maybe (M3e.Value.Value { horizontal : M3e.Value.Supported
        , vertical : M3e.Value.Supported
        })
    , togglePosition :
        Maybe (M3e.Value.Value { after : M3e.Value.Supported
        , before : M3e.Value.Supported
        })
    , disabled : Maybe Bool
    , onClick : Maybe (Json.Decode.Decoder msg)
    , default : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , toggleIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-expansion-header>`. -}
expansionHeader : Builder AttrCaps SlotCaps msg
expansionHeader =
    Builder
        { hideToggle = Nothing
        , toggleDirection = Nothing
        , togglePosition = Nothing
        , disabled = Nothing
        , onClick = Nothing
        , default = Nothing
        , toggleIcon = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle :
    Bool
    -> Builder { a | hideToggle : M3e.Build.Internal.Available } s msg
    -> Builder { a | hideToggle : M3e.Build.Internal.Used } s msg
hideToggle v_ (Builder f_) =
    Builder { f_ | hideToggle = Just v_ }


{-| The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirection :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> Builder { a | toggleDirection : M3e.Build.Internal.Available } s msg
    -> Builder { a | toggleDirection : M3e.Build.Internal.Used } s msg
toggleDirection v_ (Builder f_) =
    Builder { f_ | toggleDirection = Just v_ }


{-| The position of the expansion toggle. (default: `"after"`) -}
togglePosition :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> Builder { a | togglePosition : M3e.Build.Internal.Available } s msg
    -> Builder { a | togglePosition : M3e.Build.Internal.Used } s msg
togglePosition v_ (Builder f_) =
    Builder { f_ | togglePosition = Just v_ }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Dispatched when the element is clicked. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg
onClick v_ (Builder f_) =
    Builder { f_ | onClick = Just v_ }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }


{-| Set the `toggle-icon` slot. Consumes the `toggleIcon` slot capability. -}
toggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | toggleIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | toggleIcon : M3e.Build.Internal.Used } msg
toggleIcon v_ (Builder f_) =
    Builder { f_ | toggleIcon = Just v_ }