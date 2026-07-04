module M3e.Build.Heading exposing
    ( Builder, AttrCaps, SlotCaps, heading, emphasized, level
    , size, variant
    )

{-|
The ⑤ Build shape for `<m3e-heading>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Heading as Heading`.

@docs Builder, AttrCaps, SlotCaps, heading, emphasized, level
@docs size, variant
-}


import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-heading>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { emphasized : M3e.Build.Internal.Available
    , level : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
    , emphasized : Maybe Bool
    , level : Maybe String
    , size :
        Maybe (M3e.Value.Value { large : M3e.Value.Supported
        , medium : M3e.Value.Supported
        , small : M3e.Value.Supported
        })
    , variant :
        Maybe (M3e.Value.Value { display : M3e.Value.Supported
        , headline : M3e.Value.Supported
        , label : M3e.Value.Supported
        , title : M3e.Value.Supported
        })
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-heading>` with the required fields. -}
heading :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg
heading req_ =
    Builder
        { content = req_.content
        , emphasized = Nothing
        , level = Nothing
        , size = Nothing
        , variant = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether the heading uses an emphasized typescale. (default: `false`) -}
emphasized :
    Bool
    -> Builder { a | emphasized : M3e.Build.Internal.Available } s msg
    -> Builder { a | emphasized : M3e.Build.Internal.Used } s msg
emphasized v_ (Builder f_) =
    Builder { f_ | emphasized = Just v_ }


{-| The accessibility level of the heading. -}
level :
    String
    -> Builder { a | level : M3e.Build.Internal.Available } s msg
    -> Builder { a | level : M3e.Build.Internal.Used } s msg
level v_ (Builder f_) =
    Builder { f_ | level = Just v_ }


{-| The size of the heading. (default: `"medium"`) -}
size :
    M3e.Value.Value { large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg
    -> Builder { a | size : M3e.Build.Internal.Used } s msg
size v_ (Builder f_) =
    Builder { f_ | size = Just v_ }


{-| The appearance variant of the heading. (default: `"display"`) -}
variant :
    M3e.Value.Value { display : M3e.Value.Supported
    , headline : M3e.Value.Supported
    , label : M3e.Value.Supported
    , title : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }