module M3e.AppBar exposing
    ( view, centered, for, size, leading, title
    , subtitle, trailing
    )

{-|
A bar, placed a the top of a screen, used to help users navigate through an application.

**Slots:**
- `leading`: Renders content positioned at the start of the bar.
- `subtitle`: Renders the subtitle of the bar.
- `title`: Renders the title of the bar.
- `trailing`: Renders one or more action buttons aligned to the end of the bar.
- `leading-icon`: Deprecated: use the `leading` slot.
- `trailing-icon`: Deprecated: use the `trailing` slot.

@docs view, centered, for, size, leading, title
@docs subtitle, trailing
-}


import M3e.Cem.AppBar
import M3e.Cem.Attr
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-app-bar>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { centered : M3e.Value.Supported
    , for : M3e.Value.Supported
    , size : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { leading : M3e.Value.Supported
    , title : M3e.Value.Supported
    , subtitle : M3e.Value.Supported
    , trailing : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | appBar : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.AppBar.appBar (List.map M3e.Cem.Attr.forget erased) ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether the title and subtitle are centered. (default: `false`) -}
centered : Bool -> M3e.Cem.Attr.Attr { c | centered : M3e.Value.Supported } msg
centered =
    M3e.Cem.AppBar.centered


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.AppBar.for


{-| The size of the bar. (default: `"small"`) -}
size :
    M3e.Value.Value { large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size =
    M3e.Cem.AppBar.size


{-| Place content in the `leading` slot. -}
leading :
    M3e.Element.Element { iconButton : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | leading : M3e.Value.Supported } msg
leading el =
    M3e.Content.slot "leading" el


{-| Place content in the `title` slot. -}
title :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | title : M3e.Value.Supported } msg
title el =
    M3e.Content.slot "title" el


{-| Place content in the `subtitle` slot. -}
subtitle :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | subtitle : M3e.Value.Supported } msg
subtitle el =
    M3e.Content.slot "subtitle" el


{-| Place content in the `trailing` slot. -}
trailing :
    M3e.Element.Element { iconButton : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | trailing : M3e.Value.Supported } msg
trailing el =
    M3e.Content.slot "trailing" el