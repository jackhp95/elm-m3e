module M3e.Build.MultiYearView exposing
    ( Builder, AttrCaps, SlotCaps, multiYearView, attr, active
    , today, date, activeDate, minDate, maxDate, onChange, onActiveChange
    , build
    )

{-|
The ⑤ Build shape for `<m3e-multi-year-view>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MultiYearView as MultiYearView`.

@docs Builder, AttrCaps, SlotCaps, multiYearView, attr, active
@docs today, date, activeDate, minDate, maxDate, onChange
@docs onActiveChange, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.MultiYearView
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-multi-year-view>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | multiYearView : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { active : M3e.Build.Internal.Available
    , today : M3e.Build.Internal.Available
    , date : M3e.Build.Internal.Available
    , activeDate : M3e.Build.Internal.Available
    , minDate : M3e.Build.Internal.Available
    , maxDate : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onActiveChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-multi-year-view>`. -}
multiYearView : Builder AttrCaps SlotCaps msg kind
multiYearView =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.MultiYearView.multiYearView
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times. -}
attr :
    M3e.Cem.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget a_)
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the view is active. (default: `false`) -}
active :
    Bool
    -> Builder { a | active : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | active : M3e.Build.Internal.Used } s msg kind
active v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.MultiYearView.active v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Today's date. (default: `new Date()`) -}
today :
    String
    -> Builder { a | today : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | today : M3e.Build.Internal.Used } s msg kind
today v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.MultiYearView.today v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The selected date. (default: `null`) -}
date :
    String
    -> Builder { a | date : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | date : M3e.Build.Internal.Used } s msg kind
date v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.MultiYearView.date v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The active date. (default: `new Date()`) -}
activeDate :
    String
    -> Builder { a | activeDate : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | activeDate : M3e.Build.Internal.Used } s msg kind
activeDate v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.MultiYearView.activeDate v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| The minimum date that can be selected. (default: `null`) -}
minDate :
    String
    -> Builder { a | minDate : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | minDate : M3e.Build.Internal.Used } s msg kind
minDate v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.MultiYearView.minDate v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The maximum date that can be selected. (default: `null`) -}
maxDate :
    String
    -> Builder { a | maxDate : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | maxDate : M3e.Build.Internal.Used } s msg kind
maxDate v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.MultiYearView.maxDate v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Listen for `change` events. -}
onChange :
    msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.MultiYearView.onChange v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Listen for `active-change` events. -}
onActiveChange :
    msg
    -> Builder { a | onActiveChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onActiveChange : M3e.Build.Internal.Used } s msg kind
onActiveChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.MultiYearView.onActiveChange v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-multi-year-view>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { multiYearView : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)