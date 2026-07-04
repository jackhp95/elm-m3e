module M3e.Build.Breadcrumb exposing
    ( Builder, AttrCaps, SlotCaps, breadcrumb, wrap, separator
    , default
    )

{-|
The ⑤ Build shape for `<m3e-breadcrumb>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Breadcrumb as Breadcrumb`.

@docs Builder, AttrCaps, SlotCaps, breadcrumb, wrap, separator
@docs default
-}


import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-breadcrumb>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { wrap : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { separator : M3e.Build.Internal.Available
    , default : M3e.Build.Internal.NotFilled
    }


type alias Fields msg =
    { wrap : Maybe Bool
    , separator : Maybe (M3e.Element.Element {} msg)
    , default :
        List (M3e.Element.Element { breadcrumbItem : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-breadcrumb>`. -}
breadcrumb : Builder AttrCaps SlotCaps msg
breadcrumb =
    Builder
        { wrap = Nothing
        , separator = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| Whether items wrap to a new line. (default: `false`) -}
wrap :
    Bool
    -> Builder { a | wrap : M3e.Build.Internal.Available } s msg
    -> Builder { a | wrap : M3e.Build.Internal.Used } s msg
wrap v_ (Builder f_) =
    Builder { f_ | wrap = Just v_ }


{-| Set the `separator` slot. Consumes the `separator` slot capability. -}
separator :
    M3e.Element.Element {} msg
    -> Builder a { s | separator : M3e.Build.Internal.Available } msg
    -> Builder a { s | separator : M3e.Build.Internal.Used } msg
separator v_ (Builder f_) =
    Builder { f_ | separator = Just v_ }


{-| Add an element to the required `unnamed` slot. Must be called at least once before `build`. -}
default :
    M3e.Element.Element { breadcrumbItem : M3e.Value.Supported } msg
    -> Builder a { s | default : filled } msg
    -> Builder a { s | default : M3e.Build.Internal.Filled } msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }