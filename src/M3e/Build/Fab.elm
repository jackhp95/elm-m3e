module M3e.Build.Fab exposing
    ( Builder, AttrCaps, SlotCaps, fab, attr, disabled
    , disabledInteractive, extended, lowered, name, size, type_
    , value, variant, label, closeIcon, build
    )

{-| The Build form for `<m3e-fab>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Fab as Fab`.

@docs Builder, AttrCaps, SlotCaps, fab, attr, disabled
@docs disabledInteractive, extended, lowered, name, size, type_
@docs value, variant, label, closeIcon, build

-}

import M3e.Action
import M3e.Build.Internal
import M3e.Html.Fab
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-fab>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | fab : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , disabledInteractive : M3e.Build.Internal.Available
    , extended : M3e.Build.Internal.Available
    , lowered : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    , type_ : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { label : M3e.Build.Internal.Available
    , closeIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-fab>` with the required fields.
-}
fab :
    { content : Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    , action :
        M3e.Action.Action
            { click : M3e.Token.Supported
            , link : M3e.Token.Supported
            , menuTrigger : M3e.Token.Supported
            , dialogTrigger : M3e.Token.Supported
            , fabMenuTrigger : M3e.Token.Supported
            , bottomSheetTrigger : M3e.Token.Supported
            , navRailToggle : M3e.Token.Supported
            , drawerToggle : M3e.Token.Supported
            , datepickerToggle : M3e.Token.Supported
            , dialogAction : M3e.Token.Supported
            , bottomSheetAction : M3e.Token.Supported
            , richTooltipAction : M3e.Token.Supported
            , stepperReset : M3e.Token.Supported
            , stepperPrevious : M3e.Token.Supported
            }
            msg
    }
    -> Builder AttrCaps SlotCaps msg kind
fab req_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Fab.fab
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            (List.map
                Markup.Html.Attr.Internal.forget
                (M3e.Action.toAttrs req_.action)
            )
            [ M3e.Action.wrapContent
                req_.action
                (Markup.Element.toNode req_.content)
            ]
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


{-| Whether the element is disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Fab.disabled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive :
    Bool
    ->
        Builder
            { a
                | disabledInteractive : M3e.Build.Internal.Available
            }
            s
            msg
            kind
    -> Builder { a | disabledInteractive : M3e.Build.Internal.Used } s msg kind
disabledInteractive v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Fab.disabledInteractive v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the button is extended to show the label. (default: `false`)
-}
extended :
    Bool
    -> Builder { a | extended : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | extended : M3e.Build.Internal.Used } s msg kind
extended v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Fab.extended v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether to present a lowered elevation. (default: `false`)
-}
lowered :
    Bool
    -> Builder { a | lowered : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | lowered : M3e.Build.Internal.Used } s msg kind
lowered v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Fab.lowered v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form.
-}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | name : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Fab.name v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The size of the button. (default: `"medium"`)
-}
size :
    M3e.Token.Value
        { large : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , small : M3e.Token.Supported
        }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | size : M3e.Build.Internal.Used } s msg kind
size v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Fab.size v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The type of the element. (default: `"button"`)
-}
type_ :
    M3e.Token.Value
        { button : M3e.Token.Supported
        , reset : M3e.Token.Supported
        , submit : M3e.Token.Supported
        }
    -> Builder { a | type_ : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | type_ : M3e.Build.Internal.Used } s msg kind
type_ v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Fab.type_ v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The value associated with the element's name when it's submitted with form data.
-}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Fab.value v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the button. (default: `"primary-container"`)
-}
variant :
    M3e.Token.Value
        { primary : M3e.Token.Supported
        , primaryContainer : M3e.Token.Supported
        , secondary : M3e.Token.Supported
        , secondaryContainer : M3e.Token.Supported
        , surface : M3e.Token.Supported
        , tertiary : M3e.Token.Supported
        , tertiaryContainer : M3e.Token.Supported
        }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Fab.variant v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `label` slot.
-}
label :
    Markup.Element.Element { sharedText : Markup.Kind.Shared } msg
    -> Builder a { s | label : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | label : M3e.Build.Internal.Used } msg kind
label el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "label" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `close-icon` slot.
-}
closeIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Builder a { s | closeIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | closeIcon : M3e.Build.Internal.Used } msg kind
closeIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "close-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-fab>` element from a `Builder`.
-}
build : Builder a s msg kind -> Markup.Element.Element { fab : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
