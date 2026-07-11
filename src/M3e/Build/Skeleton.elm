module M3e.Build.Skeleton exposing
    ( Builder, AttrCaps, SlotCaps, skeleton, attr, animation
    , shape, loaded, build
    )

{-| The Build form for `<m3e-skeleton>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Skeleton as Skeleton`.

@docs Builder, AttrCaps, SlotCaps, skeleton, attr, animation
@docs shape, loaded, build

-}

import M3e.Build.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr.Internal
import M3e.Html.Skeleton
import M3e.Node
import M3e.Token


{-| Phantom-typed opaque builder for `<m3e-skeleton>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | skeleton : M3e.Token.Supported
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { animation : M3e.Build.Internal.Available
    , shape : M3e.Build.Internal.Available
    , loaded : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-skeleton>`.
-}
skeleton : Builder AttrCaps SlotCaps msg kind
skeleton =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Skeleton.skeleton
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


{-| The animation effect of the skeleton. (default: `"wave"`)
-}
animation :
    M3e.Token.Value
        { none : M3e.Token.Supported
        , pulse : M3e.Token.Supported
        , wave : M3e.Token.Supported
        }
    -> Builder { a | animation : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | animation : M3e.Build.Internal.Used } s msg kind
animation v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Skeleton.animation v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The shape of the skeleton. (default: `"auto"`)
-}
shape :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , circular : M3e.Token.Supported
        , rounded : M3e.Token.Supported
        , square : M3e.Token.Supported
        }
    -> Builder { a | shape : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | shape : M3e.Build.Internal.Used } s msg kind
shape v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Skeleton.shape v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the content of the skeleton has been loaded. (default: `false`)
-}
loaded :
    Bool
    -> Builder { a | loaded : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | loaded : M3e.Build.Internal.Used } s msg kind
loaded v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Skeleton.loaded v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-skeleton>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> M3e.Element.Element { skeleton : M3e.Token.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
