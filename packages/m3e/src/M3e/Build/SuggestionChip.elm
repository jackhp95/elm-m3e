module M3e.Build.SuggestionChip exposing
    ( Builder, AttrCaps, SlotCaps, suggestionChip, disabled, disabledInteractive
    , name, type_, value, variant, build
    )

{-|
The ⑤ Build shape for `<m3e-suggestion-chip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SuggestionChip as SuggestionChip`.

@docs Builder, AttrCaps, SlotCaps, suggestionChip, disabled, disabledInteractive
@docs name, type_, value, variant, build
-}


import M3e.Action
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.SuggestionChip
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-suggestion-chip>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | suggestionChip : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , disabledInteractive : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , type_ : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-suggestion-chip>` with the required fields. -}
suggestionChip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
    , action :
        M3e.Action.Action { click : M3e.Value.Supported
        , link : M3e.Value.Supported
        , menuTrigger : M3e.Value.Supported
        , dialogTrigger : M3e.Value.Supported
        , fabMenuTrigger : M3e.Value.Supported
        , bottomSheetTrigger : M3e.Value.Supported
        , navRailToggle : M3e.Value.Supported
        , drawerToggle : M3e.Value.Supported
        , datepickerToggle : M3e.Value.Supported
        , dialogAction : M3e.Value.Supported
        , bottomSheetAction : M3e.Value.Supported
        , richTooltipAction : M3e.Value.Supported
        , stepperReset : M3e.Value.Supported
        , stepperPrevious : M3e.Value.Supported
        } msg
    }
    -> Builder AttrCaps SlotCaps msg kind
suggestionChip req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.SuggestionChip.suggestionChip
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.append
                  (List.map M3e.Cem.Attr.forget (M3e.Action.toAttrs req_.action)
                  )
                  (List.map M3e.Cem.Attr.forget [])
             )
             [ M3e.Action.wrapContent
                 req_.action
                 (M3e.Element.toNode req_.content)
             ]
        )


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SuggestionChip.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> Builder { a
        | disabledInteractive : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { disabledInteractive : M3e.Build.Internal.Used } s msg kind
disabledInteractive v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.SuggestionChip.disabledInteractive v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg kind
    -> Builder { name : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SuggestionChip.name v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The type of the element. (default: `"button"`) -}
type_ :
    M3e.Value.Value { button : M3e.Value.Supported
    , reset : M3e.Value.Supported
    , submit : M3e.Value.Supported
    }
    -> Builder { a | type_ : M3e.Build.Internal.Available } s msg kind
    -> Builder { type_ : M3e.Build.Internal.Used } s msg kind
type_ v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SuggestionChip.type_ v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A string representing the value of the chip. -}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SuggestionChip.value v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the chip. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.SuggestionChip.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-suggestion-chip>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { suggestionChip : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)