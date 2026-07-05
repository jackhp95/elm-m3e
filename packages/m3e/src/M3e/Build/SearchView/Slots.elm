module M3e.Build.SearchView.Slots exposing ( searchIconIcon, closeIconIcon, clearIconIcon )

{-|
Slot setters for `M3e.Build.SearchView`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs searchIconIcon, closeIconIcon, clearIconIcon
-}


import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Build.SearchView
import M3e.Node


searchIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.SearchView.Builder pa { ps
        | searchIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SearchView.Builder pa { ps
        | searchIcon : M3e.Build.Internal.Used
    } msg pk
searchIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


closeIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.SearchView.Builder pa { ps
        | closeIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SearchView.Builder pa { ps
        | closeIcon : M3e.Build.Internal.Used
    } msg pk
closeIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


clearIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.SearchView.Builder pa { ps
        | clearIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SearchView.Builder pa { ps
        | clearIcon : M3e.Build.Internal.Used
    } msg pk
clearIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `search-icon` slot of `SearchView`. -}
searchIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.SearchView.Builder pa { ps
        | searchIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SearchView.Builder pa { ps
        | searchIcon : M3e.Build.Internal.Used
    } msg pk
searchIconIcon =
    searchIcon_core


{-| Place a `Icon` in the `close-icon` slot of `SearchView`. -}
closeIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.SearchView.Builder pa { ps
        | closeIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SearchView.Builder pa { ps
        | closeIcon : M3e.Build.Internal.Used
    } msg pk
closeIconIcon =
    closeIcon_core


{-| Place a `Icon` in the `clear-icon` slot of `SearchView`. -}
clearIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.SearchView.Builder pa { ps
        | clearIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SearchView.Builder pa { ps
        | clearIcon : M3e.Build.Internal.Used
    } msg pk
clearIconIcon =
    clearIcon_core