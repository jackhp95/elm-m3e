module M3e.Build.Heading exposing
    ( Builder, AttrCaps, SlotCaps, heading, emphasized, level
    , size, variant, build
    )

{-|
The ⑤ Build shape for `<m3e-heading>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Heading as Heading`.

@docs Builder, AttrCaps, SlotCaps, heading, emphasized, level
@docs size, variant, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Heading
import M3e.Element
import M3e.Node
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


{-| Build the `<m3e-heading>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | heading : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Heading.heading
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Heading.emphasized v_)
                            ]
                         )
                         f_.emphasized
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Heading.level v_) ]
                         )
                         f_.level
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Heading.size v_) ]
                         )
                         f_.size
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Heading.variant v_) ]
                         )
                         f_.variant
                      )
                  ]
             )
             (List.concat [ [ M3e.Element.toNode f_.content ] ])
        )