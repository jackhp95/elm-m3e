module M3e.Build.Step exposing
    ( Builder, AttrCaps, SlotCaps, step, attr, completed
    , disabled, editable, for, optional, selected, invalid
    , onBeforeinput, onInput, onChange, onClick, icon, doneIcon
    , editIcon, errorIcon, hint, error, build
    )

{-| The Build form for `<m3e-step>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Step as Step`.

@docs Builder, AttrCaps, SlotCaps, step, attr, completed
@docs disabled, editable, for, optional, selected, invalid
@docs onBeforeinput, onInput, onChange, onClick, icon, doneIcon
@docs editIcon, errorIcon, hint, error, build

-}

import M3e.Build.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr.Internal
import M3e.Html.Step
import M3e.Node
import M3e.Token


{-| Phantom-typed opaque builder for `<m3e-step>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | step : M3e.Token.Supported
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { completed : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , editable : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , optional : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , invalid : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available
    , doneIcon : M3e.Build.Internal.Available
    , editIcon : M3e.Build.Internal.Available
    , errorIcon : M3e.Build.Internal.Available
    , hint : M3e.Build.Internal.Available
    , error : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-step>` with the required fields.
-}
step :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    -> Builder AttrCaps SlotCaps msg kind
step req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Step.step
                    (List.map M3e.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            [ M3e.Element.toNode req_.content ]
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    M3e.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the step has been completed. (default: `false`)
-}
completed :
    Bool
    -> Builder { a | completed : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | completed : M3e.Build.Internal.Used } s msg kind
completed v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Step.completed v_))
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
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Step.disabled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the step is editable and users can return to it after completion. (default: `false`)
-}
editable :
    Bool
    -> Builder { a | editable : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | editable : M3e.Build.Internal.Used } s msg kind
editable v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Step.editable v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Step.for v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the step is optional. (default: `false`)
-}
optional :
    Bool
    -> Builder { a | optional : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | optional : M3e.Build.Internal.Used } s msg kind
optional v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Step.optional v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is selected. (default: `false`)
-}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | selected : M3e.Build.Internal.Used } s msg kind
selected v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Step.selected v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the step has an error. (default: `false`)
-}
invalid :
    Bool
    -> Builder { a | invalid : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | invalid : M3e.Build.Internal.Used } s msg kind
invalid v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Step.invalid v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the selected state changes.
-}
onBeforeinput :
    (Bool -> msg)
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg kind
onBeforeinput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Step.onBeforeinput v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state changes.
-}
onInput :
    (Bool -> msg)
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg kind
onInput v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Step.onInput v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected state changes.
-}
onChange :
    (Bool -> msg)
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Step.onChange v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the element is clicked.
-}
onClick :
    msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Step.onClick v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `icon` slot.
-}
icon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg kind
icon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `done-icon` slot.
-}
doneIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> Builder a { s | doneIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | doneIcon : M3e.Build.Internal.Used } msg kind
doneIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "done-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `edit-icon` slot.
-}
editIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> Builder a { s | editIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | editIcon : M3e.Build.Internal.Used } msg kind
editIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "edit-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `error-icon` slot.
-}
errorIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> Builder a { s | errorIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | errorIcon : M3e.Build.Internal.Used } msg kind
errorIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "error-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `hint` slot.
-}
hint :
    M3e.Element.Element { text : M3e.Token.Supported } msg
    -> Builder a { s | hint : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | hint : M3e.Build.Internal.Used } msg kind
hint el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "hint" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `error` slot.
-}
error :
    M3e.Element.Element { text : M3e.Token.Supported } msg
    -> Builder a { s | error : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | error : M3e.Build.Internal.Used } msg kind
error el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "error" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-step>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> M3e.Element.Element { step : M3e.Token.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
