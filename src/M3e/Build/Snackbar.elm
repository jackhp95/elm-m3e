module M3e.Build.Snackbar exposing
    ( Builder, AttrCaps, SlotCaps, snackbar, attr, action
    , closeLabel, dismissible, duration, onBeforetoggle, onToggle, closeIcon
    , build
    )

{-| The Build form for `<m3e-snackbar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Snackbar as Snackbar`.

@docs Builder, AttrCaps, SlotCaps, snackbar, attr, action
@docs closeLabel, dismissible, duration, onBeforetoggle, onToggle, closeIcon
@docs build

-}

import M3e.Build.Internal
import M3e.Html.Snackbar
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-snackbar>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | snackbar : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { action : M3e.Build.Internal.Available
    , closeLabel : M3e.Build.Internal.Available
    , dismissible : M3e.Build.Internal.Available
    , duration : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { closeIcon : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-snackbar>` with the required fields.
-}
snackbar :
    { content : Markup.Element.Element { text : Markup.Kind.Shared } msg }
    -> Builder AttrCaps SlotCaps msg kind
snackbar req_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Snackbar.snackbar
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            [ Markup.Element.toNode req_.content ]
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


{-| The label of the snackbar's action. (default: `""`)
-}
action :
    String
    -> Builder { a | action : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | action : M3e.Build.Internal.Used } s msg kind
action v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Snackbar.action v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`)
-}
closeLabel :
    String
    -> Builder { a | closeLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | closeLabel : M3e.Build.Internal.Used } s msg kind
closeLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Snackbar.closeLabel v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`)
-}
dismissible :
    Bool
    -> Builder { a | dismissible : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | dismissible : M3e.Build.Internal.Used } s msg kind
dismissible v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Snackbar.dismissible v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`)
-}
duration :
    Float
    -> Builder { a | duration : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | duration : M3e.Build.Internal.Used } s msg kind
duration v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Snackbar.duration v_))
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
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Snackbar.onBeforetoggle v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched after the toggle state has changed.
-}
onToggle :
    msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg kind
onToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Snackbar.onToggle v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `close-icon` slot.
-}
closeIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Builder a { s | closeIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | closeIcon : M3e.Build.Internal.Used } msg kind
closeIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "close-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-snackbar>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { snackbar : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
