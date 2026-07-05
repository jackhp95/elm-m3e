module M3e.Build.Accordion.Slots exposing ( expansionPanel )

{-|
Slot setters for `M3e.Build.Accordion`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs expansionPanel
-}


import M3e.Build.Accordion
import M3e.Build.ExpansionPanel
import M3e.Build.Internal
import M3e.Node


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Accordion.Builder pa ps msg pk
    -> M3e.Build.Accordion.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `ExpansionPanel` in the `unnamed` slot of `Accordion`. -}
expansionPanel :
    M3e.Build.ExpansionPanel.Builder ca cs msg ck
    -> M3e.Build.Accordion.Builder pa ps msg pk
    -> M3e.Build.Accordion.Builder pa ps msg pk
expansionPanel =
    unnamed_core