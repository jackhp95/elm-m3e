module M3e.Build.Collapsible exposing
    ( Builder, AttrCaps, SlotCaps, collapsible, open, orientation
    , noAnimate, onOpening, onOpened, onClosing, onClosed, build
    )

{-|
The ⑤ Build shape for `<m3e-collapsible>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Collapsible as Collapsible`.

@docs Builder, AttrCaps, SlotCaps, collapsible, open, orientation
@docs noAnimate, onOpening, onOpened, onClosing, onClosed, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Collapsible
import M3e.Cem.Html.Collapsible
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-collapsible>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | collapsible : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { open : M3e.Build.Internal.Available
    , orientation : M3e.Build.Internal.Available
    , noAnimate : M3e.Build.Internal.Available
    , onOpening : M3e.Build.Internal.Available
    , onOpened : M3e.Build.Internal.Available
    , onClosing : M3e.Build.Internal.Available
    , onClosed : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-collapsible>`. -}
collapsible : Builder AttrCaps SlotCaps msg kind
collapsible =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Collapsible.collapsible
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether content is visible. (default: `false`) -}
open :
    Bool
    -> Builder { a | open : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | open : M3e.Build.Internal.Used } s msg kind
open v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Collapsible.open v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Orientation of collapsible content. (default: `"vertical"`) -}
orientation :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> Builder { a | orientation : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | orientation : M3e.Build.Internal.Used } s msg kind
orientation v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Collapsible.orientation v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to disable animation. (default: `false`) -}
noAnimate :
    Bool
    -> Builder { a | noAnimate : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | noAnimate : M3e.Build.Internal.Used } s msg kind
noAnimate v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Collapsible.noAnimate v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the collapsible begins to open. -}
onOpening :
    Json.Decode.Decoder msg
    -> Builder { a | onOpening : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onOpening : M3e.Build.Internal.Used } s msg kind
onOpening v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Collapsible.onOpening v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the collapsible has opened. -}
onOpened :
    Json.Decode.Decoder msg
    -> Builder { a | onOpened : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onOpened : M3e.Build.Internal.Used } s msg kind
onOpened v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Collapsible.onOpened v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the collapsible begins to close. -}
onClosing :
    Json.Decode.Decoder msg
    -> Builder { a | onClosing : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClosing : M3e.Build.Internal.Used } s msg kind
onClosing v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Collapsible.onClosing v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the collapsible has closed. -}
onClosed :
    Json.Decode.Decoder msg
    -> Builder { a | onClosed : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClosed : M3e.Build.Internal.Used } s msg kind
onClosed v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Collapsible.onClosed v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-collapsible>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { collapsible : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)