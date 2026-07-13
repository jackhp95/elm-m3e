module M3e.Html.StateLayer exposing (stateLayer, disabled, disableHover, for)

{-| Middle layer for `<m3e-state-layer>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.StateLayer` module for everyday use.

@docs stateLayer, disabled, disableHover, for

-}

import Html
import M3e.Raw.StateLayer
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| Provides focus and hover state layer treatment for an interactive element.

**Component Info:**

  - **Extends:** `LitElement`

-}
stateLayer :
    List
        (Markup.Html.Attr.Attr
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
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether hover and focus events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.StateLayer.disabled


{-| Whether hover events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disableHover : Bool -> Markup.Html.Attr.Attr { c | disableHover : M3e.Token.Supported } msg
disableHover =
    Markup.Html.Attr.Internal.attribute M3e.Raw.StateLayer.disableHover


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    Markup.Html.Attr.Internal.attribute M3e.Raw.StateLayer.for
