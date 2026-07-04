module M3e.Build.Skeleton exposing
    ( Builder, AttrCaps, SlotCaps, skeleton, animation, shape
    , loaded, default, build
    )

{-|
The ⑤ Build shape for `<m3e-skeleton>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Skeleton as Skeleton`.

@docs Builder, AttrCaps, SlotCaps, skeleton, animation, shape
@docs loaded, default, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Skeleton
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-skeleton>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { animation : M3e.Build.Internal.Available
    , shape : M3e.Build.Internal.Available
    , loaded : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { animation :
        Maybe (M3e.Value.Value { none : M3e.Value.Supported
        , pulse : M3e.Value.Supported
        , wave : M3e.Value.Supported
        })
    , shape :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , circular : M3e.Value.Supported
        , rounded : M3e.Value.Supported
        , square : M3e.Value.Supported
        })
    , loaded : Maybe Bool
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-skeleton>`. -}
skeleton : Builder AttrCaps SlotCaps msg
skeleton =
    Builder
        { animation = Nothing
        , shape = Nothing
        , loaded = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| The animation effect of the skeleton. (default: `"wave"`) -}
animation :
    M3e.Value.Value { none : M3e.Value.Supported
    , pulse : M3e.Value.Supported
    , wave : M3e.Value.Supported
    }
    -> Builder { a | animation : M3e.Build.Internal.Available } s msg
    -> Builder { a | animation : M3e.Build.Internal.Used } s msg
animation v_ (Builder f_) =
    Builder { f_ | animation = Just v_ }


{-| The shape of the skeleton. (default: `"auto"`) -}
shape :
    M3e.Value.Value { auto : M3e.Value.Supported
    , circular : M3e.Value.Supported
    , rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> Builder { a | shape : M3e.Build.Internal.Available } s msg
    -> Builder { a | shape : M3e.Build.Internal.Used } s msg
shape v_ (Builder f_) =
    Builder { f_ | shape = Just v_ }


{-| Whether the content of the skeleton has been loaded. (default: `false`) -}
loaded :
    Bool
    -> Builder { a | loaded : M3e.Build.Internal.Available } s msg
    -> Builder { a | loaded : M3e.Build.Internal.Used } s msg
loaded v_ (Builder f_) =
    Builder { f_ | loaded = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default : M3e.Element.Element {} msg -> Builder a s msg -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }


{-| Build the `<m3e-skeleton>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | skeleton : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Skeleton.skeleton
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Skeleton.animation v_)
                            ]
                         )
                         f_.animation
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Skeleton.shape v_) ]
                         )
                         f_.shape
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Skeleton.loaded v_) ]
                         )
                         f_.loaded
                      )
                  ]
             )
             (List.concat
                  [ List.map (\el_ -> M3e.Element.toNode el_) f_.default ]
             )
        )