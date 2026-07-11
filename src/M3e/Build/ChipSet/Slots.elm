module M3e.Build.ChipSet.Slots exposing (suggestionChip, inputChip, filterChip, assistChip, chip)

{-| Slot setters for `M3e.Build.ChipSet`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs suggestionChip, inputChip, filterChip, assistChip, chip

-}

import M3e.Build.AssistChip
import M3e.Build.Chip
import M3e.Build.ChipSet
import M3e.Build.FilterChip
import M3e.Build.InputChip
import M3e.Build.Internal
import M3e.Build.SuggestionChip
import M3e.Node


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.ChipSet.Builder pa ps msg pk
    -> M3e.Build.ChipSet.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `SuggestionChip` in the `unnamed` slot of `ChipSet`.
-}
suggestionChip :
    M3e.Build.SuggestionChip.Builder ca cs msg ck
    -> M3e.Build.ChipSet.Builder pa ps msg pk
    -> M3e.Build.ChipSet.Builder pa ps msg pk
suggestionChip =
    unnamed_core


{-| Place a `InputChip` in the `unnamed` slot of `ChipSet`.
-}
inputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.ChipSet.Builder pa ps msg pk
    -> M3e.Build.ChipSet.Builder pa ps msg pk
inputChip =
    unnamed_core


{-| Place a `FilterChip` in the `unnamed` slot of `ChipSet`.
-}
filterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.ChipSet.Builder pa ps msg pk
    -> M3e.Build.ChipSet.Builder pa ps msg pk
filterChip =
    unnamed_core


{-| Place a `AssistChip` in the `unnamed` slot of `ChipSet`.
-}
assistChip :
    M3e.Build.AssistChip.Builder ca cs msg ck
    -> M3e.Build.ChipSet.Builder pa ps msg pk
    -> M3e.Build.ChipSet.Builder pa ps msg pk
assistChip =
    unnamed_core


{-| Place a `Chip` in the `unnamed` slot of `ChipSet`.
-}
chip :
    M3e.Build.Chip.Builder ca cs msg ck
    -> M3e.Build.ChipSet.Builder pa ps msg pk
    -> M3e.Build.ChipSet.Builder pa ps msg pk
chip =
    unnamed_core
