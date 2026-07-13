module M3e.Build.Icon exposing
    ( Builder, AttrCaps, SlotCaps, icon, attr, filled
    , grade, opticalSize, name, variant, weight, build
    )

{-| The Build form for `<m3e-icon>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Icon as Icon`.

@docs Builder, AttrCaps, SlotCaps, icon, attr, filled
@docs grade, opticalSize, name, variant, weight, build

-}

import M3e.Build.Internal
import M3e.Html.Icon
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-icon>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | sharedIcon : Markup.Kind.Shared
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { filled : M3e.Build.Internal.Available
    , grade : M3e.Build.Internal.Available
    , opticalSize : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , weight : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-icon>`.
-}
icon : Builder AttrCaps SlotCaps msg kind
icon =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Icon.icon
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


{-| Whether the icon is filled. (default: `false`)
-}
filled :
    Bool
    -> Builder { a | filled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | filled : M3e.Build.Internal.Used } s msg kind
filled v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Icon.filled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The grade of the icon. (default: `"medium"`)
-}
grade :
    M3e.Token.Value
        { high : M3e.Token.Supported
        , low : M3e.Token.Supported
        , medium : M3e.Token.Supported
        }
    -> Builder { a | grade : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | grade : M3e.Build.Internal.Used } s msg kind
grade v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Icon.grade v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`)
-}
opticalSize :
    Float
    -> Builder { a | opticalSize : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | opticalSize : M3e.Build.Internal.Used } s msg kind
opticalSize v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Icon.opticalSize v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The name of the icon. (default: `""`)
-}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | name : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Icon.name v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the icon. (default: `"outlined"`)
-}
variant :
    M3e.Token.Value
        { outlined : M3e.Token.Supported
        , rounded : M3e.Token.Supported
        , sharp : M3e.Token.Supported
        }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Icon.variant v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`)
-}
weight :
    Int
    -> Builder { a | weight : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | weight : M3e.Build.Internal.Used } s msg kind
weight v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Icon.weight v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-icon>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
