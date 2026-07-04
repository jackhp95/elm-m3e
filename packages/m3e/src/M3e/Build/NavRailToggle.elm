module M3e.Build.NavRailToggle exposing
    ( Builder, AttrCaps, SlotCaps, navRailToggle, for, default
    , build
    )

{-|
The ⑤ Build shape for `<m3e-nav-rail-toggle>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavRailToggle as NavRailToggle`.

@docs Builder, AttrCaps, SlotCaps, navRailToggle, for, default
@docs build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.NavRailToggle
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-nav-rail-toggle>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { for : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


type alias Fields msg =
    { for : Maybe String
    , default : Maybe (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-nav-rail-toggle>`. -}
navRailToggle : Builder AttrCaps SlotCaps msg
navRailToggle =
    Builder { for = Nothing, default = Nothing, phantomMsg_ = Nothing }


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg
    -> Builder { a | for : M3e.Build.Internal.Used } s msg
for v_ (Builder f_) =
    Builder { f_ | for = Just v_ }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element {} msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }


{-| Build the `<m3e-nav-rail-toggle>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | navRailToggle : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.NavRailToggle.navRailToggle
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.NavRailToggle.for v_)
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