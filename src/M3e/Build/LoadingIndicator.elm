module M3e.Build.LoadingIndicator exposing
    ( Builder, AttrCaps, SlotCaps, loadingIndicator, attr, variant
    , build
    )

{-| The Build form for `<m3e-loading-indicator>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.LoadingIndicator as LoadingIndicator`.

@docs Builder, AttrCaps, SlotCaps, loadingIndicator, attr, variant
@docs build

-}

import M3e.Build.Internal
import M3e.Html.LoadingIndicator
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-loading-indicator>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | loadingIndicator : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { variant : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-loading-indicator>`.
-}
loadingIndicator : Builder AttrCaps SlotCaps msg kind
loadingIndicator =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.LoadingIndicator.loadingIndicator
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    Markup.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the indicator. (default: `"uncontained"`)
-}
variant :
    M3e.Token.Value
        { contained : M3e.Token.Supported
        , uncontained : M3e.Token.Supported
        }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.LoadingIndicator.variant v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-loading-indicator>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { loadingIndicator : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
