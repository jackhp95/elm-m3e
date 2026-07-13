module M3e.Html.Elevation exposing (elevation, disabled, for, level)

{-| Middle layer for `<m3e-elevation>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Elevation` module for everyday use.

@docs elevation, disabled, for, level

-}

import Html
import M3e.Raw.Elevation
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| Visually depicts elevation using a shadow.

**Component Info:**

  - **Extends:** `LitElement`

-}
elevation :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , level : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
elevation attributes children =
    M3e.Raw.Elevation.elevation
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether hover and press events will not trigger changes in elevation, when attached to an interactive element. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Elevation.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Elevation.for


{-| The level at which to visually depict elevation. (default: `null`)
-}
level : Int -> Markup.Html.Attr.Attr { c | level : M3e.Token.Supported } msg
level =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Elevation.level
