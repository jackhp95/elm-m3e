module M3e.InputChipSet exposing
    ( view, disabled, name, required, vertical, onChange
    , input
    )

{-| A container that transforms user input into a cohesive set of interactive chips, supporting entry, editing, and removal of discrete values.

**Component Info:**

  - **Extends:** `M3eChipSetElement` from `/src/chips/ChipSetElement`

**Events:**

  - `change`: Dispatched when a chip is added to, or removed from, the set.

**Slots:**

  - `input`: Renders the input element used to add new chips to the set.

@docs view, disabled, name, required, vertical, onChange
@docs input

-}

import M3e.Html.InputChipSet
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-input-chip-set>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , name : M3e.Token.Supported
            , required : M3e.Token.Supported
            , vertical : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { inputChip : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | inputChipSet : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.InputChipSet.inputChipSet
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.InputChipSet.disabled


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.InputChipSet.name


{-| Whether a value is required for the element. (default: `false`)
-}
required : Bool -> Markup.Html.Attr.Attr { c | required : M3e.Token.Supported } msg
required =
    M3e.Html.InputChipSet.required


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical : Bool -> Markup.Html.Attr.Attr { c | vertical : M3e.Token.Supported } msg
vertical =
    M3e.Html.InputChipSet.vertical


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.InputChipSet.onChange


{-| Place content in the `input` slot.
-}
input : Markup.Element.Element any msg -> Markup.Element.Element k msg
input el =
    Markup.Element.Internal.placeSlot "input" el
