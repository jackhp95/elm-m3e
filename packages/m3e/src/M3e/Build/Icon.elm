module M3e.Build.Icon exposing
    ( Builder, AttrCaps, SlotCaps, icon, filled, grade
    , opticalSize, name, variant, weight, build
    )

{-|
The ⑤ Build shape for `<m3e-icon>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Icon as Icon`.

@docs Builder, AttrCaps, SlotCaps, icon, filled, grade
@docs opticalSize, name, variant, weight, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Icon
import M3e.Element
import M3e.Node
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


{-| Build the `<m3e-icon>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | icon : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Icon.icon (List.map M3e.Cem.Attr.forget erased_) ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Icon.filled v_) ]
                         )
                         f_.filled
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ -> [ M3e.Cem.Attr.forget (M3e.Cem.Icon.grade v_) ]
                         )
                         f_.grade
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Icon.opticalSize v_)
                            ]
                         )
                         f_.opticalSize
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ -> [ M3e.Cem.Attr.forget (M3e.Cem.Icon.name v_) ])
                         f_.name
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Icon.variant v_) ]
                         )
                         f_.variant
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Icon.weight v_) ]
                         )
                         f_.weight
                      )
                  ]
             )
             (List.concat [])
        )