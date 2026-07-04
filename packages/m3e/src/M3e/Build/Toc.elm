module M3e.Build.Toc exposing
    ( Builder, AttrCaps, SlotCaps, toc, for, maxDepth
    , default, overline, title, build
    )

{-|
The ⑤ Build shape for `<m3e-toc>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Toc as Toc`.

@docs Builder, AttrCaps, SlotCaps, toc, for, maxDepth
@docs default, overline, title, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Toc
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-toc>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { for : M3e.Build.Internal.Available
    , maxDepth : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , overline : M3e.Build.Internal.Available
    , title : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { for : Maybe String
    , maxDepth : Maybe Float
    , default : Maybe (M3e.Element.Element {} msg)
    , overline : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , title : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-toc>`. -}
toc : Builder AttrCaps SlotCaps msg
toc =
    Builder
        { for = Nothing
        , maxDepth = Nothing
        , default = Nothing
        , overline = Nothing
        , title = Nothing
        , phantomMsg_ = Nothing
        }


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg
    -> Builder { a | for : M3e.Build.Internal.Used } s msg
for v_ (Builder f_) =
    Builder { f_ | for = Just v_ }


{-| The maximum depth of the table of contents. (default: `2`) -}
maxDepth :
    Float
    -> Builder { a | maxDepth : M3e.Build.Internal.Available } s msg
    -> Builder { a | maxDepth : M3e.Build.Internal.Used } s msg
maxDepth v_ (Builder f_) =
    Builder { f_ | maxDepth = Just v_ }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element {} msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }


{-| Set the `overline` slot. Consumes the `overline` slot capability. -}
overline :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> Builder a { s | overline : M3e.Build.Internal.Available } msg
    -> Builder a { s | overline : M3e.Build.Internal.Used } msg
overline v_ (Builder f_) =
    Builder { f_ | overline = Just v_ }


{-| Set the `title` slot. Consumes the `title` slot capability. -}
title :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> Builder a { s | title : M3e.Build.Internal.Available } msg
    -> Builder a { s | title : M3e.Build.Internal.Used } msg
title v_ (Builder f_) =
    Builder { f_ | title = Just v_ }


{-| Build the `<m3e-toc>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | toc : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Toc.toc (List.map M3e.Cem.Attr.forget erased_) ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ -> [ M3e.Cem.Attr.forget (M3e.Cem.Toc.for v_) ])
                         f_.for
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Toc.maxDepth v_) ]
                         )
                         f_.maxDepth
                      )
                  ]
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map (\v_ -> [ M3e.Element.toNode v_ ]) f_.default)
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "overline" v_)
                            ]
                         )
                         f_.overline
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "title" v_)
                            ]
                         )
                         f_.title
                      )
                  ]
             )
        )