module M3e.Build.Tabs exposing
    ( Builder, AttrCaps, SlotCaps, tabs, disablePagination, headerPosition
    , nextPageLabel, previousPageLabel, stretch, variant, onChange, onBeforeinput, onInput
    , build
    )

{-|
The ⑤ Build shape for `<m3e-tabs>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Tabs as Tabs`.

@docs Builder, AttrCaps, SlotCaps, tabs, disablePagination, headerPosition
@docs nextPageLabel, previousPageLabel, stretch, variant, onChange, onBeforeinput
@docs onInput, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.Tabs
import M3e.Cem.Tabs
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-tabs>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | tabs : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disablePagination : M3e.Build.Internal.Available
    , headerPosition : M3e.Build.Internal.Available
    , nextPageLabel : M3e.Build.Internal.Available
    , previousPageLabel : M3e.Build.Internal.Available
    , stretch : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { nextIcon : M3e.Build.Internal.Available
    , prevIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-tabs>`. -}
tabs : Builder AttrCaps SlotCaps msg kind
tabs =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Tabs.tabs (List.map M3e.Cem.Attr.forget erased_) ch_
             )
             []
             []
        )


{-| Whether scroll buttons are disabled. -}
disablePagination :
    M3e.Value.Value { true : M3e.Value.Supported
    , false : M3e.Value.Supported
    , auto : M3e.Value.Supported
    }
    -> Builder { a
        | disablePagination : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { a | disablePagination : M3e.Build.Internal.Used } s msg kind
disablePagination v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Tabs.disablePagination v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The position of the tab headers. (default: `"before"`) -}
headerPosition :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> Builder { a | headerPosition : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | headerPosition : M3e.Build.Internal.Used } s msg kind
headerPosition v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Tabs.headerPosition v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel :
    String
    -> Builder { a | nextPageLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | nextPageLabel : M3e.Build.Internal.Used } s msg kind
nextPageLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Tabs.nextPageLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel :
    String
    -> Builder { a
        | previousPageLabel : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { a | previousPageLabel : M3e.Build.Internal.Used } s msg kind
previousPageLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Tabs.previousPageLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether tabs are stretched to fill the header. (default: `false`) -}
stretch :
    Bool
    -> Builder { a | stretch : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | stretch : M3e.Build.Internal.Used } s msg kind
stretch v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Tabs.stretch v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the tabs. (default: `"secondary"`) -}
variant :
    M3e.Value.Value { primary : M3e.Value.Supported
    , secondary : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Tabs.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected tab changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Tabs.onChange v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the selected state of a tab changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Tabs.onBeforeinput v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state of a tab changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Tabs.onInput v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-tabs>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { tabs : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)