module M3e.Build.Icon exposing
    ( Builder, AttrCaps, SlotCaps, icon, filled, grade
    , opticalSize, name, variant, weight
    )

{-|
The ⑤ Build shape for `<m3e-icon>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Icon as Icon`.

@docs Builder, AttrCaps, SlotCaps, icon, filled, grade
@docs opticalSize, name, variant, weight
-}


import M3e.Build.Internal
import M3e.Value


{-| Opaque builder for `<m3e-icon>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { filled : M3e.Build.Internal.Available
    , grade : M3e.Build.Internal.Available
    , opticalSize : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , weight : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { filled : Maybe Bool
    , grade :
        Maybe (M3e.Value.Value { high : M3e.Value.Supported
        , low : M3e.Value.Supported
        , medium : M3e.Value.Supported
        })
    , opticalSize : Maybe Float
    , name : Maybe String
    , variant :
        Maybe (M3e.Value.Value { outlined : M3e.Value.Supported
        , rounded : M3e.Value.Supported
        , sharp : M3e.Value.Supported
        })
    , weight : Maybe String
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-icon>`. -}
icon : Builder AttrCaps SlotCaps msg
icon =
    Builder
        { filled = Nothing
        , grade = Nothing
        , opticalSize = Nothing
        , name = Nothing
        , variant = Nothing
        , weight = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether the icon is filled. (default: `false`) -}
filled :
    Bool
    -> Builder { a | filled : M3e.Build.Internal.Available } s msg
    -> Builder { a | filled : M3e.Build.Internal.Used } s msg
filled v_ (Builder f_) =
    Builder { f_ | filled = Just v_ }


{-| The grade of the icon. (default: `"medium"`) -}
grade :
    M3e.Value.Value { high : M3e.Value.Supported
    , low : M3e.Value.Supported
    , medium : M3e.Value.Supported
    }
    -> Builder { a | grade : M3e.Build.Internal.Available } s msg
    -> Builder { a | grade : M3e.Build.Internal.Used } s msg
grade v_ (Builder f_) =
    Builder { f_ | grade = Just v_ }


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`) -}
opticalSize :
    Float
    -> Builder { a | opticalSize : M3e.Build.Internal.Available } s msg
    -> Builder { a | opticalSize : M3e.Build.Internal.Used } s msg
opticalSize v_ (Builder f_) =
    Builder { f_ | opticalSize = Just v_ }


{-| The name of the icon. (default: `""`) -}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg
    -> Builder { a | name : M3e.Build.Internal.Used } s msg
name v_ (Builder f_) =
    Builder { f_ | name = Just v_ }


{-| The appearance variant of the icon. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { outlined : M3e.Value.Supported
    , rounded : M3e.Value.Supported
    , sharp : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`) -}
weight :
    String
    -> Builder { a | weight : M3e.Build.Internal.Available } s msg
    -> Builder { a | weight : M3e.Build.Internal.Used } s msg
weight v_ (Builder f_) =
    Builder { f_ | weight = Just v_ }