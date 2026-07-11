module M3e.Html.StateLayer exposing (stateLayer, disabled, disableHover, for)

{-| Middle layer for `<m3e-state-layer>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.StateLayer` module for everyday use.

@docs stateLayer, disabled, disableHover, for

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.StateLayer
import M3e.Token


{-| Provides focus and hover state layer treatment for an interactive element.

**Component Info:**

  - **Extends:** `LitElement`

-}
stateLayer :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disableHover : M3e.Token.Supported
            , for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
stateLayer attributes children =
    M3e.Raw.StateLayer.stateLayer
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether hover and focus events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.StateLayer.disabled


{-| Whether hover events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disableHover : Bool -> M3e.Html.Attr.Attr { c | disableHover : M3e.Token.Supported } msg
disableHover =
    M3e.Html.Attr.Internal.attribute M3e.Raw.StateLayer.disableHover


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> M3e.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.Attr.Internal.attribute M3e.Raw.StateLayer.for
