module M3e.Build.Snackbar exposing
    ( Builder, AttrCaps, SlotCaps, snackbar, action, closeLabel
    , dismissible, duration, onBeforetoggle, onToggle, build
    )

{-|
The ⑤ Build shape for `<m3e-snackbar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Snackbar as Snackbar`.

@docs Builder, AttrCaps, SlotCaps, snackbar, action, closeLabel
@docs dismissible, duration, onBeforetoggle, onToggle, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.Snackbar
import M3e.Cem.Snackbar
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-snackbar>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | snackbar : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { action : M3e.Build.Internal.Available
    , closeLabel : M3e.Build.Internal.Available
    , dismissible : M3e.Build.Internal.Available
    , duration : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { closeIcon : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-snackbar>` with the required fields. -}
snackbar :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg kind
snackbar req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Snackbar.snackbar
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.map M3e.Cem.Attr.forget [])
             [ M3e.Element.toNode req_.content ]
        )


{-| The label of the snackbar's action. (default: `""`) -}
action :
    String
    -> Builder { a | action : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | action : M3e.Build.Internal.Used } s msg kind
action v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Snackbar.action v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`) -}
closeLabel :
    String
    -> Builder { a | closeLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | closeLabel : M3e.Build.Internal.Used } s msg kind
closeLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Snackbar.closeLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`) -}
dismissible :
    Bool
    -> Builder { a | dismissible : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | dismissible : M3e.Build.Internal.Used } s msg kind
dismissible v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Snackbar.dismissible v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`) -}
duration :
    Float
    -> Builder { a | duration : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | duration : M3e.Build.Internal.Used } s msg kind
duration v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Snackbar.duration v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the toggle state changes. -}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Used } s msg kind
onBeforetoggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute
                       M3e.Cem.Html.Snackbar.onBeforetoggle
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched after the toggle state has changed. -}
onToggle :
    Json.Decode.Decoder msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg kind
onToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Snackbar.onToggle v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-snackbar>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { snackbar : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)