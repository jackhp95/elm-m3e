module M3e.Elevation exposing (view, disabled, for, level)

{-| Visually depicts elevation using a shadow.

**Component Info:**

  - **Extends:** `LitElement`

@docs view, disabled, for, level

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.Elevation
import M3e.Node
import M3e.Token


{-| Build the `<m3e-elevation>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , level : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | elevation : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.Elevation.elevation
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| Whether hover and press events will not trigger changes in elevation, when attached to an interactive element. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Elevation.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> M3e.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.Elevation.for


{-| The level at which to visually depict elevation. (default: `null`)
-}
level : Int -> M3e.Html.Attr.Attr { c | level : M3e.Token.Supported } msg
level =
    M3e.Html.Elevation.level
