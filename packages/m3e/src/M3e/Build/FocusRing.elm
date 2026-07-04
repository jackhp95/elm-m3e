module M3e.Build.FocusRing exposing
    ( Builder, AttrCaps, SlotCaps, focusRing, disabled, inward
    , for, build
    )

{-|
The ⑤ Build shape for `<m3e-focus-ring>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FocusRing as FocusRing`.

@docs Builder, AttrCaps, SlotCaps, focusRing, disabled, inward
@docs for, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.FocusRing
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-focus-ring>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , inward : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { disabled : Maybe Bool
    , inward : Maybe Bool
    , for : Maybe String
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-focus-ring>`. -}
focusRing : Builder AttrCaps SlotCaps msg
focusRing =
    Builder
        { disabled = Nothing
        , inward = Nothing
        , for = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether the focus events will not trigger the focus ring.
Focus rings can be still controlled manually by using the `show` and `hide` methods. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Whether the focus ring animates inward instead of outward. (default: `false`) -}
inward :
    Bool
    -> Builder { a | inward : M3e.Build.Internal.Available } s msg
    -> Builder { a | inward : M3e.Build.Internal.Used } s msg
inward v_ (Builder f_) =
    Builder { f_ | inward = Just v_ }


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg
    -> Builder { a | for : M3e.Build.Internal.Used } s msg
for v_ (Builder f_) =
    Builder { f_ | for = Just v_ }


{-| Build the `<m3e-focus-ring>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | focusRing : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.FocusRing.focusRing
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.FocusRing.disabled v_)
                            ]
                         )
                         f_.disabled
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.FocusRing.inward v_)
                            ]
                         )
                         f_.inward
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.FocusRing.for v_) ]
                         )
                         f_.for
                      )
                  ]
             )
             (List.concat [])
        )