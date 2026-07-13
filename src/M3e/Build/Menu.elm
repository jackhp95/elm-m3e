module M3e.Build.Menu exposing
    ( Builder, AttrCaps, SlotCaps, menu, attr, positionX
    , positionY, variant, submenu, onBeforetoggle, onToggle, build
    )

{-| The Build form for `<m3e-menu>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Menu as Menu`.

@docs Builder, AttrCaps, SlotCaps, menu, attr, positionX
@docs positionY, variant, submenu, onBeforetoggle, onToggle, build

-}

import M3e.Build.Internal
import M3e.Html.Menu
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-menu>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | menu : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { positionX : M3e.Build.Internal.Available
    , positionY : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , submenu : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-menu>`.
-}
menu : Builder AttrCaps SlotCaps msg kind
menu =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Menu.menu
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


{-| The position of the menu, on the x-axis. (default: `"after"`)
-}
positionX :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        }
    -> Builder { a | positionX : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | positionX : M3e.Build.Internal.Used } s msg kind
positionX v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Menu.positionX v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The position of the menu, on the y-axis. (default: `"below"`)
-}
positionY :
    M3e.Token.Value { above : M3e.Token.Supported, below : M3e.Token.Supported }
    -> Builder { a | positionY : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | positionY : M3e.Build.Internal.Used } s msg kind
positionY v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Menu.positionY v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the menu. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { standard : M3e.Token.Supported
        , vibrant : M3e.Token.Supported
        }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Menu.variant v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether the menu is a submenu. (default: `false`)
-}
submenu :
    Bool
    -> Builder { a | submenu : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | submenu : M3e.Build.Internal.Used } s msg kind
submenu v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Menu.submenu v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the toggle state changes.
-}
onBeforetoggle :
    msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Used } s msg kind
onBeforetoggle v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Menu.onBeforetoggle v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched after the toggle state has changed.
-}
onToggle :
    (String -> msg)
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg kind
onToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Menu.onToggle v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-menu>` element from a `Builder`.
-}
build : Builder a s msg kind -> Markup.Element.Element { menu : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
