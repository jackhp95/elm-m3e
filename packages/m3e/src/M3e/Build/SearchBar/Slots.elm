module M3e.Build.SearchBar.Slots exposing ( clearIconIcon )

{-|
Slot setters for `M3e.Build.SearchBar`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs clearIconIcon
-}


import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Build.SearchBar
import M3e.Node


clearIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.SearchBar.Builder pa { ps
        | clearIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SearchBar.Builder pa { ps
        | clearIcon : M3e.Build.Internal.Used
    } msg pk
clearIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `clear-icon` slot of `SearchBar`. -}
clearIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.SearchBar.Builder pa { ps
        | clearIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SearchBar.Builder pa { ps
        | clearIcon : M3e.Build.Internal.Used
    } msg pk
clearIconIcon =
    clearIcon_core