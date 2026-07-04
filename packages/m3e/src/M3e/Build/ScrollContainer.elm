module M3e.Build.ScrollContainer exposing
    ( Builder, AttrCaps, SlotCaps, scrollContainer, dividers, thin
    , default, build
    )

{-|
The ⑤ Build shape for `<m3e-scroll-container>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ScrollContainer as ScrollContainer`.

@docs Builder, AttrCaps, SlotCaps, scrollContainer, dividers, thin
@docs default, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.ScrollContainer
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-scroll-container>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { dividers : M3e.Build.Internal.Available
    , thin : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { dividers :
        Maybe (M3e.Value.Value { above : M3e.Value.Supported
        , aboveBelow : M3e.Value.Supported
        , below : M3e.Value.Supported
        , none : M3e.Value.Supported
        })
    , thin : Maybe Bool
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-scroll-container>`. -}
scrollContainer : Builder AttrCaps SlotCaps msg
scrollContainer =
    Builder
        { dividers = Nothing
        , thin = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| The dividers used to separate scrollable content. (default: `"above-below"`) -}
dividers :
    M3e.Value.Value { above : M3e.Value.Supported
    , aboveBelow : M3e.Value.Supported
    , below : M3e.Value.Supported
    , none : M3e.Value.Supported
    }
    -> Builder { a | dividers : M3e.Build.Internal.Available } s msg
    -> Builder { a | dividers : M3e.Build.Internal.Used } s msg
dividers v_ (Builder f_) =
    Builder { f_ | dividers = Just v_ }


{-| Whether to present thin scrollbars. (default: `false`) -}
thin :
    Bool
    -> Builder { a | thin : M3e.Build.Internal.Available } s msg
    -> Builder { a | thin : M3e.Build.Internal.Used } s msg
thin v_ (Builder f_) =
    Builder { f_ | thin = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default : M3e.Element.Element {} msg -> Builder a s msg -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Build the `<m3e-scroll-container>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | scrollContainer : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ScrollContainer.scrollContainer
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.ScrollContainer.dividers v_)
                            ]
                         )
                         f_.dividers
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.ScrollContainer.thin v_)
                            ]
                         )
                         f_.thin
                      )
                  ]
             )
             (List.concat
                  [ List.map (\el_ -> M3e.Element.toNode el_) f_.default ]
             )
        )