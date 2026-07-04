module M3e.Build.BreadcrumbItem exposing
    ( Builder, AttrCaps, SlotCaps, breadcrumbItem, itemLabel, disabled
    , current, href, target, download, rel, onClick, default
    , icon
    )

{-|
The ⑤ Build shape for `<m3e-breadcrumb-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BreadcrumbItem as BreadcrumbItem`.

@docs Builder, AttrCaps, SlotCaps, breadcrumbItem, itemLabel, disabled
@docs current, href, target, download, rel, onClick
@docs default, icon
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-breadcrumb-item>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { itemLabel : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , current : M3e.Build.Internal.Available
    , href : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , icon : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { itemLabel : Maybe String
    , disabled : Maybe Bool
    , current :
        Maybe (M3e.Value.Value { date : M3e.Value.Supported
        , location : M3e.Value.Supported
        , page : M3e.Value.Supported
        , step : M3e.Value.Supported
        , time : M3e.Value.Supported
        , true : M3e.Value.Supported
        })
    , href : Maybe String
    , target : Maybe String
    , download : Maybe String
    , rel : Maybe String
    , onClick : Maybe (Json.Decode.Decoder msg)
    , default :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , icon : M3e.Value.Supported
        } msg)
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-breadcrumb-item>`. -}
breadcrumbItem : Builder AttrCaps SlotCaps msg
breadcrumbItem =
    Builder
        { itemLabel = Nothing
        , disabled = Nothing
        , current = Nothing
        , href = Nothing
        , target = Nothing
        , download = Nothing
        , rel = Nothing
        , onClick = Nothing
        , default = Nothing
        , icon = Nothing
        , phantomMsg_ = Nothing
        }


{-| The accessible label given to the item's internal button. (default: `""`) -}
itemLabel :
    String
    -> Builder { a | itemLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | itemLabel : M3e.Build.Internal.Used } s msg
itemLabel v_ (Builder f_) =
    Builder { f_ | itemLabel = Just v_ }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Indicates the current item in the breadcrumb path. -}
current :
    M3e.Value.Value { date : M3e.Value.Supported
    , location : M3e.Value.Supported
    , page : M3e.Value.Supported
    , step : M3e.Value.Supported
    , time : M3e.Value.Supported
    , true : M3e.Value.Supported
    }
    -> Builder { a | current : M3e.Build.Internal.Available } s msg
    -> Builder { a | current : M3e.Build.Internal.Used } s msg
current v_ (Builder f_) =
    Builder { f_ | current = Just v_ }


{-| The URL to which the internal breadcrumb link button points. (default: `""`) -}
href :
    String
    -> Builder { a | href : M3e.Build.Internal.Available } s msg
    -> Builder { a | href : M3e.Build.Internal.Used } s msg
href v_ (Builder f_) =
    Builder { f_ | href = Just v_ }


{-| The target of the internal breadcrumb link button. (default: `""`) -}
target :
    String
    -> Builder { a | target : M3e.Build.Internal.Available } s msg
    -> Builder { a | target : M3e.Build.Internal.Used } s msg
target v_ (Builder f_) =
    Builder { f_ | target = Just v_ }


{-| A value indicating whether the internal link target will be downloaded, optionally specifying a file name. (default: `null`) -}
download :
    String
    -> Builder { a | download : M3e.Build.Internal.Available } s msg
    -> Builder { a | download : M3e.Build.Internal.Used } s msg
download v_ (Builder f_) =
    Builder { f_ | download = Just v_ }


{-| The relationship between the internal link target and the document. (default: `""`) -}
rel :
    String
    -> Builder { a | rel : M3e.Build.Internal.Available } s msg
    -> Builder { a | rel : M3e.Build.Internal.Used } s msg
rel v_ (Builder f_) =
    Builder { f_ | rel = Just v_ }


{-| Dispatched when the element is clicked. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg
onClick v_ (Builder f_) =
    Builder { f_ | onClick = Just v_ }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element { text : M3e.Value.Supported
    , icon : M3e.Value.Supported
    } msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }


{-| Set the `icon` slot. Consumes the `icon` slot capability. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg
icon v_ (Builder f_) =
    Builder { f_ | icon = Just v_ }