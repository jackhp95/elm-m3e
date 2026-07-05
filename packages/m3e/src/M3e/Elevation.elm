module M3e.Elevation exposing ( view, disabled, for, level )

{-|
Visually depicts elevation using a shadow.

**Component Info:**
- **Extends:** `LitElement`

@docs view, disabled, for, level
-}


import M3e.Cem.Attr
import M3e.Cem.Elevation
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-elevation>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , level : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | elevation : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Elevation.elevation
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether hover and press events will not trigger changes in elevation, when attached to an interactive element. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Elevation.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Elevation.for


{-| The level at which to visually depict elevation. (default: `null`) -}
level : Int -> M3e.Cem.Attr.Attr { c | level : M3e.Value.Supported } msg
level =
    M3e.Cem.Elevation.level