module M3e.Build.BreadcrumbItemButton exposing
    ( Builder, AttrCaps, SlotCaps, breadcrumbItemButton, attr, current
    , href, target, rel, download, disabled, onClick
    , icon, child, build
    )

{-| The Build form for `<m3e-breadcrumb-item-button>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BreadcrumbItemButton as BreadcrumbItemButton`.

@docs Builder, AttrCaps, SlotCaps, breadcrumbItemButton, attr, current
@docs href, target, rel, download, disabled, onClick
@docs icon, child, build

-}

import M3e.Build.Internal
import M3e.Html.BreadcrumbItemButton
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-breadcrumb-item-button>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | breadcrumbItemButton : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { current : M3e.Build.Internal.Available
    , href : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available
    , unnamed : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-breadcrumb-item-button>`.
-}
breadcrumbItemButton : Builder AttrCaps SlotCaps msg kind
breadcrumbItemButton =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.BreadcrumbItemButton.breadcrumbItemButton
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


{-| Indicates the current item in the breadcrumb path.
-}
current :
    M3e.Token.Value
        { date : M3e.Token.Supported
        , location : M3e.Token.Supported
        , page : M3e.Token.Supported
        , step : M3e.Token.Supported
        , time : M3e.Token.Supported
        , true : M3e.Token.Supported
        }
    -> Builder { a | current : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | current : M3e.Build.Internal.Used } s msg kind
current v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.BreadcrumbItemButton.current v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The URL to which the link button points. (default: `""`)
-}
href :
    String
    -> Builder { a | href : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | href : M3e.Build.Internal.Used } s msg kind
href v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.BreadcrumbItemButton.href v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The target of the link button. (default: `""`)
-}
target :
    String
    -> Builder { a | target : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | target : M3e.Build.Internal.Used } s msg kind
target v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.BreadcrumbItemButton.target v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel :
    String
    -> Builder { a | rel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | rel : M3e.Build.Internal.Used } s msg kind
rel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.BreadcrumbItemButton.rel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download :
    String
    -> Builder { a | download : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | download : M3e.Build.Internal.Used } s msg kind
download v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.BreadcrumbItemButton.download v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.BreadcrumbItemButton.disabled v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Listen for `click` events.
-}
onClick :
    msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.BreadcrumbItemButton.onClick v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `icon` slot.
-}
icon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg kind
icon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot.
-}
child :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , icon : Markup.Kind.Shared
        }
        msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode el_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-breadcrumb-item-button>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { breadcrumbItemButton : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
