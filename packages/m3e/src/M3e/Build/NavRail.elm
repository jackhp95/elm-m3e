module M3e.Build.NavRail exposing
    ( Builder, AttrCaps, SlotCaps, navRail, mode, onBeforeinput
    , onInput, onChange, build
    )

{-|
The ⑤ Build shape for `<m3e-nav-rail>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavRail as NavRail`.

@docs Builder, AttrCaps, SlotCaps, navRail, mode, onBeforeinput
@docs onInput, onChange, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.NavRail
import M3e.Cem.NavRail
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-nav-rail>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | navRail : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { mode : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-nav-rail>`. -}
navRail : Builder AttrCaps SlotCaps msg kind
navRail =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.NavRail.navRail
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The mode in which items in the rail are presented. (default: `"compact"`) -}
mode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , compact : M3e.Value.Supported
    , expanded : M3e.Value.Supported
    }
    -> Builder { a | mode : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | mode : M3e.Build.Internal.Used } s msg kind
mode v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.NavRail.mode v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the selected state of an item changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.NavRail.onBeforeinput
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state of an item changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.NavRail.onInput
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state of an item changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.NavRail.onChange
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-nav-rail>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { navRail : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)