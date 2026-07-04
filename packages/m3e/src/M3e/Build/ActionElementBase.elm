module M3e.Build.ActionElementBase exposing
    ( Builder, AttrCaps, SlotCaps, actionElementBase, build
    )

{-|
The ⑤ Build shape for `<ActionElementBase>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ActionElementBase as ActionElementBase`.

@docs Builder, AttrCaps, SlotCaps, actionElementBase, build
-}


import M3e.Cem.ActionElementBase
import M3e.Cem.Attr
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<ActionElementBase>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { phantomMsg_ : Maybe msg }


{-| Seed a `Builder` for `<ActionElementBase>`. -}
actionElementBase : Builder AttrCaps SlotCaps msg
actionElementBase =
    Builder { phantomMsg_ = Nothing }


{-| Build the `<ActionElementBase>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind
        | actionElementBase : M3e.Value.Supported
    } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ActionElementBase.actionElementBase
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat [])
             (List.concat [])
        )