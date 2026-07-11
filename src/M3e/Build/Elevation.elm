module M3e.Build.Elevation exposing
    ( Builder, AttrCaps, SlotCaps, elevation, attr, disabled
    , for, level, build
    )

{-| The Build form for `<m3e-elevation>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Elevation as Elevation`.

@docs Builder, AttrCaps, SlotCaps, elevation, attr, disabled
@docs for, level, build

-}

import M3e.Build.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr.Internal
import M3e.Html.Elevation
import M3e.Node
import M3e.Token


{-| Phantom-typed opaque builder for `<m3e-elevation>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | elevation : M3e.Token.Supported
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , level : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-elevation>`.
-}
elevation : Builder AttrCaps SlotCaps msg kind
elevation =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Elevation.elevation
                    (List.map M3e.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    M3e.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether hover and press events will not trigger changes in elevation, when attached to an interactive element. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Elevation.disabled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Elevation.for v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The level at which to visually depict elevation. (default: `null`)
-}
level :
    Int
    -> Builder { a | level : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | level : M3e.Build.Internal.Used } s msg kind
level v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Elevation.level v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-elevation>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> M3e.Element.Element { elevation : M3e.Token.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
