module M3e.Build.BottomSheetTrigger exposing
    ( Builder, AttrCaps, SlotCaps, bottomSheetTrigger, detent, secondary
    , for, default, build
    )

{-|
The ⑤ Build shape for `<m3e-bottom-sheet-trigger>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BottomSheetTrigger as BottomSheetTrigger`.

@docs Builder, AttrCaps, SlotCaps, bottomSheetTrigger, detent, secondary
@docs for, default, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.BottomSheetTrigger
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-bottom-sheet-trigger>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { detent : M3e.Build.Internal.Available
    , secondary : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


type alias Fields msg =
    { detent : Maybe Float
    , secondary : Maybe Bool
    , for : Maybe String
    , default : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-bottom-sheet-trigger>`. -}
bottomSheetTrigger : Builder AttrCaps SlotCaps msg
bottomSheetTrigger =
    Builder
        { detent = Nothing
        , secondary = Nothing
        , for = Nothing
        , default = Nothing
        , phantomMsg_ = Nothing
        }


{-| The zero‑based index of the detent the sheet should open to. -}
detent :
    Float
    -> Builder { a | detent : M3e.Build.Internal.Available } s msg
    -> Builder { a | detent : M3e.Build.Internal.Used } s msg
detent v_ (Builder f_) =
    Builder { f_ | detent = Just v_ }


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`) -}
secondary :
    Bool
    -> Builder { a | secondary : M3e.Build.Internal.Available } s msg
    -> Builder { a | secondary : M3e.Build.Internal.Used } s msg
secondary v_ (Builder f_) =
    Builder { f_ | secondary = Just v_ }


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg
    -> Builder { a | for : M3e.Build.Internal.Used } s msg
for v_ (Builder f_) =
    Builder { f_ | for = Just v_ }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }


{-| Build the `<m3e-bottom-sheet-trigger>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind
        | bottomSheetTrigger : M3e.Value.Supported
    } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.BottomSheetTrigger.bottomSheetTrigger
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.BottomSheetTrigger.detent v_)
                            ]
                         )
                         f_.detent
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.BottomSheetTrigger.secondary v_)
                            ]
                         )
                         f_.secondary
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.BottomSheetTrigger.for v_)
                            ]
                         )
                         f_.for
                      )
                  ]
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map (\v_ -> [ M3e.Element.toNode v_ ]) f_.default)
                  ]
             )
        )