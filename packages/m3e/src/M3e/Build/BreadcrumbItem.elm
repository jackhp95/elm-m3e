module M3e.Build.BreadcrumbItem exposing
    ( Builder, AttrCaps, SlotCaps, breadcrumbItem, itemLabel, disabled
    , current, href, target, download, rel, onClick, build
    )

{-|
The ⑤ Build shape for `<m3e-breadcrumb-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BreadcrumbItem as BreadcrumbItem`.

@docs Builder, AttrCaps, SlotCaps, breadcrumbItem, itemLabel, disabled
@docs current, href, target, download, rel, onClick
@docs build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.BreadcrumbItem
import M3e.Cem.Html.BreadcrumbItem
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-breadcrumb-item>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | breadcrumbItem : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { itemLabel : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , current : M3e.Build.Internal.Available
    , href : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , icon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-breadcrumb-item>`. -}
breadcrumbItem : Builder AttrCaps SlotCaps msg kind
breadcrumbItem =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.BreadcrumbItem.breadcrumbItem
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The accessible label given to the item's internal button. (default: `""`) -}
itemLabel :
    String
    -> Builder { a | itemLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | itemLabel : M3e.Build.Internal.Used } s msg kind
itemLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.BreadcrumbItem.itemLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.BreadcrumbItem.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Indicates the current item in the breadcrumb path. -}
current :
    M3e.Value.Value { date : M3e.Value.Supported
    , location : M3e.Value.Supported
    , page : M3e.Value.Supported
    , step : M3e.Value.Supported
    , time : M3e.Value.Supported
    , true : M3e.Value.Supported
    }
    -> Builder { a | current : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | current : M3e.Build.Internal.Used } s msg kind
current v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.BreadcrumbItem.current v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The URL to which the internal breadcrumb link button points. (default: `""`) -}
href :
    String
    -> Builder { a | href : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | href : M3e.Build.Internal.Used } s msg kind
href v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.BreadcrumbItem.href v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The target of the internal breadcrumb link button. (default: `""`) -}
target :
    String
    -> Builder { a | target : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | target : M3e.Build.Internal.Used } s msg kind
target v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.BreadcrumbItem.target v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether the internal link target will be downloaded, optionally specifying a file name. (default: `null`) -}
download :
    String
    -> Builder { a | download : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | download : M3e.Build.Internal.Used } s msg kind
download v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.BreadcrumbItem.download v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The relationship between the internal link target and the document. (default: `""`) -}
rel :
    String
    -> Builder { a | rel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | rel : M3e.Build.Internal.Used } s msg kind
rel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.BreadcrumbItem.rel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the element is clicked. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.BreadcrumbItem.onClick v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-breadcrumb-item>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { breadcrumbItem : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)