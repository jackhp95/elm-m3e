module M3e.Html.InputChipSet exposing (inputChipSet, disabled, name, required, vertical, onChange)

{-| Middle layer for `<m3e-input-chip-set>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.InputChipSet` module for everyday use.

@docs inputChipSet, disabled, name, required, vertical, onChange

-}

import Html
import Json.Decode
import M3e.Raw.InputChipSet
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A container that transforms user input into a cohesive set of interactive chips, supporting entry, editing, and removal of discrete values.

**Component Info:**

  - **Extends:** `M3eChipSetElement` from `/src/chips/ChipSetElement`

**Events:**

  - `change`: Dispatched when a chip is added to, or removed from, the set.

**Slots:**

  - `input`: Renders the input element used to add new chips to the set.

-}
inputChipSet :
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
    -> List (Html.Html msg)
    -> Html.Html msg
inputChipSet attributes children =
    M3e.Raw.InputChipSet.inputChipSet
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.InputChipSet.disabled


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    Markup.Html.Attr.Internal.attribute M3e.Raw.InputChipSet.name


{-| Whether a value is required for the element. (default: `false`)
-}
required : Bool -> Markup.Html.Attr.Attr { c | required : M3e.Token.Supported } msg
required =
    Markup.Html.Attr.Internal.attribute M3e.Raw.InputChipSet.required


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical : Bool -> Markup.Html.Attr.Attr { c | vertical : M3e.Token.Supported } msg
vertical =
    Markup.Html.Attr.Internal.attribute M3e.Raw.InputChipSet.vertical


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.InputChipSet.onChange
        (Json.Decode.succeed f_)
